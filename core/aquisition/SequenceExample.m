classdef SequenceExample

    properties (Constant)
        Default {mustBeValidSequence} = table( ...
            (1:10)', ...
            categorical({'Zelux', 'Zelux', 'Zelux', 'Zelux', 'Andor19330', 'Andor19331', 'Andor19330', 'Andor19331', 'Andor19330', '--inactive--'}, ...
            {'Andor19330', 'Andor19331', 'Zelux', '--inactive--'}, 'Ordinal', true)', ...
            ["Lattice", "DMD", "Lattice", "DMD", "Image", "Image", "Image", "Image", "Image", ""]', ...
            categorical({'Start+Acquire', 'Start+Acquire', 'Analysis', 'Analysis', 'Start', 'Start', 'Acquire', 'Acquire', 'Analysis', 'Analysis'}, ...
            {'Start+Acquire', 'Start', 'Acquire', 'Analysis'}, 'Ordinal', true)', ...
            ["", "", "CalibLat", "FitPSF", "", "", "", "", "CalibLat, CalibDMD", ""]', ...
            'VariableNames', {'Order', 'Camera', 'Label', 'Type', 'Note'})
    end

end
