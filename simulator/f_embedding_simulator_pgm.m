function [ stegoB, pChange] = f_embedding_simulator_pgm(cover, costmat, payload)

%% Get embedding costs
% inicialization
cover = double(cover);
wetCost = 10^10;
% compute embedding costs \rho
rhoA = costmat;
rhoA(rhoA > wetCost) = wetCost; % threshold on the costs
rhoA(isnan(rhoA)) = wetCost; % if all xi{} are zero threshold the cost 
rhoP1 = rhoA;
rhoM1 = rhoA;
rhoP1(cover==255) = wetCost; % do not embed +1 if the pixel has max value
rhoM1(cover==0) = wetCost; % do not embed -1 if the pixel has min value
rho0  = zeros( size( cover ) );
[stegoB, pChange] = EmbeddingSimulator(cover, rhoM1, rho0, rhoP1, payload);

          
