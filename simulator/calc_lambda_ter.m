function lambda = calc_lambda_ter(rhoM1, rho0, rhoP1, message_length, n)
        l3 = 1e+3;
        m3 = double(message_length)*2;
        iterations = 0;
        while m3 > message_length
            l3 = l3 * 2;
            [pM1, p0, pP1] = GetPchange(l3, rhoM1, rho0, rhoP1);
            m3 = ternary_entropyf(pM1, pP1);
            iterations = iterations + 1;
            if (iterations > 10)
                lambda = l3;
                return;
            end
        end        
        l1 = 0; 
        m1 = double(n)*2;        
        lambda = 0;
        
        alpha = double(message_length)/n;
        % limit search to 100 iterations
        % and require that relative payload embedded is roughly within 1/1000 of the required relative payload        
        while  (double(m1-m3)/n > alpha/1000.0 ) && (iterations<100)
            lambda = l1+(l3-l1)/2; 
            [pM1, p0, pP1] = GetPchange(lambda, rhoM1, rho0, rhoP1);
            m2 = ternary_entropyf(pM1, pP1);
            if (~isreal(m2))
                disp(m2);
            end
            if m2 < message_length
    			l3 = lambda;
    			m3 = m2;
            else
    			l1 = lambda;
    			m1 = m2;
            end
    		iterations = iterations + 1;
        end
    end