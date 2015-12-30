function [out_rho, out_dyn, out_contrast] = dlsi_proc_decompose(data, wsize, shift, beta)
%% DLSI_PROC_DECOMPOSE calculates components of the speckle contrast
% rho - static part
% dyn - dynamic part (mixed)
% contrast - standard LASCA
% Input parameters:
%    data(x, y, time) - data array with intensity (assumed double)
%    wsize - window size
%    shift - number of frames to jump for static and dynamic
%            part calculation. 1 should work fine in most cases
%    beta - This is the square of the maximal contrast (measured on teflon
%           block or dead rat.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright 2006-2010 University of Fribourg
%   Contact: Pavel Zakharov - pv.zakharov@gmail.com
%----------------------------------------------------------------
%%
len = size(data, 3);
s1 = size(data,1);
s2 = size(data,2);
out_contrast = zeros(s1 / wsize, s2 /wsize);

% traditional spatial contrast (LASCA)
% calculated spatially, but averaged over time
for (i=1:len)
    out_contrast = out_contrast + lasca(double(squeeze(data(:,:,i))), wsize) / len;
    if (mod(i,10) == 0)
        fprintf(1, 'lasca: %d\n',i);
    end
end
%%
tic
% intensity for normalization (symmetric)
norm_m = blockmean(squeeze(mean(data(:,:,1:end-shift), 3)), wsize) .* blockmean(squeeze(mean(data(:,:,shift:end), 3)), wsize);
% static part
out_rho2 = (blockmean(squeeze(mean(data(:,:,1:end-shift) .* data(:,:,1+shift:end), 3)), wsize) ./ norm_m  - 1) / beta;
% cutting min and max
out_rho2(out_rho2 < 0) = 0.001;
out_rho2(out_rho2 > beta) = beta;
out_rho = sqrt(out_rho2);
% dynamic part
out_dyn = sqrt(blockmean(squeeze(mean((data(:,:,1:end-shift) - data(:,:,1+shift:end)).^2 / 2, 3)), wsize) ./norm_m / beta);
toc
