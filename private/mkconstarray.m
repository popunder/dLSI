function out = mkconstarray(class, value, size)
%MKCONSTARRAY creates a constant array of a specified numeric class.
%   A = MKCONSTARRAY(CLASS, VALUE, SIZE) creates a constant array 
%   of value VALUE and of size SIZE.

%   Copyright 1993-2003 The MathWorks, Inc.  
%   $Revision: 35 $  $Date: 2013-09-30 08:46:27 +0200 (Mo, 30 Sep 2013) $

out = repmat(feval(class, value), size);