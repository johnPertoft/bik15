function [fc, fs] = ExtractSiftDescriptor(img)
    w = size(img, 1);
    sc = (w-2) / 12;
    fc = [w/2; w/2; sc; 0];
    [fc, fs] = vl_sift(img, 'frames', fc);
    fs = double(fs(:));
    
end

