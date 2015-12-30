function result = lasca(d, wsize)
% Calculates the LASCA contrast
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright 2006-2010 University of Fribourg
%   Contact: Pavel Zakharov - pv.zakharov@gmail.com 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Id: lasca.m 35 2013-09-30 06:46:27Z popunder $
result = blockstd(d, wsize) ./ blockmean(d, wsize);
end