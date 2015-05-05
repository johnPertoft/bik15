function [all_ftypes] = EnumAllFeatures(W, H)
% note: size depends on W x H = 19 x 19
all_ftypes = zeros(32746, 5);
i = 1;

% type 1
for w = 1:W - 2
    for h = 1:floor(H/2) - 2
        for x = 2:W-w
            for y = 2:H-2*h
                all_ftypes(i, :) = [1, x, y, w, h];
                i = i + 1;
            end
        end
    end
end

% type 2
for w = 1:floor(W/2) - 2
    for h = 1:H-2
        for x = 2:W-2*w
            for y = 2:H-h
                all_ftypes(i, :) = [2, x, y, w, h];
                i = i + 1;
            end
        end
    end
end

% type 3
for w = 1:floor(W/3) - 2
    for h = 1:H-2
        for x = 2:W - 3*w
            for y = 2:H -h
                all_ftypes(i, :) = [3, x, y, w, h];
                i = i + 1;
            end
        end
    end
end

% type 4
for w = 1:floor(W/2) - 2
    for h = 1:floor(H/2) - 2
        for x = 2:W - 2*w
            for y = 2:H - 2*h
                all_ftypes(i, :) = [4, x, y, w, h];
                i = i + 1;
            end
        end
    end
end

end

