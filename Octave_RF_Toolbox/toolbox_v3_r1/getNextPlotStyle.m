%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Get a different line style describing how a curve looks when plotted
%%%% - intended for use with plot()
%%%% - This allows a plot to easily be created with many different looking curves
%%%% - '!' changed to '~' for matlab compatability
%%%%
%%%% Input: 
%%%% One of the following....
%%%% ["k","r","g","b","m","c",
%%%% "-*k","-*r","-*g","-*b","-*m","-*c",
%%%% "-ok","-or","-og","-ob","-om","-oc"];
%%%%
%%%% Output:
%%%%	The next color in the array
%%%%
%%%% Example Usage:
%%%% x = linspace(1,10,10);
%%%% y1 = linspace(1,50,10);
%%%% plot_style = "k";
%%%% plot(x,y1,plot_style);
%%%% hold on;
%%%% plot_style = getNextPlotStyle(plot_style)
%%%% y2 = y1*2;
%%%% plot(x,y2,plot_style);
%%%% hold off;
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% getNextPlotStyle.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function next_style = getNextPlotStyle(current_style)

%----------------------------------------------
% Possible curves style for plots
%
style_options = {'k','r','g','b','m','c','-*k','-*r','-*g','-*b','-*m','-*c','-ok','-or','-og','-ob','-om','-oc'};
%style_options = {'k','r','b','m','-*k','-*r','-*b','-*m','-ok','-or','-ob','-om'};

%----------------------------------------------
% Find the location of the current style and
% incriment to the next position
%
num_options = length(style_options);				% number of style options
current_ind = strcmp(current_style,style_options);		% current_style match equal to 1
current_loc = find(current_ind);				% loc of current style
next_loc = current_loc+1;					% add 1 to current index

%----------------------------------------------
% if input is not an option
% use default style and print a warning
%
if(~any(current_ind))						
next_loc = 1;
fprintf('**[ %c ] is not a color option\n',current_style);
fprintf('**options: k,r,g,b,m,c\n');
fprintf('**using default of k\n');
end%if

%----------------------------------------------
% if out of options
% start at beginning
%
if(next_loc > num_options)
next_loc = 1;
end%if

%----------------------------------------------
% set output
%
next_style = style_options{next_loc};

end%function


