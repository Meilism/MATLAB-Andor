classdef SequenceRegistry

    properties (Constant)
        Empty = table( ...
            (1:10)', ...
            categorical({'--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--', '--inactive--'}, ...
            {'Andor19330', 'Andor19331', 'Zelux', '--inactive--'}, 'Ordinal', true)', ...
            ["", "", "", "", "", "", "", "", "", ""]', ...
            categorical({'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis', 'Analysis'}, ...
            {'Start+Acquire', 'Start', 'Acquire', 'Analysis'}, 'Ordinal', true)', ...
            ["", "", "", "", "", "", "", "", "", ""]', ...
            'VariableNames', {'Order', 'Camera', 'Label', 'Type', 'Note'})
        Sequence4Basic = table( ...
            (1:10)', ...
            categorical({'Andor19330', 'Andor19331', 'Zelux', 'Zelux', 'Andor19330', 'Andor19331', 'Andor19330', 'Andor19331', '--inactive--', '--inactive--'}, ...
            {'Andor19330', 'Andor19331', 'Zelux', '--inactive--'}, 'Ordinal', true)', ...
            ["Image", "Image", "Lattice", "DMD", "Image", "Image", "Image", "Image", "", ""]', ...
            categorical({'Start', 'Start', 'Start+Acquire', 'Start+Acquire', 'Acquire', 'Acquire', 'Analysis', 'Analysis', 'Analysis', 'Analysis'}, ...
            {'Start+Acquire', 'Start', 'Acquire', 'Analysis'}, 'Ordinal', true)', ...
            ["", "", "", "", "", "", "FitCenter", "FitCenter", "", ""]', ...
            'VariableNames', {'Order', 'Camera', 'Label', 'Type', 'Note'})
        Sequence4Analysis = table( ...
            (1:12)', ...
            categorical({'Andor19330', 'Andor19331', 'Zelux', 'Zelux', 'Zelux', 'Zelux', 'Andor19330', 'Andor19331', 'Andor19330', 'Andor19331', '--inactive--', '--inactive--'}, ...
            {'Andor19330', 'Andor19331', 'Zelux', '--inactive--'}, 'Ordinal', true)', ...
            ["Image", "Image", "Lattice", "DMD", "Lattice", "DMD", "Image", "Image", "Image", "Image", "", ""]', ...
            categorical({'Start', 'Start', 'Start+Acquire', 'Start+Acquire', 'Analysis', 'Analysis', 'Acquire', 'Acquire', 'Analysis', 'Analysis', 'Analysis', 'Analysis'}, ...
            {'Start+Acquire', 'Start', 'Acquire', 'Analysis'}, 'Ordinal', true)', ...
            ["", "", "", "", "CalibLatR", "FitCenter", "", "", "FitCenter, CalibLatR", "FitCenter, CalibLatR", "", ""]', ...
            'VariableNames', {'Order', 'Camera', 'Label', 'Type', 'Note'})
    end

end
