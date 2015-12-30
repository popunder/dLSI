function b = im2col_(A, block, notUsed)

[m,n] = size(A);
mblocks = m/block(1);
nblocks = n/block(2);
b = mkconstarray(class(A), 0, [prod(block) mblocks*nblocks]);
x = mkconstarray(class(A), 0, [prod(block) 1]);
    rows = 1:block(1); cols = 1:block(2);
for i=0:mblocks-1,
    for j=0:nblocks-1,
        x(:) = A(i*block(1)+rows,j*block(2)+cols);
        b(:,i+j*mblocks+1) = x;
    end
end
end