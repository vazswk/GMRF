function Ht = f_cal_ternary_entropy(pP1, pM1)
p0 = 1-pP1-pM1;
P = [p0(:); pP1(:); pM1(:)];
H = -((P).*log2(P));
H((P<eps) | (P > 1-eps)) = 0;
Ht = sum(H);
end