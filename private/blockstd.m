function B = blockstd(A, wsize)
X = im2col_(A, [wsize wsize], 'distinct');
M = std(X);
B = col2im_(M, size(A) / wsize);
end