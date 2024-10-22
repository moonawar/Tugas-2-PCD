classdef Assignment_2 < matlab.apps.AppBase
    % Properties that correspond to app components
    properties (Access = public)
        Assignment_2_PCD_UIFigure      matlab.ui.Figure
        ConvolutionMenu                matlab.ui.container.Menu
        ImageSmoothingMenu             matlab.ui.container.Menu
        HighpassfilterMenu             matlab.ui.container.Menu
        Line_1                         matlab.ui.control.Image
        Line_2                         matlab.ui.control.Image
        Line_3                         matlab.ui.control.Image
        ImageSmoothingPanel            matlab.ui.container.Panel
        ISRunButton                    matlab.ui.control.Button
        ISDomain                       matlab.ui.control.DropDown
        ISInputLabel                   matlab.ui.control.Label
        ISSelectFileButton             matlab.ui.control.Button
        ISSelectedImage                matlab.ui.control.Label
        ISInputImageLabel              matlab.ui.control.Label
        ISInputImage                   matlab.ui.control.Image
        ISFreqResultsPanel             matlab.ui.container.Panel
        ISFreqResultDesc               matlab.ui.control.Label
        ISFreqILPFLabel                matlab.ui.control.Label
        ISFreqILPFImage                matlab.ui.control.Image
        ISFreqGLPFLabel                matlab.ui.control.Label
        ISFreqGLPFImage                matlab.ui.control.Image
        ISFreqBLPFLabel                matlab.ui.control.Label
        ISFreqBLPFImage                matlab.ui.control.Image
        ISSpatialResultsPanel          matlab.ui.container.Panel
        ISSpatResultDesc               matlab.ui.control.Label
        ISSpatResMeanLabel             matlab.ui.control.Label
        ISSpatResMeanImage             matlab.ui.control.Image
        ISSpatResGaussLabel            matlab.ui.control.Label
        ISSpatResGaussImage            matlab.ui.control.Image
        ProcessingDomainDropDownLabel  matlab.ui.control.Label
        Assignment                     matlab.ui.control.Label
        Louis                          matlab.ui.control.Label
        Addin                          matlab.ui.control.Label
    end

    methods (Access = private)
        function switchToMenu(app, menu)
            app.ImageSmoothingPanel.Visible = 'off';

            switch menu
                case 'Convolution'
                    app.ConvolutionPanel.Visible = 'on';
                case 'Image Smoothing'
                    app.ImageSmoothingPanel.Visible = 'on';
                case 'High-pass filter'
                    app.HighpassfilterPanel.Visible = 'on';
            end
        end
    end
    

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create Assignment_2_PCD_UIFigure and hide until all components are created
            app.Assignment_2_PCD_UIFigure = uifigure('Visible', 'off');
            app.Assignment_2_PCD_UIFigure.AutoResizeChildren = 'off';
            app.Assignment_2_PCD_UIFigure.Color = [1 1 1];
            app.Assignment_2_PCD_UIFigure.Position = [0 0 1080 720];
            app.Assignment_2_PCD_UIFigure.Name = 'Assignment_2_PCD';
            app.Assignment_2_PCD_UIFigure.Resize = 'off';

            % Create ConvolutionMenu
            app.ConvolutionMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.ConvolutionMenu.Text = 'Convolution';

            % Create ImageSmoothingMenu
            app.ImageSmoothingMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.ImageSmoothingMenu.Text = 'Image Smoothing';

            % Create HighpassfilterMenu
            app.HighpassfilterMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.HighpassfilterMenu.Text = 'High-pass filter';

            % Create Addin
            app.Addin = uilabel(app.Assignment_2_PCD_UIFigure);
            app.Addin.FontName = 'helv';
            app.Addin.FontSize = 16;
            app.Addin.Position = [43 46 260 22];
            app.Addin.Text = 'Addin Munawwar Yusuf - 13521085';

            % Create Louis
            app.Louis = uilabel(app.Assignment_2_PCD_UIFigure);
            app.Louis.FontName = 'helv';
            app.Louis.FontSize = 16;
            app.Louis.Position = [43 78 245 22];
            app.Louis.Text = 'Louis Caesa Kesuma - 13521069';

            % Create Assignment
            app.Assignment = uilabel(app.Assignment_2_PCD_UIFigure);
            app.Assignment.FontName = 'helv';
            app.Assignment.FontSize = 24;
            app.Assignment.FontWeight = 'bold';
            app.Assignment.Position = [43 115 380 32];
            app.Assignment.Text = 'Assignment 2 Image Processing';

            % Create ImageSmoothingPanel
            app.ImageSmoothingPanel = uipanel(app.Assignment_2_PCD_UIFigure);
            app.ImageSmoothingPanel.BorderColor = [0 0 0];
            app.ImageSmoothingPanel.HighlightColor = [0 0 0];
            app.ImageSmoothingPanel.BorderType = 'none';
            app.ImageSmoothingPanel.BorderWidth = 0;
            app.ImageSmoothingPanel.Title = 'Image Smoothing';
            app.ImageSmoothingPanel.BackgroundColor = [1 1 1];
            app.ImageSmoothingPanel.FontName = 'Gloucester MT Extra Condensed';
            app.ImageSmoothingPanel.FontWeight = 'bold';
            app.ImageSmoothingPanel.FontSize = 16;
            app.ImageSmoothingPanel.Position = [43 210 984 478];

            % Create ProcessingDomainDropDownLabel
            app.ProcessingDomainDropDownLabel = uilabel(app.ImageSmoothingPanel);
            app.ProcessingDomainDropDownLabel.HorizontalAlignment = 'right';
            app.ProcessingDomainDropDownLabel.Position = [-4 409 109 22];
            app.ProcessingDomainDropDownLabel.Text = 'Processing Domain';

            % Create ISSpatialResultsPanel
            app.ISSpatialResultsPanel = uipanel(app.ImageSmoothingPanel);
            app.ISSpatialResultsPanel.Enable = 'off';
            app.ISSpatialResultsPanel.BorderWidth = 0;
            app.ISSpatialResultsPanel.Title = 'Results';
            app.ISSpatialResultsPanel.Visible = 'off';
            app.ISSpatialResultsPanel.BackgroundColor = [1 1 1];
            app.ISSpatialResultsPanel.FontWeight = 'bold';
            app.ISSpatialResultsPanel.FontSize = 16;
            app.ISSpatialResultsPanel.Position = [367 36 608 368];

            % Create ISSpatResGaussImage
            app.ISSpatResGaussImage = uiimage(app.ISSpatialResultsPanel);
            app.ISSpatResGaussImage.Position = [264 34 237 237];

            % Create ISSpatResGaussLabel
            app.ISSpatResGaussLabel = uilabel(app.ISSpatialResultsPanel);
            app.ISSpatResGaussLabel.FontSize = 14;
            app.ISSpatResGaussLabel.FontWeight = 'bold';
            app.ISSpatResGaussLabel.Position = [268 279 115 25];
            app.ISSpatResGaussLabel.Text = 'Gaussian Filter';

            % Create ISSpatResMeanImage
            app.ISSpatResMeanImage = uiimage(app.ISSpatialResultsPanel);
            app.ISSpatResMeanImage.Position = [1 34 237 237];

            % Create ISSpatResMeanLabel
            app.ISSpatResMeanLabel = uilabel(app.ISSpatialResultsPanel);
            app.ISSpatResMeanLabel.FontSize = 14;
            app.ISSpatResMeanLabel.FontWeight = 'bold';
            app.ISSpatResMeanLabel.Position = [5 279 115 25];
            app.ISSpatResMeanLabel.Text = 'Mean Filter';

            % Create ISSpatResultDesc
            app.ISSpatResultDesc = uilabel(app.ISSpatialResultsPanel);
            app.ISSpatResultDesc.Position = [5 318 260 22];
            app.ISSpatResultDesc.Text = 'Image smoothing in spatial domain';

            % Create ISFreqResultsPanel
            app.ISFreqResultsPanel = uipanel(app.ImageSmoothingPanel);
            app.ISFreqResultsPanel.BorderWidth = 0;
            app.ISFreqResultsPanel.Title = 'Results';
            app.ISFreqResultsPanel.BackgroundColor = [1 1 1];
            app.ISFreqResultsPanel.FontWeight = 'bold';
            app.ISFreqResultsPanel.FontSize = 16;
            app.ISFreqResultsPanel.Position = [367 35 608 368];

            % Create ISFreqBLPFImage
            app.ISFreqBLPFImage = uiimage(app.ISFreqResultsPanel);
            app.ISFreqBLPFImage.Position = [413 98 173 173];

            % Create ISFreqBLPFLabel
            app.ISFreqBLPFLabel = uilabel(app.ISFreqResultsPanel);
            app.ISFreqBLPFLabel.FontSize = 14;
            app.ISFreqBLPFLabel.FontWeight = 'bold';
            app.ISFreqBLPFLabel.Position = [417 279 115 25];
            app.ISFreqBLPFLabel.Text = 'BLPF Filter';

            % Create ISFreqGLPFImage
            app.ISFreqGLPFImage = uiimage(app.ISFreqResultsPanel);
            app.ISFreqGLPFImage.Position = [210 99 173 173];

            % Create ISFreqGLPFLabel
            app.ISFreqGLPFLabel = uilabel(app.ISFreqResultsPanel);
            app.ISFreqGLPFLabel.FontSize = 14;
            app.ISFreqGLPFLabel.FontWeight = 'bold';
            app.ISFreqGLPFLabel.Position = [214 280 115 25];
            app.ISFreqGLPFLabel.Text = 'GLPF Filter';

            % Create ISFreqILPFImage
            app.ISFreqILPFImage = uiimage(app.ISFreqResultsPanel);
            app.ISFreqILPFImage.Position = [1 98 173 173];

            % Create ISFreqILPFLabel
            app.ISFreqILPFLabel = uilabel(app.ISFreqResultsPanel);
            app.ISFreqILPFLabel.FontSize = 14;
            app.ISFreqILPFLabel.FontWeight = 'bold';
            app.ISFreqILPFLabel.Position = [5 279 115 25];
            app.ISFreqILPFLabel.Text = 'ILPF Filter';

            % Create ISFreqResultDesc
            app.ISFreqResultDesc = uilabel(app.ISFreqResultsPanel);
            app.ISFreqResultDesc.Position = [5 318 260 22];
            app.ISFreqResultDesc.Text = 'Image smoothing in frequency domain';

            % Create ISInputImage
            app.ISInputImage = uiimage(app.ImageSmoothingPanel);
            app.ISInputImage.Position = [5 69 237 237];

            % Create ISInputImageLabel
            app.ISInputImageLabel = uilabel(app.ImageSmoothingPanel);
            app.ISInputImageLabel.FontSize = 14;
            app.ISInputImageLabel.FontWeight = 'bold';
            app.ISInputImageLabel.Position = [5 314 84 25];
            app.ISInputImageLabel.Text = 'Input Image';

            % Create ISSelectedImage
            app.ISSelectedImage = uilabel(app.ImageSmoothingPanel);
            app.ISSelectedImage.FontAngle = 'italic';
            app.ISSelectedImage.Position = [109 353 104 22];
            app.ISSelectedImage.Text = 'No image selected';

            % Create ISSelectFileButton
            app.ISSelectFileButton = uibutton(app.ImageSmoothingPanel, 'push');
            app.ISSelectFileButton.Position = [1 352 100 23];
            app.ISSelectFileButton.Text = 'Select File';

            % Create ISInputLabel
            app.ISInputLabel = uilabel(app.ImageSmoothingPanel);
            app.ISInputLabel.Position = [1 381 68 22];
            app.ISInputLabel.Text = 'Input Image';

            % Create ISDomain
            app.ISDomain = uidropdown(app.ImageSmoothingPanel);
            app.ISDomain.Items = {'Spatial', 'Frequency'};
            app.ISDomain.Position = [120 409 100 22];
            app.ISDomain.Value = 'Spatial';

            % Create ISRunButton
            app.ISRunButton = uibutton(app.ImageSmoothingPanel, 'push');
            app.ISRunButton.FontSize = 14;
            app.ISRunButton.Position = [6 18 235 32];
            app.ISRunButton.Text = 'Run';

            % Create Line_3
            app.Line_3 = uiimage(app.Assignment_2_PCD_UIFigure);
            app.Line_3.Position = [340 662 741 10];
            app.Line_3.ImageSource = fullfile(pathToMLAPP, 'assets', 'LineHor.png');

            % Create Line_2
            app.Line_2 = uiimage(app.Assignment_2_PCD_UIFigure);
            app.Line_2.Position = [334 179 13 542];
            app.Line_2.ImageSource = fullfile(pathToMLAPP, 'assets', 'LineVert.png');

            % Create Line_1
            app.Line_1 = uiimage(app.Assignment_2_PCD_UIFigure);
            app.Line_1.Position = [1 175 1080 10];
            app.Line_1.ImageSource = fullfile(pathToMLAPP, 'assets', 'LineHor.png');

            % Show the figure after all components are created
            app.Assignment_2_PCD_UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Assignment_2

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.Assignment_2_PCD_UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.Assignment_2_PCD_UIFigure)
        end
    end
end