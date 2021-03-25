n <- 8
s <- 2
l <- 3
xi <- 6.28
xs <- seq(0,5,length.out=300)
matplot(xs, cbind(dgamma(xs,n+s,xi+l), dnorm(xs,(n+s)/(xi+l),sqrt(n+s)/(xi+l))),type='l',col=c(1,3))

rbind(c(1,2,3),c(2,3,4))
cbind(c(1,2,3),c(2,3,4))
matrix(c(1,2,3,2,3,4),2)
