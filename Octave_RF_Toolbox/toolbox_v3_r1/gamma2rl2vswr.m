%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert between gamma, return loss, and VSWR
%%%% 
%%%% Inputs:
%%%% argument 1: 'gamma', 'rl', or 'vswr'
%%%% argument 2: numerical value
%%%%
%%%% Outputs:
%%%% [gamma, RL(db), vswr]
%%%%
%%%% Usage:
%%%% [gamma,RL,vswr] = gamma2rl2vswr('gamma',0.333) 
%%%% [gamma,RL,vswr] = gamma2rl2vswr('RL',11.3)
%%%% [gamma,RL,vswr] = gamma2rl2vswr('vswr',2)
%%%%
%%%% If the function is called with a number of arguments other than 2, it will
%%%% calculate a range of values.  The full matrix will be
%%%% printed to the terminal and each return variable will be an 
%%%% array of related values.
%%%% Usage: 
%%%% [gamma,RL,vswr] = gamma2rl2vswr
%%%%
%%%% Accepted values for first argument.....
%%%% To enter gamma: 'gamma','Gamma','refl_coef'
%%%% To enter return_loss: 'rl','RL','Rl','return_loss','Return_Loss'
%%%% To enter vswr: 'VSWR','Vswr','vswr'
%%%%
%%%% Notes: 
%%%% gamma is another name for the reflection coeff.
%%%% gamma is a scalar magnitude value.  No angle needed.
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% gamma2rf2vswr.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [gamma,RL,vswr] = gamma2rl2vswr(varargin)

%---------------------------------------
% Possible input arguments
%
options_gamma = {'gamma','Gamma','refl_coef'};
options_RL = {'rl','RL','Rl','return_loss','Return_Loss'};
options_vswr = {'VSWR','Vswr','vswr'};

%---------------------------------------
% Initialize variables
%
gamma = 1;
RL = 1;
vswr = 1;
num_points = 100;

%---------------------------------------
% Save input arguments or proceed to calculate a range of values
%
switch(nargin)
case 2
input_var = varargin{1};
input_val = varargin{2};
otherwise
input_var = 'list_all';
input_val = 0;
fprintf('\nPrint reference table of each variable\n')
end%switch

%---------------------------------------
% Determine type of input and calculate return values
%
switch(input_var)
case options_gamma
	gamma = input_val;
	RL = -20*log10(gamma);
	vswr = (1+gamma)/(1-gamma);
case options_RL
	RL = input_val;
	gamma = 10^(RL/-20);
	vswr = (1+gamma)/(1-gamma);
case options_vswr
	vswr = input_val;
	gamma = (vswr-1)/(vswr+1);
	RL = -20*log10(gamma);
case 'list_all'
	gamma = linspace(0,1,num_points);
	RL = -20*log10(gamma);
	vswr = (1+gamma)./(1-gamma);
	column_headings = {'gamma','RL','vswr'}'
	output_matrix = [gamma',RL',vswr']
otherwise
	fprintf('****First argument is NOT a valid option****\n');
	fprintf('Accepted values for first argument.....\n');
	fprintf('gamma,Gamma,refl_coef\n');
	fprintf('rl,RL,Rl,return_loss,Return_Loss\n');
	fprintf('VSWR,Vswr,vswr\n');
end%switch

end%function





