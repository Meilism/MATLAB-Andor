%% Create a generator object
clear; clc;
p = LatCaliber;

%% Config data path
% If calibrating initially, set LatCalibFilePath to []
p.config( ...
    "LatCalibFilePath", [], ... 
    "DataPath", "data/2024/09 September/20240930 multilayer/FK2_focused_to_major_layer.mat")
p.init()

%% Plot FFT of a small box
close all
p.plot("Andor19330")

%% Input initial peak positions, [x1, y1; x2, y2]
close all
p.calibrate("Andor19330", [105, 204; 156, 241; 212, 210])

%% Andor19331
close all
p.plot("Andor19331")

%%
close all
p.calibrate("Andor19331", [116, 165; 155, 216; 227, 212])

%%
close all
p.plot("Zelux")

%%
close all
p.calibrate("Zelux", [656, 566; 716, 595; 779, 571])

%% Save calibration
p.save()

%% Recalibrate
% Set an initial calibration and new data for re-calibration
p.config( ...
    "LatCalibFilePath", "calibration/LatCalib_20241002.mat", ... 
    "DataPath", "data/2024/10 October/20241004/anchor=64_array64_spacing=70_centered_r=20_r=10.mat")
p.init()
p.recalibrate()

%% Save recalibration (default is with today's date)
close all
p.save()
