%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert rectangular coordinates to polar form
%%%%
%%%% Usage: 
%%%% [mag,ang] = rtop(rect)
%%%%
%%%% Example:
%%%% ZL = 20+15i
%%%% [mag,ang] = rtop(ZL)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% rtop.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [mag,ang] = rtop(rect)
% magnitude
mag = abs(rect);

% angle in radians
ang_rad = angle(rect);

% angle in degrees
ang = ang_rad*(180/pi);
end%function
