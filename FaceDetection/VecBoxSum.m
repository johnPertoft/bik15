function [b_vec] = VecBoxSum(x, y, w, h, W, H)
    if (x == 1 | y == 1 | x+w-1 > W | y+h-1 > H)
        error('VecBoxSum edge case');
    end

    % note: x and y coordinates are flipped here
    b_vec = zeros(H, W);
    b_vec(y+h-1, x+w-1) = 1;
    b_vec(y-1, x+w-1) = -1;
    b_vec(y+h-1, x-1) = -1;
    b_vec(y-1, x-1) = 1;
    b_vec = b_vec(:)';
end

