%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Create a smith chart plot
%%%% - Call at the start of a script
%%%% - Then add stuff to it
%%%% - hold is not turned off and should be later
%%%%
%%%% Usage:
%%%%	scCreate
%%%%	scCreate(option,value)
%%%%
%%%% Options:
%%%%	scCreate('plot_Y_chart','true')
%%%%
%%%% Changes: 
%%%% - 4/10/11: Accept variable input arguments
%%%% - 4/10/11: Added option 'plot_Y_chart' -> 'true' or 'false'
%%%% - 6/14/12: Removed plot function from loop for speed boost
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% scCreate.m
%%%% Last modified: 6/14/12
%%%% Octave tested: 8/19/12
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scCreate(varargin)

%---------------------------------------------------------
% Chart Properties
%
circles = [0.2, 0.4, 0.6, 0.8, 1, 2, 4, 6, 8, 10];	% circle values (r,g)
arcs =    [0.2, 0.4, 0.6, 0.8, 1, 2, 4, 6, 8, 10];	% arc values (x,s)

Z_color = 'k'; 						% Z chart color
Y_color = 'g';						% Y chart color

plot_Z_chart = 1;					% 1 is true
plot_Y_chart = 0;					% 0 is false

add_Z_labels = 1;					% add label values to chart
add_Y_labels = 1;					%

%---------------------------------------------------------
% Modify Properties if input arguments exist
% every other argument should be an option
%
if(nargin)
%	fprintf('%i input arguments are were passed\n',nargin);
    for narg = [1:2:nargin]					    
	switch (varargin{narg})
	case 'plot_Y_chart'
	plot_Y_chart = varargin{narg+1};
	otherwise
	warning('input arguments did not match valid options');
    	warning('function: scCreate.m');
        end%switch
    end%for
end%if


%---------------------------------------------------------
% vectors required to produce circles and lines
%
num_points = 600;
t = linspace(0,(2*pi),num_points);
x = cos(t);
y = sin(t);
line = t.*0;

%---------------------------------------------------------
% Prepare Chart
%
clf;							% clear plot
hold on;						% hold on
plot(x,line,'k');				% horizontal line
plot(x,y,'k');					% gamma=1 circle
axis([-1,1,-1,1],'square')
%replot


%---------------------------------------------------------
% Create Z Smith Chart
%
plot_ind = 1;
num_total_curves = length(circles)+(2*length(arcs));
x_data = ones(num_points,num_total_curves);
y_data = ones(num_points,num_total_curves);

% add circles
for R = circles
re_axis = R/(1+R);
im_axis = 0;
radius = 1/(1+R);
x_data(:,plot_ind) = ((x*radius)+re_axis);
y_data(:,plot_ind) = ((y*radius)+im_axis);
plot_ind = plot_ind+1;
end%if

for X = arcs
% add upper arcs
re_axis = 1;
im_axis = 1/X;
radius = 1/X;
x_data(:,plot_ind) = ((x*radius)+re_axis);
y_data(:,plot_ind) = ((y*radius)+im_axis);
plot_ind = plot_ind+1;

% add lower arcs
X = -X;							
re_axis = 1;
im_axis = 1/X;		
radius = 1/X;
x_data(:,plot_ind) = ((x*radius)+re_axis);
y_data(:,plot_ind) = ((y*radius)+im_axis);
plot_ind = plot_ind+1;
end%if	

%---------------------------------------------------------
% Plot Smith Chart
%
if(plot_Z_chart)
    plot(x_data,y_data,Z_color)
end%if

if(plot_Y_chart)
    plot((-1*x_data),y_data,Y_color)
end%if

%---------------------------------------------------------
% label chart
%
if(add_Z_labels)					
	scAddLabels(circles,arcs)
end%if

end%function





