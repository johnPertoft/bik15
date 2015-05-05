function [fpic] = MakeFeaturePic(ftype, W, H)
    fpic = zeros(H, W);
    
    type = ftype(1);
    x = ftype(2);
    y = ftype(3);
    w = ftype(4);
    h = ftype(5);
    yh = y + h;
    y2h = y + h + h;
    xw = x + w;
    x2w = xw + w;
    x3w = x2w + w;
    
    switch type
        case 1
            fpic(y:yh-1, x:xw-1) = -1;
            fpic(yh:y2h-1, x:xw-1) = 1;
        case 2
            fpic(y:yh-1, x:xw-1) = 1;
            fpic(y:yh-1, xw:x2w-1) = -1;
        case 3
            fpic(y:yh-1, x:xw-1) = 1;
            fpic(y:yh-1, xw:x2w-1) = -1;
            fpic(y:yh-1, x2w:x3w-1) = 1;
        case 4
            fpic(y:yh-1, x:xw-1) = 1;
            fpic(y:yh-1, xw:x2w-1) = -1;
            fpic(yh:y2h-1, x:xw-1) = -1;
            fpic(yh:y2h-1, xw:x2w-1) = 1;
        otherwise
            error('undefined feature type');
    end

end

