%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert polar to rectangular
%%%%
%%%% Usage: 
%%%% rect = ptor(mag,ang_degrees)
%%%% 
%%%% Example:
%%%% mag = 0.4
%%%% ang_deg = 50
%%%% rect = ptor(mag,ang_deg)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% ptor.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function rect = ptor(mag,ang_degrees)

% Convert degrees to radians
ang_radians = ang_degrees*(pi/180);
imaginary = 0+1i;

% Calc real and imag rectangular coordinates
R = mag*cos(ang_radians);
X = mag*sin(ang_radians);

% Combine real and imaginary
rect = R+(X*imaginary);

end%function
