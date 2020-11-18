function [Variance, Residuals] = Var_2D (WienerResidual, BlockSize, Degree)
[Variance, Residuals] = VarianceEstimationDCT2D(WienerResidual, BlockSize, Degree);
Variance(Variance< 0.01) = 0.01;
