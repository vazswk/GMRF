function Ht = ternary_entropyf(pM1, pP1)
        pM1 = pM1(:);
        pP1 = pP1(:);
        p0 = 1-pM1-pP1;
        
        zeroConst = 10*eps;
        
        HM1 = zeros( size(pM1) );
        H0  = zeros( size(p0) );
        HP1 = zeros( size(pP1) );
        
        valid = ~(pM1 < zeroConst) & ~(1-pM1 < zeroConst);
        HM1( valid ) = -(pM1(valid).*log2(pM1(valid)));
        
        valid = ~(p0 < zeroConst) & ~(1-p0 < zeroConst);
        H0( valid ) = -(p0(valid).*log2(p0(valid)));
        
        valid = ~(pP1 < zeroConst) & ~(1-pP1 < zeroConst);
        HP1( valid ) = -(pP1(valid).*log2(pP1(valid)));
                        
        Ht = HM1+H0+HP1;
        Ht = sum(Ht);
    end