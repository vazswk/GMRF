%% mian.m
clc;clear all;
currdir = pwd;
indir=[currdir '\images\'];
outdir=[currdir '\stego_images\'];
%mkdir(outdir);c
capa = 0.2;
sweeps = 4;
beta_T = 0.1;
H = 0; % Choose H=0 for optimal simulator. 
rang_min = 0; 
rang_max_itera = 1e6;% lamda 取值范围两个界限,根据实际情况设定 :原始修改率
biao = f_generate_Table_2; 
flist = dir([indir '\*.pgm']);
flen = length(flist);
fprintf('%s%d\n', 'the num of the files: ',flen);

   for i = 1
       fprintf('%d%s\n',i, ['   processing image: ' flist(i).name]);
       out_file_dir = [ outdir flist(i).name];
       in_file_name = [indir '1013.pgm'];
       cover = double(imread(in_file_name));    
      %% 计算方差
tic
       WienerResidual = cover - wiener2(cover,[2,2]);   
       BlockSize = 9;
       Degree = 9;
       [Variance, Residuals] = Var_2D (WienerResidual, BlockSize, Degree);  %
      %% 计算协方差 
       [num_row, num_col] = size(cover);
       Covariance = Covar_2D (Residuals,num_row, num_col,BlockSize, Degree);   % L,R,U,D 四个方向
      %% 相关系数
       CORR = Corr_2D( Covariance, Variance);
      %% 计算初始修改率     
       Ori_beta = rand(512,512)/1000; 
      %% 优化嵌入 
      
       [stego_filter, prob_filter, stego_no_filter, prob_no_filter] = GMRF(cover,capa,rang_min,rang_max_itera,biao,Variance, CORR, Ori_beta, sweeps, beta_T);
       D = sum(sum(abs(cover - double(stego_no_filter))))
       stego = uint8(stego_no_filter);
       imwrite(stego,out_file_dir,'pgm');       
       show_s_dif(cover,stego);
toc   
       
   end
% hist_beta(prob_filter);
 
 