%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Get s-parameter matrix at a single frequency
%%%% from sparams matrix, with all frequencies
%%%% Intended to be used with 'sparams = importS2P(folder,filename)'
%%%%
%%%% Output: 
%%%%	2x2 single frequency s-parameter matrix in rectangular form
%%%%	s = 
%%%% 	[s11_rect s12_rect ;
%%%% 	 s21_rect s22_rect ]
%%%%
%%%% Inputs:
%%%%	freq - frequency with the same units as target sparams matrix
%%%%	sparams - S parameter data across multiple frequencies in the form....
%%%%	sparams = 	
%%%% 		[freq1 s11mag s11ang s21mag s21ang s12mag s12ang s22mag s22ang ;
%%%% 		 freq2 s11mag s11ang s21mag s21ang s12mag s12ang s22mag s22ang ;
%%%% 		 freq3 s11mag s11ang s21mag s21ang s12mag s12ang s22mag s22ang ]
%%%% Usage:
%%%%	s = singleFreqSparams(sparams,freq)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% singleFreqSparams.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 8/19/12
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function s = singleFreqSparams(sparams,freq)

%----------------------------------
% Initialize
%
s = zeros(2,2);

%----------------------------------
% Find row of desired frequency
%
a = [sparams(:,1)==freq];		% set desired freq location to 1, all others 0
[f_loc] = find(a);			% find location of entry equal to 1
freq_found = any(a);			% test if frequency match was found

%----------------------------------
% Continue only if freq exists in sparams matrix
%
if(freq_found)

%----------------------------------
% Extract row of parameters at desired freq
%
s_row = sparams(f_loc,:);		

%----------------------------------
% Separate row into variables
%
f = s_row(1);
s11_mag = s_row(2);
s11_ang = s_row(3);
s21_mag = s_row(4);
s21_ang = s_row(5);
s12_mag = s_row(6);
s12_ang = s_row(7);
s22_mag = s_row(8);
s22_ang = s_row(9);

%----------------------------------
% Create S-parameter matrix
%
s(1,1) = ptor(s11_mag,s11_ang);
s(1,2) = ptor(s12_mag,s12_ang);
s(2,1) = ptor(s21_mag,s21_ang);
s(2,2) = ptor(s22_mag,s22_ang);

else
printf('**Desired frequency (%2.3f) not found in sparam matrix\n',freq); 
printf('**function: singleFreqSparams.m\n');
end%if

end%function





