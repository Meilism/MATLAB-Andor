classdef LayoutManager < BaseObject

    properties (SetAccess = immutable)
        BigAxes1 (1, 1) AxesRunner
        BigAxes2 (1, 1) AxesRunner
        SmallAxes1 (1, 1) AxesRunner
        SmallAxes2 (1, 1) AxesRunner
        SmallAxes3 (1, 1) AxesRunner
        SmallAxes4 (1, 1) AxesRunner
        SmallAxes5 (1, 1) AxesRunner
    end

    methods
        function obj = LayoutManager(app, config)
            arguments
                app = []
                config.BigAxes1 = AxesConfig("style", "Image", "func", "None")
                config.BigAxes2 = AxesConfig("style", "Image", "func", "None")
                config.SmallAxes1 = AxesConfig("style", "Line")
                config.SmallAxes2 = AxesConfig("style", "Line")
                config.SmallAxes3 = AxesConfig("style", "Line")
                config.SmallAxes4 = AxesConfig("style", "Line")
                config.SmallAxes5 = AxesConfig("style", "Line")
            end
            for field = obj.getPropList()
                if isprop(app, field)
                    obj.(field) = AxesRunner(app.(field), config.(field));
                else
                    obj.warn("Field %s is not a valid field of app.", field)
                end
            end
        end
    
        function update(obj, Live, names, options)
            arguments
                obj
                Live (1, 1) struct
                names = obj.getPropList()
                options.verbose (1, 1) logical = false
            end
            timer = tic;
            for field = names
                obj.(field).update(Live)
            end
            drawnow
            if options.verbose
                obj.info("Layout rendered in %.3f s.", toc(timer))
            end
        end

        function clear(obj, names)
            arguments
                obj
                names = obj.getPropList()
            end
            for field = names
                obj.(field).clear()
            end
        end
    end

end