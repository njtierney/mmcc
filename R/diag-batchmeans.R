#' Batch Means Standard Errors
#'
#' Calculate Monte Carlo Standard Errors Using Batch Means
#'
#' @param x 'mcmc.list' or 'data.table' object
#' @param b_size character, method for determining size of batch (see Details)
#' @param warn logical, give a warning of there are too few samples in the MCMC output
#'
#' @details For the batch size, the options are 'sqroot', for using the using the square root of the MCMC output length, or 'cuberoot', for using the cube root of the output length. The default is 'sqroot'.
#'
#' @references Galin L. Jones, Murali Haran, Brian S. Caffo, and Ronald Neath (2006). "Fixed-Width Output Analysis for Markov Chain Monte Carlo," Journal of the American Statistical Association, 101, 1537--1547
#'
#' @import data.table
#' @examples
#' library(coda)
#' data(line)
#' r <- diag_mc_stderr(line)
#' r
#'
#' @export
diag_mc_stderr <- function(x, b_size = "sqroot", warn = TRUE) {
    if(inherits(x, "mcmc.list"))
        x <- mcmc_to_dt(x)
    x_split <- split(x, list(x$chain, x$parameter))
    stats <- lapply(x_split, function(v) {
        bm <- bmeans(v$value, b_size, warn)
        data.frame(parameter = v$parameter[1],
                   chain = v$chain[1],
                   mean = mean(v$value),
                   value = bm$se)
    })
    x_df <- rbindlist(stats)
    x_df
}


## consistent batch means and imse estimators of Monte Carlo standard errors
## author: Murali Haran

## An R function for computing consistent batch means estimate of standard error from:
## Citation: Galin L. Jones, Murali Haran, Brian S. Caffo, and Ronald Neath, "Fixed-Width Output Analysis for Markov Chain Monte Carlo" (2006), Journal of the American Statistical Association, 101:1537--1547

## input: vals, a vector of N values (from a Markov chain),bs=batch size
## default bs (batch size) is "sqroot"=> number of batches is the square root of the run length
## if bs is "cuberoot", number of batches is the cube root of the run length
## output: list consisting of estimate of expected value and the Monte Carlo standard error of the estimate

## NOTE: YOU DO NOT NEED TO DOWNLOAD THIS FILE TO RUN BATCHMEANS IN R
## SIMPLY USE THE COMMAND BELOW FROM YOUR R COMMAND LINE
## source("http://www.stat.psu.edu/~mharan/batchmeans.R")

# new version: Sep.12, 2005
bmeans <- function(vals,bs="sqroot",warn=FALSE)
{
    N <- length(vals)
    if (N<1000)
    {
        if (warn) # if warning
            warning("likely too few samples (less than 1000) for estimating Monte Carlo standard errors")
        if (N<10)
            stop("too few samples (less than 10) for estimating Monte Carlo standard errors")
    }

    if (bs=="sqroot")
    {
        b <- floor(sqrt(N)) # batch size
        a <- floor(N/b) # number of batches
    }
    else
        if (bs=="cuberoot")
        {
            b <- floor(N^(1/3)) # batch size
            a <- floor(N/b) # number of batches
        }
    else # batch size provided
    {
        stopifnot(is.numeric(bs))
        b <- floor(bs) # batch size
        if (b > 1) # batch size valid
            a <- floor(N/b) # number of batches
        else
            stop("batch size invalid (bs=",bs,")")
    }

    Ys <- sapply(1:a, function(k) return(mean(vals[((k-1)*b+1):(k*b)])))

    muhat <- mean(Ys)
    sigmahatsq <- b*sum((Ys-muhat)^2)/(a-1)

    bmse <- sqrt(sigmahatsq/N)

    list(est = muhat, se = bmse)
}


## Geyer's initial monotone positive sequence estimator (Statistical Science, 1992)
## input: Markov chain output (vector)
## output: monte carlo standard error estimate for chain
imse <- function(outp,asymvar=FALSE)
{
    chainAC <- acf(outp,type="covariance",plot = FALSE)$acf ## USE AUTOCOVARIANCES
    AClen <- length(chainAC)
    gammaAC <- chainAC[1:(AClen-1)]+chainAC[2:AClen]

    m <- 1
    currgamma <- gammaAC[1]
    k <- 1
    while ((k<length(gammaAC)) && (gammaAC[k+1]>0) && (gammaAC[k]>=gammaAC[k+1]))
        k <- k +1

    if (k==length(gammaAC)) # added up until the very last computed autocovariance
        cat("WARNING: may need to compute more autocovariances for imse\n")
    sigmasq <- -chainAC[1]+2*sum(gammaAC[1:k])

    if (asymvar) # return asymptotic variance
        return(sigmasq)

    mcse <- sqrt(sigmasq/length(outp))
    return(mcse)
}

imsemat=function(mcmat,skip=NA)
{
    if (!is.na(skip))
        num=ncol(mcmat)-length(skip)
    else
        num=ncol(mcmat)

    imsevals=matrix(NA,num,2,dimnames=list(paste("V",seq(1,num),sep=""),c("est","se"))) # first col=est, second col=MS s.error

    mcmat=mcmat[-skip] # remove columns to be skipped
    imseres=apply(mcmat,2,imse)
    for (i in 1:num)
    {
        imsevals[i,]=c(mean(mcmat[,i]),imseres[i])
    }
    return(imsevals)
}

## plot how Monte Carlo estimates change with increase in sample size
## input: samp (sample vector) and g (where E(g(x)) is quantity of interest)
## output: plot of estimate over time (increasing sample size)
estvssamp = function(samp, g=mean)
{
    if (length(samp)<100)
        batchsize = 1
    else
        batchsize = length(samp)%/%100

    est = c()
    for (i in seq(batchsize,length(samp),by=batchsize))
    {
        est = c(est, g(samp[1:i]))
    }

    ts.plot(est,main=paste("Monte Carlo estimates with increasing samples (incr of ",batchsize,")\n",sep=""))
    plot(seq(batchsize,length(samp),by=batchsize),est,main=paste("Monte Carlo estimates vs. sample size\n"),type="l",xlab="sample size",ylab="MC estimate")
}

