function [nominal, variance, avg] = median_of_depth ( dmap, mask)

pts = dmap(:);
pts = pts(find(mask(:) == 1));

if isempty(pts)
    nominal = 255;
    variance = -1;
    avg = -1;
    return;
end

nominal = median(pts);
variance = var(double(pts'));
avg = mean(pts);

% h = figure; subplot(2,2,1); imshow(dmap); subplot(2,2,2); imshow(mask); % DEBUG MODE
% subplot(2,2,3); imhist(dmap(:)); subplot(2,2,4); imhist(pts); disp(nominal); % DEBUG MODE
% close(h); % DEBUG MODE