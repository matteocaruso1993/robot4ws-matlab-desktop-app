function [out_tab] = CreateExternalLoadTable()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
folder = 'test/';
row_names = {'br1','br2','fr1','fr2','bl1','bl2','fl1','fl2'};
col_names = {'F_mean','F_std'};
data = zeros(numel(row_names),2);

for i=1:numel(row_names)
    [f,f_std] = computeExternalLoad(strcat(folder,row_names{i},'.mat'));
    data(i,1) = f;
    data(i,2) = f_std;
end
out_tab = table(data(:,1),data(:,2),'RowNames',row_names,'VariableNames',col_names);
end

