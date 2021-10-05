
clc;
clear;
close all;


out = SingleMissileData(10,45,0,0,0,0,25,0.05,20,20,100);
out

% syms y(x)
% y = piecewise(x > 5, x-3, NaN);
% 
% A = 1 : 10;
% 
% out = y(A);
% 
% disp(out);