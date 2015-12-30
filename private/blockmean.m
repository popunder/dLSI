function B = blockmean(A, wsize)
X = im2col_(A, [wsize wsize], 'distinct');
M = mean(X);
B = col2im_(M, size(A) / wsize);
end