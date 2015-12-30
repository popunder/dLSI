function a = col2im_(b, mat)
% Check argument sizes
[m,n] = size(b);
if 1~=m, error('The row size of B must be M*N.'); end


mblocks = mat(1);
nblocks = mat(2);
a = zeros(mat);
%rows = 1:mat(1); cols = 1:mat(2);
for i=0:mblocks-1,
    for j=0:nblocks-1,
        a(i+1,j+1) = b(i+j*mblocks+1);
    end
end
%a = aa(1:mat(1),1:mat(2));
end