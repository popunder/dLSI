function [out_tauc, out_tauc_wrong] = dlsi_proc_get_tauc(rho, dyn, contrast, exptime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to convert contrast components into the correlation times
% Extremely time consuming. 
% Requires the function 'get_dynamic_tc_dws'.
%
% Input:
% rho, dyn and contrast as obtained with 'evaluate' and 'process' function.
%    beta - This is the square of the maximal contrast (measured on teflon
%           block or dead rat. 
% exptime - exposure time of the camera
%
% Output:
% out_tauc - 100% correct estimation of correlation time    
% out_tauc_wrong - traditional estimation of correlation ignoring the
%                       static part.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create array by copying. This is only required to get the dimensions right.  
out_tauc = dyn; 
out_tauc_wrong = out_tauc;

disp('inverting');

tic;

for i=1:size(dyn, 1)
    
    parfor (j=1:size(dyn, 2))
	% the main routines
	% DWS correlation function is assumed
        out_tauc(i,j)       = get_dynamic_tc_dws(rho(i,j),  dyn(i,j),       exptime);
        out_tauc_wrong(i,j) = get_dynamic_tc_dws(       0,  contrast(i,j),  exptime);
    end
    if (mod(i,5) == 0)
	% Progress report
        t = toc;
        tic;
        disp(sprintf('invert: %d, spent %f sec',i, t)); 
     end
end


