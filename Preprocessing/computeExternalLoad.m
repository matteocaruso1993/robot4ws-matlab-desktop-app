function [F_mean,F_stdv] = computeExternalLoad(target_mat)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data = load(target_mat);
data.data(:,2) = -data.data(:,2);
fig = figure();
ax = axes(fig);
line = plot(ax, data.data(:,1), data.data(:,2),'-b');

selection_rect = drawrectangle(ax);
disp('Press Enter when done selecting the ROI')
pause()
selection_rect.InteractionsAllowed = 'none';

x_i = selection_rect.Position(1);
x_f = x_i + selection_rect.Position(3);

y_i = selection_rect.Position(2);
y_f = y_i + selection_rect.Position(4);

x = data.data(:,1);
y = data.data(:,2);

x_reduced = x(x >=x_i & x <=x_f);
y_reduced = y(x >=x_i & x <=x_f);

x_reduced_new = x_reduced(y_reduced >= y_i & y_reduced <=y_f);
y_reduced_new = y_reduced(y_reduced >= y_i & y_reduced <=y_f);

[peaks, locs] = findpeaks(y_reduced_new,x_reduced_new);

try
close(fig)
end
fig2 = figure();
ax2 = axes(fig2);
line2 = plot(ax2,x_reduced_new, y_reduced_new);
line3 = plot(locs, peaks,'v');
hold(ax2,'on')
line4 = plot(ax2,x_reduced_new,y_reduced_new);
disp('Press Enter to continue')
pause()

F_mean = mean(peaks);
F_stdv = std(peaks);

try
close(fig2)
end
end

