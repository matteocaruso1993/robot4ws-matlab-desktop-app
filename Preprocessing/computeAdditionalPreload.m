function [df,dx] = computeAdditionalPreload(k,f_current, f_target)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
df = f_target - f_current;
dx = df/k;
end

