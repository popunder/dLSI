% Demonstration of the functionality of the dLSI algorithm
%
%   Copyright 2006-2010 University of Fribourg
%   Contact: Pavel Zakharov - pv.zakharov@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% we have the data in the format (x,y,t) in the data variable
% can be any format (uint8. uint16, double)
% convert to double, just in case
data=double(data);

%%%%%%%%%%%%% measurement system parameters
% coherence factor
beta=0.4225;
% exposure time
T = 0.010;

%%%%%%%%%%%%% processing parameters
% number of images to jump for the static part estimation
shift = 1;
% size of the spatial window
wsize = 5;

[out_rho, out_dyn, out_contrast] = dlsi_proc_decompose(data, wsize, shift, beta);

% convert to correlation time 
[out_tauc_dlsi, out_tauc_lasca] = dlsi_proc_get_tauc(out_rho, out_dyn, out_contrast, T);

%% now we plot the results
figure('Name', 'Contrast decomposition');
subplot(2,2,1);
imagesc(squeeze(mean(data, 3)));
title('Mean intensity');
axis image;
colorbar;

subplot(2,2,2);
imagesc(out_contrast);
title('LASCA Contrast');
axis image;
colorbar;

subplot(2,2,3);
imagesc(out_rho);
title('Static part / \rho');
axis image;
colorbar;

subplot(2,2,4);
imagesc(out_dyn);
title('Dynamic part');
axis image;
colorbar;

%% and the correlation time
scaleMin = min([min(out_tauc_dlsi(:)) min(out_tauc_lasca(:))]);
scaleMax = max([max(out_tauc_dlsi(:)) max(out_tauc_lasca(:))]);
screenSize = get(0,'ScreenSize');
figureSize = [800 400]; % figure size
xpos = ceil((screenSize(3)-figureSize(1))/2); 
ypos = ceil((screenSize(4)-figureSize(2))/2); 

fig = figure('Name', 'Correlation times', ...
    'Position', [xpos ypos figureSize(1) figureSize(2)], ...
    'Units', 'pixels');
subplot('Position', [0.025 0.05 0.45 0.9]);
imagesc(out_tauc_lasca, [scaleMin scaleMax]);
title('LASCA \tau_c');
axis image;

subplot('Position', [0.525 0.05 0.45 0.9]);
imagesc(out_tauc_dlsi, [scaleMin scaleMax]);
title('dLSI \tau_c');
axis image;


