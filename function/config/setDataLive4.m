function setDataLive4(exposure)
    arguments
        exposure (1,1) double {mustBePositive,mustBeFinite} = 0.2
    end

    % Set acquisition mode; 4 for fast kinetics
    [ret] = SetAcquisitionMode(4);
    CheckWarning(ret);
    
    % Set trigger mode; 0 for internal, 1 for external
    [ret] = SetTriggerMode(1);
    CheckWarning(ret);
    
    % Set Pre-Amp Gain, 0 (1x), 1 (2x), 2 (4x).
    [ret] = SetPreAmpGain(2);
    CheckWarning(ret);
    
    % Set Horizontal speed. (0,0) = 5 MHz, (0,1) = 3 MHz, (0,2) = 1 MHz, (0,3) = 50 kHz
    [ret] = SetHSSpeed(0, 2);
    CheckWarning(ret);
    
    % Set Vertical Shift speed. 0 = 2.25 us, 1 = 4.25 us, 2 = 8.25 us, 3 = 16.25 us, 4 = 32.25 us, 5 = 64.25 us
    [ret] = SetVSSpeed(1);
    CheckWarning(ret);
    
    % Set Crop mode. 1 = ON/0 = OFF; Crop height; Crop width; Vbin; Hbin
    [ret] = SetIsolatedCropMode(0, 1024, 1024, 1, 1);
    CheckWarning(ret)
    
    % Get detector size (with croped mode ON this may change)
    [ret, YPixels, XPixels] = GetDetector();
    CheckWarning(ret);
    
    % Set the image size
    [ret] = SetImage(1, 1, 1, YPixels, 1, XPixels);
    CheckWarning(ret);
    
    % Configure fast kinetics mode acquisition
    % 256 for exposed rows; 4 for series length; 4 for Image;
    % 1 for horizontal binning; 1 for vertical binning; 768 for offset
    [ret] = SetFastKineticsEx(256, 4, exposure, 4, 1, 1, 768);
    CheckWarning(ret);
    
    fprintf('\n***FK4 mode***\n')
    fprintf('Exposure time is %4.2fs\n', exposure)

end