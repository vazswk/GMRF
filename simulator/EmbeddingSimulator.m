function [y, pChange] = EmbeddingSimulator(x, rhoM1, rho0, rhoP1, payload)

x = double(x);
n = numel(x);
m = payload * n;

lambda = calc_lambda_ter(rhoM1, rho0, rhoP1, m, n);
[pChangeM1, pChange0, pChangeP1] = GetPchange(lambda, rhoM1, rho0, rhoP1);
if nargin == 6
   RandStream.setGlobalStream(RandStream('mt19937ar','seed',seed));
else
   RandStream.setGlobalStream(RandStream('mt19937ar','Seed',sum(100*clock)));
end
randChange = rand(size(x));
y = x;
y(randChange < pChangeP1) = y(randChange < pChangeP1) + 1;
y(randChange >= pChangeP1 & randChange < pChangeP1+pChangeM1) = y(randChange >= pChangeP1 & randChange < pChangeP1+pChangeM1) - 1;

pChange = (pChangeP1+pChangeM1)/2;

end

