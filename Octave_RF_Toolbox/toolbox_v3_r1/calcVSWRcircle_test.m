%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcVSWRcircle_test()

% Inputs
vswr = 2
Z_center = 4-2i
Zo_calc = 100
Zo_smithchart = 50
points_per_circle = 20;

% Calculate with function
[circle_points_Z1] = calcVSWRcircle(vswr);
[circle_points_Z2] = calcVSWRcircle(vswr,Z_center);
[circle_points_Z3] = calcVSWRcircle(vswr,Z_center,Zo_calc);

% strip index column 1
points_Z1 = circle_points_Z1(:,2:3);
points_Z2 = circle_points_Z2(:,2:3);
points_Z3 = circle_points_Z3(:,2:3);

% Normalize impedance values
points_z1 = points_Z1*(1/Zo_smithchart);
points_z2 = points_Z2*(1/Zo_smithchart);
points_z3 = points_Z3*(1/Zo_smithchart);

% Find number of points in each circle
% They should all be the same
num_points_z1 = length(points_z1(:,1));
num_points_z2 = length(points_z2(:,1));
num_points_z3 = length(points_z3(:,1));
step_size = round(num_points_z1/points_per_circle);

% Create smith chart
scCreate;

% Combine real and imag columns to form an array
z1 = points_z1(:,1)+(points_z1(:,2)*i);
z2 = points_z2(:,1)+(points_z2(:,2)*i);
z3 = points_z3(:,1)+(points_z3(:,2)*i);

% Add some points from each array to the smith chart
for ind = [1:step_size:num_points_z1]
   scAddPoint(z1(ind));
   scAddPoint(z2(ind));
   scAddPoint(z3(ind));
end%for

% Print comments
fprintf('\n'); 
fprintf('----------------------------------------------------\n');
fprintf('...Verify there are 3 circles on the smith chart\n');
fprintf(['- One circle centered in the middle\n']);
fprintf(['- One circle centered at [ ',num2str(Z_center),' ]\n']);
fprintf(['- One circle centered at [ ',num2str(Z_center),' ]\n']);
fprintf(['- The two off center circles will overlay each other\n']);
fprintf('\n');



end%function





