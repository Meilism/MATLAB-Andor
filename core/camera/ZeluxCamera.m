classdef ZeluxCamera < Camera
    %ZELUXCAMERA Zelux camera class
    
    properties (SetAccess = protected)
        CameraSDK = nan
        CameraHandle = nan
    end
    
    methods
        function obj = ZeluxCamera(index, config)
            arguments
                index (1, 1) double = 0
                config = ZeluxCameraConfig()
            end
            obj@Camera(index, config)
        end
        
        function init(obj)
            if obj.Initialized
                return
            end
            % Load TLCamera DotNet assembly.
            % The assembly .dll is assumed to be in the same folder as the scripts.
            old_path = cd("dlls/");
            NET.addAssembly([pwd, '/Thorlabs.TSI.TLCamera.dll']);
            try
                obj.CameraSDK = Thorlabs.TSI.TLCamera.TLCameraSDK.OpenTLCameraSDK;
            catch
                cd(old_path)
                error('%s: Unable to load SDK, check if the camera is already initialized.', obj.CurrentLabel)
            end
            cd(old_path)

            % Get serial numbers of connected TLCameras.
            serialNumbers = obj.CameraSDK.DiscoverAvailableCameras;
            if serialNumbers.Count - 1 < obj.CameraIdentifier
                error('%s: Camera index out of range. Number of cameras found: %d', obj.CurrentLabel, serialNumbers.Count)
            end
            obj.CameraHandle = obj.CameraSDK.OpenCamera(serialNumbers.Item(obj.CameraIdentifier), false);
            obj.CameraConfig.XPixels = obj.CameraHandle.ImageHeight_pixels;
            obj.CameraConfig.YPixels = obj.CameraHandle.ImageWidth_pixels;
            obj.Initialized = true;
            obj.config()
            fprintf('%s: Camera initialized.\n', obj.CurrentLabel)
        end

        function close(obj)
            if obj.Initialized
                obj.abortAcquisition()
                obj.CameraHandle.Dispose;
                obj.CameraSDK.Dispose;
                obj.Initialized = false;
                obj.CameraHandle = nan;
                obj.CameraSDK = nan;
                fprintf('%s: Camera closed.\n', obj.CurrentLabel)
            end
        end

        function config(obj, varargin)
            config@Camera(obj, varargin{:})
            obj.abortAcquisition()
            obj.CameraHandle.ExposureTime_us = obj.CameraConfig.Exposure * 1e6;
            if obj.CameraConfig.ExternalTrigger
                obj.CameraHandle.OperationMode = Thorlabs.TSI.TLCameraInterfaces.OperationMode.HardwareTriggered;
            else
                obj.CameraHandle.OperationMode = Thorlabs.TSI.TLCameraInterfaces.OperationMode.SoftwareTriggered;
            end
            obj.CameraHandle.FramesPerTrigger_zeroForUnlimited = 1;
        end

        function startAcquisition(obj)
            obj.checkStatus()
            % Put the camera in armed state, ready to receive trigger.
            if ~obj.CameraHandle.IsArmed
                obj.CameraHandle.Arm;
            end
            % Issue a software trigger if triggered internally.
            if ~obj.CameraConfig.ExternalTrigger
                obj.CameraHandle.IssueSoftwareTrigger;
            end
        end

        function abortAcquisition(obj)
            if obj.Initialized && obj.CameraHandle.IsArmed
                obj.CameraHandle.Disarm;
                fprintf('%s: Acquisition aborted.\n', obj.CurrentLabel)
            end
        end

        function is_acquiring = isAcquiring(obj)
            is_acquiring = obj.CameraHandle.NumberOfQueuedFrames == 0;
        end

        function [image, num_frames, is_saturated] = acquireImage(obj)
            num_frames = obj.CameraHandle.NumberOfQueuedFrames;
            if num_frames == 0
                image = [];
                is_saturated = false;
                return
            end
            if num_frames > 1
                warning('%s: Data processing falling behind acquisition. %d remains.', obj.CurrentLabel, obj.CameraHandle.NumberOfQueuedFrames)
            end
            imageFrame = obj.CameraHandle.GetPendingFrameOrNull;
            image = reshape(uint16(imageFrame.ImageData.ImageData_monoOrBGR), [obj.CameraConfig.XPixels, obj.CameraConfig.YPixels]);
            is_saturated = any(image(:) == obj.CameraConfig.MaxPixelValue);
        end

    end
end
