function B = CalculateBoxSum(ii_im, x, y, w, h)

if x == 1 && y == 1
    B = ii_im(y+h-1, x+w-1);
elseif x == 1
    B = ii_im(y+h-1, x+w-1)  - ii_im(y-1, x+w-1);
elseif y == 1
    B = ii_im(y+h-1, x+w-1) - ii_im(y+h-1, x-1);
else
    B = ii_im(y+h-1, x+w-1) - ii_im(y+h-1, x-1) - ii_im(y-1, x+w-1) + ii_im(y-1, x-1);
end


% ii_im = padarray(ii_im, [1 1], 0, 'pre');
% x = x + 1;
% y = y + 1;
 %B = ii_im(y+h-1, x+w-1) - ii_im(y+h-1, x-1) - ii_im(y-1, x+w-1) + ii_im(y-1, x-1);

end

