% prepareDates.m
%
% Load the unique days from the file at the given index, update them to be
% dates with an offset from startDate
function [dn] = prepareDates(filename, index, startDate)
    data = csvread(filename, 1, 0);
    dn = [];
    formatIn = 'mm/dd/yyyy';
    for days = unique(data(:, index))'
        dn(end+1) = addtodate(datenum(startDate,formatIn), days, 'day');
    end
end