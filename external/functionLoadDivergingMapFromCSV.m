function [R,G,B] = functionLoadDivergingMapFromCSV()
%FUNCTIONLEVANTARDIVERGINGMAPFROMCSV Summary of this function goes here
%   Detailed explanation goes here
lista = csvread('CoolWarmUChar257.csv');
%La primera columna es un escalar
R=lista(2:end,2);%Le saco el primero porque trae 257 muestras
G=lista(2:end,3);
B=lista(2:end,4);
end

