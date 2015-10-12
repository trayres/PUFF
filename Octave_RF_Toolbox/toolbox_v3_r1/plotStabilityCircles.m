%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Plot stability circles
%%%% -From s2p file, or specific s-parameters
%%%% -From fmin to fmax, or all frequencies
%%%% - '!' changed to '~' for matlab compatability
%%%%
%%%% Usage:
%%%%	1 Argument: 	
%%%%		plotStabilityCircles([s11rect,s12rect;s21rect,s22rect])
%%%%		- plot stability circles for specific s-parameters
%%%%		- freq = 1 (just a filler value)
%%%%		- f_min = 0
%%%%		- f_max = infinity
%%%%	2 Arguments: 	
%%%%		plotStabilityCircles(folder,filename)
%%%%		- plot stability circles for all frequencies in file
%%%%		- f_min = 0
%%%%		- f_max = infinity
%%%%	4 Arguments: 	
%%%%		plotStabilityCircles(folder,filename,f_min,f_max)
%%%%
%%%% To do: 
%%%% - Fix legend issue after update
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% plotStabilityCircles.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function plotStabilityCircles(varargin)

%---------------------------------------------------------
% Inputs
%
switch (nargin)
case 1
	sparams = sToRowForm(varargin{1});
	f_min = 0;
	f_max = inf;
case 2
	folder = varargin{1};
	filename = varargin{2};
	fprintf('No frequency range specified\n');
	fprintf('Plotting all frequencies available\n');
	f_min = 0;
	f_max = inf;
	[sparams,additional_dataset] = importS2P(folder,filename);
case 4
	folder = varargin{1};
	filename = varargin{2};
	f_min = varargin{3};
	f_max = varargin{4};
	[sparams,additional_dataset] = importS2P(folder,filename);
otherwise
	warning('incorrect number of arguments to function plotStabilityCircles')
	warning('Usage:    plotStabilityCircles(folder,filename,f_min,f_max)')
end%switch

%---------------------------------------------------------
% To manually specify Inputs
%
%folder = 's2p_files';
%filename = 'NESG3031M05_Vc_2V_Ic_10mA.s2p';
%f_min = 2.9					% start frequency (same units as file)
%f_max = 3.1					% end frequency (same units as file)
%[sparams,additional_dataset] = importS2P(folder,filename);
%
%s = [ptor(0.69,-78),ptor(0.033,41.4);ptor(5.67,123),ptor(0.84,-25)];	% amps HW8-Prob3(gonz 3.14)
%f_min = 0;
%f_max = inf;


%---------------------------------------------------------
% Initialize
%
unconditionally_stable = false;					% 1 = true, 0 = false
smithchart_exists = 0;						% only want to create it once

%---------------------------------------------------------
% Find row number of max and min frequency
%
f_all = sparams(:,1);				% frequency column

f_h_ind = [f_all>=f_min];			% set values greater than fmin to 1 (else 0)
f_h_loc = find(f_h_ind);			% location of values >= fmin
f_min_loc = f_h_loc(1);				% first row w/ freq greater than fmin

f_l_ind = [f_all<=f_max];			% set values less than fmax to 1 (else 0)
f_l_loc = find(f_l_ind);			% location of values <= fmax
f_max_loc = f_l_loc(length(f_l_loc));		% last row w/ freq less than fmax

%---------------------------------------------------------
% Extract rows/s-parameters within frequency range
%
s_all = sparams(f_min_loc:f_max_loc,:);		% strip freqs less than fmin & greater than fmax
foi = sparams(f_min_loc:f_max_loc,1);		% frequencies of interest
f_num = length(foi);				% number of s-param sets within freq range


%---------------------------------------------------------
% Loop through each frequency/row
%
for row = [1:f_num]

%---------------------------------------------------------
% Create s-parameter matrix for single frequency
%
freq = foi(row);				% current frequency
s = singleFreqSparams(sparams,freq);		% s-parameter matrix at current frequency


%---------------------------------------------------------
% Test for unconditional stability (k-delta test)
%
[k,delta,u] = testStability(s);
%k
%delta_mag = abs(delta)
%u
if((k>1) && (abs(delta)<1))					% if unconditionally stable
	unconditionally_stable = true;				
else								% if NOT unconditionally stable
	unconditionally_stable = false;				
end%if

%---------------------------------------------------------
% Plot stability circle 
% if NOT unconditionally stable
%
if(unconditionally_stable)
	fprintf('-----Frequency: %2.2f - ',freq);
	fprintf('unconditionally stable\n');
else
	fprintf('-----Frequency: %2.2f - ',freq);
	fprintf('potentially unstable - ');
	fprintf('plotting stability circles\n');
	[Cs_mag,Cs_ang,Rs,CL_mag,CL_ang,RL] = calcStabilityCircles(s);

	if(~smithchart_exists)					% if smith chart has not been created yet
	scCreate						% create smith chart
	smithchart_exists = 1;					%
    end%if							%

	scAddCircle(Cs_mag,Cs_ang,Rs,'r')			% plot stability circles
	legend(['Cs:',num2str(Cs_mag),'<',num2str(Cs_ang),',Rs:',num2str(Rs)])
	scAddCircle(CL_mag,CL_ang,RL,'b')
	legend(['CL:',num2str(CL_mag),'<',num2str(CL_ang),',RL:',num2str(RL)])
    fprintf('Red is the gammaIn=1, for all loads (gammaL)\n');
    fprintf('Blue is the gammaOut=1, for all sources (gammaS)\n');
end%if

end%for

end%function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Convert 2x2 S-parameter matrix to 1x9 s2p form
%%%% From: [s11_rect s12_rect;
%%%%        s21_rect s22_rect]
%%%% To: [freq s11mag s11ang s21mag s21ang s12mag s12ang s22mag s22ang]
function sparams = sToRowForm(s)

freq = 1;				% random freq, just a filler value
s11mag = abs(s(1,1));
s11ang = angle(s(1,1))*(180/pi);
s21mag = abs(s(2,1));
s21ang = angle(s(2,1))*(180/pi);
s12mag = abs(s(1,2));
s12ang = angle(s(1,2))*(180/pi);
s22mag = abs(s(2,2));
s22ang = angle(s(2,2))*(180/pi);

sparams = [freq,s11mag,s11ang,s21mag,s21ang,s12mag,s12ang,s22mag,s22ang];

end%function




