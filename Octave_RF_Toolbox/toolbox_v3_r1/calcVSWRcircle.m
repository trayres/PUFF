%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% 
%%%% Calculate impedance points making up constant VSWR circle 
%%%% around target impedance
%%%% - Output could be saved to a text file for use in AWR or ADS
%%%% - Output could be saved to a text file and used in a spreadsheet program
%%%% - Output could be viewed using scCreate.m and scAddPoint.m (looped)
%%%%
%%%% Example Inputs:
%%%% vswr = 2
%%%% Z_center = 4-2i
%%%% Zo = 50
%%%%
%%%% Output:
%%%% each row of the form......
%%%% circle_points_z(index,:) = [index,real(Z),imag(Z)];
%%%% 
%%%% Usage:
%%%% 1 arguments in: vswr circle around center of smith chart
%%%% [circle_points_z] = calcVSWRcircle(vswr);
%%%%
%%%% 2 arguments in: vswr circle around ZL, assume Zo = 50
%%%% [circle_points_z] = calcVSWRcircle(vswr,Z_center);
%%%%
%%%% 3 arguments in: vswr circle around ZL, with user provided Zo
%%%% [circle_points_z] = calcVSWRcircle(vswr,Z_center,Zo)
%%%% - This option is currently redundant since output is NOT normalized
%%%% - Need to look into this
%%%%
%%%% Based on equations from Gonzalez p.262
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% calcVSWRcircle.m
%%%% Last edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [circle_points_z] = calcVSWRcircle(varargin)

%-----------------------------------------
% Inputs
%

%-----------------------------------------
% Input Arguments
%
switch(nargin)

case 1                  % vswr circle around center of smith chart
vswr = varargin{1};		% vswr
Zopt = 50;              % ZL - 'center' of vswr circle
Zo = 50;                % characteristic impedance

case 2                  % vswr circle around ZL, assume Zo = 50
vswr = varargin{1};		% vswr
Zopt = varargin{2};		% ZL - 'center' of vswr circle
Zo = 50;                % default characteristic impedance = 50

case 3                  % vswr circle around ZL, with user provided Zo
vswr = varargin{1};		% vswr
Zopt = varargin{2};		% ZL - 'center' of vswr circle
Zo = varargin{3};		% characteristic impedance

otherwise               % 2:1 vswr circle around the center of the smith chart
vswr = 2;               % vswr
Zopt = 50;              % ZL - 'center' of vswr circle
Zo = 50;                % characteristic impedance
warning('Incorrect number of arguments');
warning('Usage: ');
warning('[circle_points_z] = calcVSWRcircle(vswr)');
warning('[circle_points_z] = calcVSWRcircle(vswr,Z_center)');
warning('[circle_points_z] = calcVSWRcircle(vswr,Z_center,Zo)');		
end%switch

%-----------------------------------------
% Initialize parameters
%
Gb_mag = (vswr-1)/(vswr+1);			% Target refl coeff. from vswr
Zopt_conj = conj(Zopt);				% if ZL*=Zopt*=Zout, gamma=0, vswr=1
Zout = Zopt_conj;				% to be clear
[Gout_mag,Gout_ang] = ztog(Zout,Zo);		% convert impedance to refl coeff.
%Gout_mag = 0.259;
%Gout_ang = 83.84;
Gout_rect = ptor(Gout_mag,Gout_ang);		% convert polar to rectangular form for easy equation input
Gout_rect_conj = conj(Gout_rect);		% for easy equation input

%-----------------------------------------
% Calculate center of circle
%
c_top = (Gout_rect_conj*(1-(Gb_mag^2)));
c_bottom = (1-((abs(Gb_mag*Gout_rect))^2));
Cvo = c_top/c_bottom;				% find circle center - rect coord
[Cvo_mag,Cvo_ang] = rtop(Cvo);			% convert rect to polar form

%-----------------------------------------
% Calculate radius of circle
%
r_top = (Gb_mag*(1-(Gout_mag^2)));
r_bottom = c_bottom;
rvo = r_top/r_bottom;				% find radius of circle - scalar magnitude

%-----------------------------------------
% Find refl coeffs existing on circle
%
circle_points_g = createCircle(Cvo_mag,Cvo_ang,rvo);

%-----------------------------------------
% Convert refl coef to impedance and add index column
%
num_points = length(circle_points_g(:,1));
for ind = [1:num_points]
	g_mag = circle_points_g(ind,1);				% refl coeff magnitude
	g_ang = circle_points_g(ind,2);				% refl coeff angle
	[z,Z] = gtoz(g_mag,g_ang,Zo);				% convert refl coeff to impedance
	circle_points_z(ind,:) = [ind,real(Z),imag(Z)];		% add impedance to output matrix
end%for


end%function



function Gxy_polar = createCircle(c_mag,c_ang,radius)

%---------------------------------------------------------
% Convert inputs for plotting
%
center = ptor(c_mag,c_ang);				% center location (rect form)
re_axis = real(center);					% x-axis location
im_axis = imag(center);					% y-axis location
radius = radius;					% for easy future editing

%---------------------------------------------------------
% vectors required to produce circles
%
t = [0:0.01:2*pi];					% resolution of circle
x = cos(t);
y = sin(t);

%---------------------------------------------------------
% Plot circle
%
Gx = ((x*radius)+re_axis);
Gy = ((y*radius)+im_axis);
Gxy_rect = Gx'+(Gy'*i);					% refl coeffs in rectangular form

num_points = length(Gx);				% number of points making up circle
for ind = [1:num_points]				% for each point
	[mag,ang] = rtop(Gxy_rect(ind));		% convert from rect to polar form
	Gxy_polar(ind,:) = [mag,ang];			% save refl coeff. to matrix
end%for

Gxy_polar;

end%function




