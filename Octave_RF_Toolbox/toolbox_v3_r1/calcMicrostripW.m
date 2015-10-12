%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate the width of a microstrip line required to produce the desired Zo
%%%%	- Intended to be called from the function calcMicrostripMenu.m
%%%%
%%%% Input:	
%%%% - boardspecs: structure containing the following variables..... 
%%%% boardspecs.Zo
%%%% boardspecs.t --- (needed for use by calcMicrostripZo.m)
%%%% boardspecs.h --- (needed for use by calcMicrostripZo.m)
%%%% boardspecs.Er -- (needed for use by calcMicrostripZo.m)
%%%% boardspecs.W --- (needed for use by calcMicrostripZo.m)
%%%% boardspecs.Ere - (needed for use by calcMicrostripZo.m)
%%%%	
%%%%	
%%%% Output:
%%%% - W: Width in meters (scalar number)
%%%%	
%%%% Usage:
%%%% boardspecs.t = 0.0078e-3;  % conductor thickness
%%%% boardspecs.h = 0.787e-3;   % board height
%%%% boardspecs.Er = 2.2;	% epsilon relative
%%%% boardspecs.W = 2.14e-3;	% width
%%%% boardspecs.Zo = 50;	% characteristic impedance
%%%% boardspecs.Ere = 2.4;	% epsilon effective
%%%% W = calcMicrostripW(boardspecs)
%%%%
%%%% Primary reference: Andrei, p.149
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripW.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function W = calcMicrostripW(boardspecs)

%-------------------------------------
% Inputs
%
Zo_target = boardspecs.Zo; 		% Target Zo, to hit by changing the width
verbose_output = false;			% print status at each iteritive step for debugging
Zo_tol = 0.0001;			% how close Zo must be to the target Zo
max_iterations = 100;			% max number of loops before giving up

%-------------------------------------
% Initialize iteritive variables
%
Zo_error = 0.8;				% used to save the difference between the current Zo and target Zo
Zo_error_last = 1;			% used to save the resulting error from the last guess
W = 0.1;				% initial width
W_step = 0.01;				% initial step size, will change dynamically
tolerance_met = false;			% false until the tolerance is met or until the max number of iterations
num_iterations = 1;			% incriments each pass through the loop
step_counter = 1;			% to keep track of how many steps in each direction we make

%-------------------------------------
% Loop until tolerance is met
%
while(~tolerance_met)

%-------------------------------------
% Calculate Zo from current specs
% Zo depends on Ere. Ere depends on the width.....
% Ere must be recalculated before finding Zo, whenever the width is changed
%
boardspecs.W = W;
boardspecs.Ere = calcMicrostripEre(boardspecs);		% Uses: t, h, Er, W
Zo = calcMicrostripZo(boardspecs);			% Uses: t, h, Er, W, Ere

%-------------------------------------
% Save error from last set of specs
% Calculate error: How far we are from the target
%
Zo_error_last = Zo_error;
Zo_error = Zo-Zo_target;

if(verbose_output)
fprintf(['Zo: ',num2str(Zo),' , Zo_error: ',num2str(Zo_error),' , Zo_error_last: ',num2str(Zo_error_last),'\n']);
end%if

%-------------------------------------
% If we pass the target Zo (when error changes sign), change directions and decrease the incriment
%
if((Zo_error_last*Zo_error) < 0)
	if(verbose_output)
	fprintf('Error changed sign, changing direction and decreasing incriment\n');
	fprintf('~~DING!!!~+~+~+~+~+~+~+~+~+~+~+~+~\n');
	end%if
	W_step = W_step*(-1);
	W_step = W_step/10;
	step_counter = 1;

%-------------------------------------
% elseif we are going away from the target, change directions
% Placed in an elseif to prevent both conditions from being met and changing the sign twice
%
elseif(abs(Zo_error) > abs(Zo_error_last))
	if(verbose_output)
	fprintf('New error is greater than old error, changing direction\n');
	fprintf('~~DING!!!~+~+~+~+~+~+~+~+~+~+~+~+~\n');
	end%if
	W_step = W_step*(-1);
	step_counter = 1;
end%if

%-------------------------------------
% Incriment width
%
W = W+W_step;
%W_step

%-------------------------------------
% If a number of iterations has gone by without passing the target, increase the step size
%
if(step_counter >= 7)
	if(verbose_output)
	fprintf('Slow convergence, increasing step size by 50 percent\n')
	fprintf('~~BOOST!!!\n');
	fprintf('  ^^^^^\n');
	fprintf('   ^^^\n');
	fprintf('    ^\n');
	end%if
	W_step = W_step*1.5;
	step_counter = 1;
else
	step_counter = step_counter+1;
end%if

%-------------------------------------
% If the step size is almost as big as the width, decrease the step size to 40% of the width
% Having a step size bigger than the current width can cause a negative width to be tested
%
if(abs(W_step) >= abs(W*0.5))
	if(verbose_output)
	fprintf('Step magnitude is larger than 50 percent the width, decreasing step to 40 percent of width\n');
	fprintf('  HHHHH\n');
	fprintf('  HHHHH\n');
	fprintf('~~SLOW DOWN!!!\n');
	end%if
	W_step = (W_step/abs(W_step))*(W*0.4);
end%if

%-------------------------------------
% If the tolerance is met, set tolerance_met to true to exit loop
%
if(abs(Zo_error) <= Zo_tol)
	if(verbose_output)
	fprintf('Tolerance successfully met, returning to program.....\n');
	fprintf('~~DROP!!!\n\n\n');
	end%if
	tolerance_met = true;
end%if

%-------------------------------------
% If we hit the max number of iterations, set tolerance_met to true to exit loop
%
if(num_iterations >= max_iterations)
	fprintf('***max number of iterations run, exiting.....\n');
	fprintf('~~BUMMER!!!\n');
	tolerance_met = true;
else
	num_iterations = num_iterations+1;
end%if

end%while


end%function



