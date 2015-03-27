function [Fs] = ComputeDescriptors(Dirname, ngrids, nbins)
    mystr = [Dirname, '/*.png'];
    im_files = dir(mystr);
    ni = length(im_files);
    ims = cell(1, ni);
    addpath(Dirname);
    for i=1:ni
        col_im = imread(im_files(i).name);
        im = single(rgb2gray(col_im));
        ims{i} = (im - mean(im(:))) / std(im(:));
    end
    
    Fs = cell(1, 4);
    for i=1:4
        Fs{i} = [];
    end
    
    for i=1:ni
        % template description
        Fs{1} = [Fs{1} ims{i}(:)];
        
        % Histogram
        [fs, ~] = hist(ims{i}(:), 30);
        fs = fs(:) / sum(fs);
        Fs{2} = [Fs{2} fs];
        
        % Grid histogram
        fs = ExtractGridHistogram(ims{i}, 2, 30);
        Fs{3} = [Fs{3} fs];
        
        % SIFT
        [~, fs] = ExtractSiftDescriptor(ims{i});
        Fs{4} = [Fs{4} fs];
    end
end

