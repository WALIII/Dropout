function matches = SRF_DateRead(H)
% regular expression to extract numbers
matches = regexp(H, '_([0-9]{1,2})_([0-9]{1,2})_([0-9]{1,2})_([0-9]{1,2})_([0-9]{1,2})', 'tokens');

% convert strings to numbers
matches = cellfun(@(x) cellfun(@str2double, x{1}), matches, 'UniformOutput', false);

% make datetime object
matches = cellfun(@(x) datetime(2016, x(1), x(2), x(3), x(4), x(5)), matches, 'UniformOutput', false);

% concatenate into vector (because cell arrays suck)
matches = cat(1, matches{:});