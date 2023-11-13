% Copyright (c) 2011, auralius manurung
% Modified By IBCAS@2023
% All rights reserved.
function [A0, C0, Tk, T] = calc_dc_components_modify(ai, mode)

% Calculate DC components.
% A0 and C0 are bias coefficeis, corresponding to a frequency of zero.
    k = size(ai, 2);
    t = calc_traversal_time(ai);
    d = calc_traversal_dist(ai);
    Tk = t(k);
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
    
    %% Traversal time and distance
    t = calc_traversal_time(ai);
    
    d = calc_traversal_dist(ai);
    
    %% Basic period of the chain code
    T = t(k);
    
    %% DC Components: A0, C0
    sum_a0 = 0;
    sum_c0 = 0;
    
    for p = 1 : k     
        if (p >= 2)
            dp_prev = d(p - 1,:);
        else
            dp_prev = zeros(1,2);
        end
        delta_t = calc_traversal_time(ai(p));

        sum_a0 = sum_a0 + (d(p,1) + dp_prev(1)) * delta_t / 2;
        sum_c0 = sum_c0 + (d(p,2) + dp_prev(2)) * delta_t / 2;
    end
    
    %% Assign  to output
    A0 = sum_a0 / T;
    C0 = sum_c0 / T;
end
