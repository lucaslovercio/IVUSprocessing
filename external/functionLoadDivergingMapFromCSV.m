function [R,G,B] = functionLoadDivergingMapFromCSV()

lista = csvread('CoolWarmUChar257.csv');
%First column is a scalar
R=lista(2:end,2);%First row is discarded
G=lista(2:end,3);
B=lista(2:end,4);
end

