reg_loc_lin <- function (X, lambda, x_0) {
    X.centre <- (X-x_0)/lambda

    KE <- rep(NA,100)
    K_lamda <- rep(NA,100)
    for(i in 1:100) {
        a = abs(X.centre[i]) <= 1
        KE[i] <- 3/4*(1-X.centre[i]^2)*a
        K_lamda[i] <- KE[i]/lambda
    }

    #calcul des s_J:
    S_0 <- sum(K_lamda*(X-x_0)^0)
    S_1 <- sum(K_lamda*(X-x_0)^1)
    S_2 <- sum(K_lamda*(X-x_0)^2)

    #calcul de l.x0:

    denominateur <- S_0*S_2-S_1^2
    numerateur <- K_lamda*(S_2-S_1*(X-x_0))
    numerateur/denominateur
}
