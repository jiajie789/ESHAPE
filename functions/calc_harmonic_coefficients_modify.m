function output = calc_harmonic_coefficients_modify(ai, n, mode)

% This function will calculate the n-th set of four harmonic coefficients.
% The output is [an bn cn dn]
    k = size(ai, 2);
    d = calc_traversal_dist(ai);
    if(mode == 0)
        edist = d(k,1)^2+d(k,2)^2;
        if(edist > 2)
            disp('error chaincode, not close form');
            return;
        else
            if(edist > 0)
                vect = [-d(k,1), -d(k,2)];
                if(vect(1)==1 && vect(2)==0)
                    ai = [ai,0];
                end
                if(vect(1)==1 && vect(2)==1)
                    ai = [ai,1];
                end
                if(vect(1)==0 && vect(2)==1)
                    ai = [ai,2];
                end
                if(vect(1)==-1 && vect(2)==1)
                    ai = [ai,3];
                end
                if(vect(1)==-1 && vect(2)==0)
                    ai = [ai,4];
                end
                if(vect(1)==-1 && vect(2)==-1)
                    ai = [ai,5];
                end
                if(vect(1)==0 && vect(2)==-1)
                    ai = [ai,6];
                end
                if(vect(1)==1 && vect(2)==-1)
                    ai = [ai,7];
                end
            end
        end
    end
    if mode == 1
        if(d(k,1)~=0)
            exp1 = zeros(1, abs(d(k,1))) + 2 * sign(d(k,1)) + 2* sign(d(k,1)) * sign(d(k,1));
            ai = [ai, exp1];
        end
        if(d(k,2)~=0)
            exp2 = zeros(1, abs(d(k,2))) + 2 + 2 * sign(d(k,2)) + 2* sign(d(k,2)) * sign(d(k,2));
            ai = [ai, exp2];
        end
    end
    if mode == 2
        if(d(k,1)~=0 || d(k,2)~=0)
            exp = mod(ai + 4, 8);
            ai = [ai, exp];
        end
    end

    %% Maximum length of chain code
    k = size(ai, 2);
    
    %% Traversal time
    t = calc_traversal_time(ai);
    
    d = calc_traversal_dist(ai);
    
        
    %% Basic period of the chain code
    T = t(k);
    
    %% Store this value to make computation faster
    two_n_pi = 2 * n * pi;
    
    %% Compute Harmonic cofficients: an, bn, cn, dn
    sigma_a = 0;
    sigma_b = 0;
    sigma_c = 0;
    sigma_d = 0;
        
    for p = 1 : k
        if (p >= 2)
            tp_prev = t(p - 1);
            dp_prev = d(p - 1,:);
        else
            tp_prev = 0;
            dp_prev = zeros(1,2);
        end
        
        delta_d = calc_traversal_dist(ai(p));
        delta_x = delta_d(:,1);
        delta_y = delta_d(:,2);
        delta_t = calc_traversal_time(ai(p));
        
        q_x = delta_x / delta_t;
        q_y = delta_y / delta_t;
        
        sigma_a = sigma_a + two_n_pi * (d(p,1) * sin(two_n_pi * t(p) / T) - dp_prev(1) * sin(two_n_pi * tp_prev / T)) / T;
        sigma_a = sigma_a + q_x * (cos(two_n_pi * t(p) / T) - cos(two_n_pi * tp_prev / T));
        sigma_b = sigma_b - two_n_pi * (d(p,1) * cos(two_n_pi * t(p) / T) - dp_prev(1) * cos(two_n_pi * tp_prev / T)) / T;
        sigma_b = sigma_b + q_x * (sin(two_n_pi * t(p) / T) - sin(two_n_pi * tp_prev / T));
        sigma_c = sigma_c + two_n_pi * (d(p,2) * sin(two_n_pi * t(p) / T) - dp_prev(2) * sin(two_n_pi * tp_prev / T)) / T;
        sigma_c = sigma_c + q_y * (cos(two_n_pi * t(p) / T) - cos(two_n_pi * tp_prev / T));
        sigma_d = sigma_d - two_n_pi * (d(p,2) * cos(two_n_pi * t(p) / T) - dp_prev(2) * cos(two_n_pi * tp_prev / T)) / T;
        sigma_d = sigma_d + q_y * (sin(two_n_pi * t(p) / T) - sin(two_n_pi * tp_prev / T));
    end
    
    r = T/(2*n^2*pi^2);
    
    a = r * sigma_a;
    b = r * sigma_b;
    c = r * sigma_c;
    d = r * sigma_d;
    
    %% Assign  to output
    output = [a b c d];
    
end
