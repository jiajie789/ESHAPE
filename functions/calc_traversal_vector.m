function output = calc_traversal_vector(ai)

% This function will generate position coordinates of chain code (ai). Number of 
% harmonic elements (n), and number of points for reconstruction (m) must be 
% specified.  

    x_ = 0;
    y_ = 0;
    
    for i = 1 : size(ai, 2)        
        ang = 45*ai(i);
        x_ = x_ + cosd(ang);
        y_ = y_ + sind(ang);
        p(i, 1) = x_;
        p(i, 2) = y_;
    end
    
    output = p;
    
end