%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Find the start and end location of each UNIQUE value in a vector
%%%% - Intended to be used to select all the data points at a single frequency
%%%% - when the dataset includes many frequencies.
%%%%
%%%% Input:
%%%% frequency_col - column or row vector
%%%%
%%%% Example Input:
%%%% frequency_col = [2.8; 2.8; 2.8; 3.0; 3.0; 3.0; 3.2; 3.2; 3.2]
%%%% freq_dist = getFreqDistribution(frequency_col)
%%%%
%%%% Output:
%%%%[f1, start_row, end_row, number_of_rows;
%%%% f2, start_row, end_row, number_of_rows;
%%%% f3, start_row, end_row, number_of_rows]
%%%%
%%%% Example Output:
%%%% freq_dist = 
%%%%[2.8, 1, 3, 3;
%%%% 3.0, 4, 6, 3;
%%%% 3.2, 7, 9, 3]
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% getFreqdistribution.m
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function freq_dist = getFreqDistribution(freq_col)

%-----------------------------------------------------
% list of different frequencies in column
% and the number of different frequencies
%
freq_list = unique(freq_col);
num_freqs = length(freq_list);

%-----------------------------------------------------
% loop across frequency list
%
for freq_ind = [1:num_freqs]

	% current frequency			
	freq = freq_list(freq_ind);

	% find the start and end rows for the current frequency
	freq_row_match = [freq_col == freq];
	freq_row_ind = find(freq_row_match);

	% number of data points for current frequency
	rn_start = freq_row_ind(1);
	rn_end = freq_row_ind(length(freq_row_ind));
	num_entries = rn_end-rn_start+1;

	% save info to an array
	freq_dist(freq_ind,:) = [freq,rn_start,rn_end,num_entries];

end%for
end%function
