function [stego_Filter,pChange_Filter,stego_no_Filter,pchange_no_Filter] = GMRF(cover,alaph,rang_min,rang_max,biao,Variance, CORR, Ori_beta, sweeps, beta_T)
cover = double(cover); %% 原始的cover为uint8型
%%
[weight,prob] = f_cal_cost_GMRF(alaph, rang_min, rang_max, biao, Variance, CORR, Ori_beta, sweeps, beta_T);% 计算+1或者-1的失真

%% Simulate embedding
HW =  fspecial('average',[7 7]);
padsize = floor(size(HW)/2);
weightPadded = padarray(weight, padsize, 'symmetric');% add padding
weightF = imfilter(weightPadded, HW ,'symmetric','same'); 
weight = weightF(1+padsize: end-padsize,1+padsize: end-padsize);

[~, pChange_Filter] = f_embedding_simulator_pgm(cover, weight,alaph);
pChange_Filter_r = reshape(pChange_Filter,[1,numel(cover)]);
stego_Filter = cover;
beta_Filter = 2 * pChange_Filter_r;

RandStream.setGlobalStream(RandStream('mt19937ar','seed',123));
r = rand(1,numel(cover));
ModifPM1_Filter = (r < beta_Filter);                % cover elements to be modified by +-1
RandStream.setGlobalStream(RandStream('mt19937ar','seed',456));
r = rand(1,numel(cover));
stego_Filter(ModifPM1_Filter) = cover(ModifPM1_Filter) + 2*(round(r(ModifPM1_Filter))) - 1; % Modifying X by +-1
stego_Filter(stego_Filter>255) = 253;                    % Taking care of boundary cases
stego_Filter(stego_Filter<0)   = 2;

% sweeps no filter
pchange_no_Filter = prob;
prob_no_Filter_r = reshape(pchange_no_Filter,[1,numel(cover)]);
stego_no_Filter = cover;
beta_no_Filter = 2 * prob_no_Filter_r;
RandStream.setGlobalStream(RandStream('mt19937ar','seed',123));
r = rand(1,numel(cover));
ModifPM1_no_Filter = (r < beta_no_Filter);                % cover elements to be modified by +-1
RandStream.setGlobalStream(RandStream('mt19937ar','seed',456));
r = rand(1,numel(cover));
stego_no_Filter(ModifPM1_no_Filter) = cover(ModifPM1_no_Filter) + 2*(round(r(ModifPM1_no_Filter))) - 1; % Modifying X by +-1
stego_no_Filter(stego_no_Filter>255) = 253;                    % Taking care of boundary cases
stego_no_Filter(stego_no_Filter<0)   = 2;


