function [output,a,b,c,d] = fourier_approx_norm_modify_20231008(ai, n, m, normalized, mode,option)
% This function will generate position coordinates of fourier approximation of
% chain code (ai).Number of harmonic elements (n), and number of points for
% reconstruction (m) must be specified.

a = zeros(n,1);
b = zeros(n,1);
c = zeros(n,1);
d = zeros(n,1);
for i = 1 : n
    harmonic_coeff = calc_harmonic_coefficients_modify(ai, i, 0);
    a(i) = harmonic_coeff(1, 1);
    b(i) = harmonic_coeff(1, 2);
    c(i) = harmonic_coeff(1, 3);
    d(i) = harmonic_coeff(1, 4);
end
[A0, C0, Tk, T] = calc_dc_components_modify(ai, 0);

% Normalization procedure
if (normalized == 1)
    ro=option(1);sc=option(2);re=option(3);y_sy=option(4);x_sy=option(5);sta=option(6);trans=option(7);
    % Remove DC components
    if(trans)
        A0 = 0;
        C0 = 0;
    end
    if(re)
        CrossProduct = a(1)*d(1) - c(1)*b(1);           %叉乘判断是否符合右手定则
        if(CrossProduct < 0)    %调整为逆时针旋转方向
            for i = 1 : n
                b(i) = -b(i);
                d(i) = -d(i);
            end
        end
    end

    tan_theta2 = 2 * (a(1) * b(1) + c(1) * d(1)) / ...
        (a(1)^2 + c(1)^2 - b(1)^2 - d(1)^2);
    % Compute theta1
    theta1 = 0.5 * atan(tan_theta2);
    if(theta1 < 0)
        theta1 = theta1 + pi/2;
    end
    sin_2theta = sin(2*theta1);
    cos_2theta = cos(2*theta1);
    cos_theta_square = (1 + cos_2theta)/2;
    sin_theta_square = (1 - cos_2theta)/2;

    axis_theta1 = (a(1)^2+c(1)^2)*cos_theta_square+...
        (a(1)*b(1)+c(1) * d(1))*sin_2theta +...
        (b(1)^2+d(1)^2) * sin_theta_square;

    axis_theta2 = (a(1)^2+c(1)^2)*sin_theta_square-...
        (a(1)*b(1)+c(1) * d(1))*sin_2theta +...
        (b(1)^2+d(1)^2) * cos_theta_square;
    %modified by razorenhua@20220209
    if(axis_theta1 < axis_theta2)
        theta1 = theta1 + pi/2;
    end

% %         adjust staring point
%         a_star_1 = costh1 * a(1) + sinth1 * b(1);
%         b_star_1 = -sinth1 * a(1) + costh1 * b(1);
%         c_star_1 = costh1 * c(1) + sinth1 * d(1);
%         d_star_1 = -sinth1 * c(1) + costh1 * d(1);

    
    % Compute psi1
    costh1 = cos(theta1);   
    sinth1 = sin(theta1);
    a_star_1 = costh1 * a(1) + sinth1 * b(1);
    c_star_1 = costh1 * c(1) + sinth1 * d(1);
    
    psi1 = atan(c_star_1 / a_star_1) ;
    if(psi1 < 0)
        psi1 = psi1 + pi;
    end
    
    
    
    % Compute E
    E = sqrt(a_star_1^2 + c_star_1^2);
    %scale consistency
    if(sc)
        a = a/E;
        b = b/E;
        c = c/E;
        d = d/E;
    end
    
    %rotate consistency
    
    cospsi1 = cos(psi1);
    sinpsi1 = sin(psi1);
    normalized_all=zeros(n,4);
    if(ro)
        for i = 1 : n
            normalized = [cospsi1 sinpsi1; -sinpsi1 cospsi1] * [a(i) b(i); c(i) d(i)];%* ...
%                 [cos(theta1 * i) -sin(theta1 * i); sin(theta1 * i) cos(theta1 * i)];
            temp=reshape(normalized,1,4);
            normalized_all(i,:)=temp;
        end
        a=normalized_all(:,1);
        c=normalized_all(:,2);
        b=normalized_all(:,3);
        d=normalized_all(:,4);
    end

    
    %starting point consistency
    normalized_all_1=zeros(n,4);
    if(sta)
        for i=1:n
            normalized_1 = [a(i) b(i); c(i) d(i)] * [cos(theta1 * i) -sin(theta1 * i); sin(theta1 * i) cos(theta1 * i)];
            temp=reshape(normalized_1,1,4);
            normalized_all_1(i,:)=temp;
        end
        a=normalized_all_1(:,1);
        c=normalized_all_1(:,2);
        b=normalized_all_1(:,3);
        d=normalized_all_1(:,4);
        % rotate 180 degree
        if(a(1) < 0)
            for i = 1 : n
                a(i) = - a(i);
                d(i) = - d(i);
            end
        end
    end
    
    


    if(y_sy)
        if(a(2) < 0)
            for i = 2 : n
                signval = (-1)^(mod(i,2)+1);
                a(i) = signval * a(i);
                d(i) = signval * d(i);
                signval = (-1)^(mod(i,2));
                b(i) = signval * b(i);
                c(i) = signval * c(i);
            end
        end
    end

    
    
    if(x_sy)
        if(b(2) < 0)
            for i = 2 : n
                b(i) = -b(i);
                c(i) = -c(i);
            end
        end
    end

%     figure;
%     set(gcf,'Position',[45,45,400,400]);
%     [output] = fourier_reconstruct_func(a,b,c,d,0,m);
%     scatter(output(1,1),output(1,2),'Marker','*','LineWidth',2);
%     set(gca,'Position',[0.16,0.12,0.82,0.82]);
%     hold on;
%     for k=4:4:400
%         plot(output(1:k,1),output(1:k,2),'-r','parent',gca);
%         axis([-2,2,-2,2]);
%         pause(0.01);
%     end
%     hold on;
%     xlabel('X Position','FontName','Times','FontSize',12);
%     ylabel('Y Position','FontName','Times','FontSize',12);
%     title('Adjust Starting Point and Normlize ChainCode','FontName','Times','FontSize',12)
%     xt1 = a(1)*cos(0) + b(1)*sin(0);
%     yt1 = c(1)*cos(0) + d(1)*sin(0);
%     scatter(xt1,yt1,'Marker','^','LineWidth',2);
%     hold on;
%     xt2 = a(1)*cos(0+pi/2) + b(1)*sin(0+pi/2);
%     yt2 = c(1)*cos(0+pi/2) + d(1)*sin(0+pi/2);
%     scatter(xt2,yt2,'Marker','o','LineWidth',2);
%     hold on;
%     xt3 = a(1)*cos(0+pi) + b(1)*sin(0+pi);
%     yt3 = c(1)*cos(0+pi) + d(1)*sin(0+pi);
%     scatter(xt3,yt3,'Marker','o','LineWidth',2);
%     hold on;
%     xt4 = a(1)*cos(0+3*pi/2) + b(1)*sin(0+3*pi/2);
%     yt4 = c(1)*cos(0+3*pi/2) + d(1)*sin(0+3*pi/2);
%     scatter(xt4,yt4,'Marker','o','LineWidth',2);

end  % end if normalized

for t = 1 : m
    x_ = 0.0;
    y_ = 0.0;
    for i = 1 : n
        x_ = x_ + (a(i) * cos(2 * i * pi * (t - 1)* Tk / (m-1) /T) + b(i) * sin(2 * i * pi * (t - 1)* Tk / (m-1) /T));
        y_ = y_ + (c(i) * cos(2 * i * pi * (t - 1)* Tk / (m-1) /T) + d(i) * sin(2 * i * pi * (t - 1)* Tk / (m-1) /T));
    end
    output(t,1) = A0 + x_;
    output(t,2) = C0 + y_;
end

