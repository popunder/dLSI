% load_dataset is a part of dLSI package
% please obtain the tiff file with test from
% http://sites.google.com/site/pzoptics/files/datauint16.zip
% unzip it and place it in the path

%indicate the path to the dataset tiff here
fname = 'datauint16.tiff';
finfo = imfinfo(fname);
numFrames = numel(finfo);
assert(numFrames > 0, 'File is emtpy');

%we load data as uint16 to keep the memory usage low
data = uint16(zeros(finfo(1).Height, finfo(1).Width, numFrames));
for ii=1:numFrames
    data(:,:,ii) = uint16(imread(fname, ii));
end
%we expect to have 480x640x16 uint16 data at this point
assert(size(data) == [480 640 16], 'Data load failed');