function [pM1, p0, pP1] = GetPchange(lambda, rhoM1, rho0, rhoP1)

    pM1 = (exp(lambda.*(rhoM1-rhoP1)) + exp(lambda.*(rhoM1-rho0)) + 1).^(-1);
    pP1 = (exp(lambda.*(rhoP1-rhoM1)) + exp(lambda.*(rhoP1-rho0)) + 1).^(-1);
    p0 = 1-pM1-pP1;

end