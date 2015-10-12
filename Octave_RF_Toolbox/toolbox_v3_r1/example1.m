%%%%%%%%%%%%%%%%%%% START example1.m %%%%%%%%%%%%%%%%%%%
% Create a smith chart
% plot a point and circle
% 
% curtis | creatingrf[@]gmail.com
% Last Edited: 6/15/12
% Octave tested: 9/7/13
% Matlab tested: 6/15/12
function example1()

% Inputs
% Set impedance and normalize
Zo = 50; 
Z1 = 10-20i; 
z1 = Z1/Zo; 

% Set location of circle in polar form
circle_center_mag = 0.6; 
circle_center_ang = 50; 
circle_radius = 0.2; 
circle_color = 'b'; 

% Create a smith chart
scCreate;

% Plot a normalized impedance point
scAddPoint(z1);

% Plot a circle
scAddCircle(circle_center_mag,circle_center_ang,circle_radius,circle_color);

% Tell the plot nothing else will be added
hold off;

end%function
%%%%%%%%%%%%%%%%%%% END example1.m %%%%%%%%%%%%%%%%%%%
