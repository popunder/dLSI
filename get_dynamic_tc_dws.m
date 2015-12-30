function tc = get_dynamic_tc_dws(rho, Kb, T)
% Estimates the decorrelation time from the contrast using the DWS model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright 2006-2010 University of Fribourg
%   Contact: Pavel Zakharov - pv.zakharov@gmail.com 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [0.0001:0.001:10];
x = 1./ x;
x2 = x / 4;
% Create the dynamic contrast as a function fo correlation time 
% for the defined rho
contrast_th_dws_12 = sqrt((1 - rho).^2  * ((3 + 6 * sqrt(x) + 4 * x) .* exp(-2*sqrt(x)) - 3 + 2 * x) / 2 ./ x.^2 + ...
    2 * rho * (1 - rho) * ((3 + 6 * sqrt(x2) + 4 * x2) .* exp(-2*sqrt(x2)) - 3 + 2 * x2) / 2 ./ x2.^2);
gam = 1.5;

tc = 6 * T  * gam^2 ./ interp1(contrast_th_dws_12, x, Kb, 'linear');