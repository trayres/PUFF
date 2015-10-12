%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function getNextPlotStyle_test()

% Initialize
style = 'k';
num_cycles = 25;

% Print results
fprintf('\n');
fprintf('...Verify returned is one of the expected letters\n');
fprintf(['Expected: [ k,r,g,b,m,c,-*k,-*r,-*g,-*b,-*m,-*c,-ok,-or,-og,-ob,-om,-oc ]\n']); 
while(num_cycles > 0)
   style = getNextPlotStyle(style);
   fprintf(['Returned: [ ',style,' ]\n']);
   num_cycles = num_cycles-1;
end%while
fprintf('\n');

end%function
