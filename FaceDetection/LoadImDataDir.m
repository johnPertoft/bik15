function [ii_ims] = LoadImDataDir(dirname, varargin)
imagefiles = dir([dirname, '/*.bmp']);
nfiles = length(imagefiles);

if (length(varargin) > 0)
    nfiles = varargin{1};
end

ii_ims = [];
for i=1:nfiles
    currentfilename = [dirname, '/', imagefiles(i).name];
    [~, ii_im] = LoadImage(currentfilename);
    ii_ims = [ii_ims, ii_im(:)];
end

end

