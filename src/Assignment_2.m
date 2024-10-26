classdef Assignment_2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        Assignment_2_PCD_UIFigure      matlab.ui.Figure
        ConvolutionMenu                matlab.ui.container.Menu
        ImageSmoothingMenu             matlab.ui.container.Menu
        HighpassFilterMenu             matlab.ui.container.Menu
        SpatialNoiseFilterMenu         matlab.ui.container.Menu
        Line_2                         matlab.ui.control.Image
        Line_1                         matlab.ui.control.Image
        SpatialNoiseFilter             matlab.ui.container.Panel
        SNNoise                        matlab.ui.control.DropDown
        NoiseLabel                     matlab.ui.control.Label
        SNRunButton                    matlab.ui.control.Button
        SNInputLabel                   matlab.ui.control.Label
        SNSelectFileButton             matlab.ui.control.Button
        SNSelectedImage                matlab.ui.control.Label
        SNInputImageLabel              matlab.ui.control.Label
        SNInputImage                   matlab.ui.control.Image
        SNResultsPanel                 matlab.ui.container.Panel
        NoiseDensityEditField          matlab.ui.control.NumericEditField
        NoiseDensityEditFieldLabel     matlab.ui.control.Label
        QContraharmonicEditField       matlab.ui.control.NumericEditField
        QContraharmonicEditFieldLabel  matlab.ui.control.Label
        WindowSizenxnEditField         matlab.ui.control.NumericEditField
        WindowSizenxnEditFieldLabel    matlab.ui.control.Label
        SNResultDesc                   matlab.ui.control.Label
        SNNoisedLabel                  matlab.ui.control.Label
        SNNoisedImage                  matlab.ui.control.Image
        SNMinLabel                     matlab.ui.control.Label
        SNMinImage                     matlab.ui.control.Image
        SNMaxLabel                     matlab.ui.control.Label
        SNMaxImage                     matlab.ui.control.Image
        SNMedianLabel                  matlab.ui.control.Label
        SNMedianImage                  matlab.ui.control.Image
        SNArithmeticLabel              matlab.ui.control.Label
        SNArithmeticImage              matlab.ui.control.Image
        SNGeometricLabel               matlab.ui.control.Label
        SNGeometricImage               matlab.ui.control.Image
        SNHarmonicLabel                matlab.ui.control.Label
        SNHarmonicImage                matlab.ui.control.Image
        SNContraharmonicLabel          matlab.ui.control.Label
        SNContraharmonicImage          matlab.ui.control.Image
        SNMidpointLabel                matlab.ui.control.Label
        SNMidpointImage                matlab.ui.control.Image
        SNAlphaTrimmedLabel            matlab.ui.control.Label
        SNAlphaTrimmedImage            matlab.ui.control.Image
        ConvolutionPanel               matlab.ui.container.Panel
        CRunButton                     matlab.ui.control.Button
        CInputLabel                    matlab.ui.control.Label
        CSelectFileButton              matlab.ui.control.Button
        CSelectedImage                 matlab.ui.control.Label
        CInputImageLabel               matlab.ui.control.Label
        CInputImage                    matlab.ui.control.Image
        CResultLabel                   matlab.ui.control.Label
        CResultImage                   matlab.ui.control.Image
        ImageSmoothingPanel            matlab.ui.container.Panel
        ISDomain                       matlab.ui.control.DropDown
        ProcessingDomainDropDownLabel  matlab.ui.control.Label
        ISRunButton                    matlab.ui.control.Button
        ISInputLabel                   matlab.ui.control.Label
        ISSelectFileButton             matlab.ui.control.Button
        ISSelectedImage                matlab.ui.control.Label
        ISInputImageLabel              matlab.ui.control.Label
        ISInputImage                   matlab.ui.control.Image
        ISFreqResultsPanel             matlab.ui.container.Panel
        ISD0EditField                  matlab.ui.control.NumericEditField
        D0FreqOnlyLabel                matlab.ui.control.Label
        ISnBLPFEditField               matlab.ui.control.NumericEditField
        nBLPFLabel                     matlab.ui.control.Label
        ISFreqResultDesc               matlab.ui.control.Label
        ISFreqILPFLabel                matlab.ui.control.Label
        ISFreqILPFImage                matlab.ui.control.Image
        ISFreqGLPFLabel                matlab.ui.control.Label
        ISFreqGLPFImage                matlab.ui.control.Image
        ISFreqBLPFLabel                matlab.ui.control.Label
        ISFreqBLPFImage                matlab.ui.control.Image
        ISSpatialResultsPanel          matlab.ui.container.Panel
        ISKernelSize                   matlab.ui.control.NumericEditField
        D0FreqOnlyLabel_3              matlab.ui.control.Label
        ISSigma                        matlab.ui.control.NumericEditField
        D0FreqOnlyLabel_2              matlab.ui.control.Label
        ISSpatResultDesc               matlab.ui.control.Label
        ISSpatResMeanLabel             matlab.ui.control.Label
        ISSpatResMeanImage             matlab.ui.control.Image
        ISSpatResGaussLabel            matlab.ui.control.Label
        ISSpatResGaussImage            matlab.ui.control.Image
        HighPassFilterPanel            matlab.ui.container.Panel
        HPRunButton                    matlab.ui.control.Button
        HPInputLabel                   matlab.ui.control.Label
        HPSelectFileButton             matlab.ui.control.Button
        HPSelectedImage                matlab.ui.control.Label
        HPInputImageLabel              matlab.ui.control.Label
        HPInputImage                   matlab.ui.control.Image
        HPFreqResultsPanel             matlab.ui.container.Panel
        HPD0EditField                  matlab.ui.control.NumericEditField
        D0FreqOnlyLabel_4              matlab.ui.control.Label
        HPnBHPFEditField               matlab.ui.control.NumericEditField
        nBLPFLabel_2                   matlab.ui.control.Label
        HPResultDesc                   matlab.ui.control.Label
        HPFreqIHPFLabel                matlab.ui.control.Label
        HPFreqIHPFImage                matlab.ui.control.Image
        HPFreqGHPFLabel                matlab.ui.control.Label
        HPFreqGHPFImage                matlab.ui.control.Image
        HPFreqBHPFLabel                matlab.ui.control.Label
        HPFreqBHPFImage                matlab.ui.control.Image
        Assignment                     matlab.ui.control.Label
        Louis                          matlab.ui.control.Label
        Addin                          matlab.ui.control.Label
    end

    methods (Access = private)
        function switchToMenu(app, menu)
            app.ConvolutionPanel.Visible = 'off';
            app.ImageSmoothingPanel.Visible = 'off';
            app.HighPassFilterPanel.Visible = 'off';

            switch menu
                case 'Convolution'
                    app.ConvolutionPanel.Visible = 'on';
                case 'Image Smoothing'
                    app.ImageSmoothingPanel.Visible = 'on';
                case 'High-pass Filter'
                    app.HighPassFilterPanel.Visible = 'on';
                case 'Spatial Noise Filter'
                    app.SpatialNoiseFilter.Visible = 'on';
            end
        end

        function switchISPanel(app, menu)
            app.ISSpatialResultsPanel.Visible = 'off';
            app.ISFreqResultsPanel.Visible = 'off';

            switch menu
                case 'Spatial'
                    app.ISSpatialResultsPanel.Visible = 'on';
                case 'Frequency'
                    app.ISFreqResultsPanel.Visible = 'on';
            end
        end

        function pickFile(~, selectedLabel, selectedImage)
            relativePath = fullfile('..', 'images');
            
            if ~isfolder(relativePath)
                relativePath = pwd;
            end
            
            [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg', 'Image Files (*.jpg, *.png, *.bmp, *.jpeg)'}, ...
                                    'Select an Image', relativePath);
            
            if isequal(file, 0)
                return;
            end
            
            selectedLabel.Text = file;
            selectedImage.ImageSource = fullfile(path, file);
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Menu selected function: ConvolutionMenu
        function ConvolutionMenuSelected(app, event)
            switchToMenu(app, 'Convolution');
        end

        % Menu selected function: ImageSmoothingMenu
        function ImageSmoothingMenuSelected(app, event)
            switchToMenu(app, 'Image Smoothing');
        end

        % Menu selected function: HighpassFilterMenu
        function HighpassFilterMenuSelected(app, event)
            switchToMenu(app, 'High-pass Filter');
        end

        % Value changed function: ISDomain
        function ISDomainValueChanged(app, event)
            value = app.ISDomain.Value;
            switchISPanel(app, value);
        end

        % Menu selected function: SpatialNoiseFilterMenu
        function SpatialNoiseFilterMenuSelected(app, event)
            switchToMenu(app, 'Spatial Noise Filter');
        end

        % Button pushed function: ISSelectFileButton
        function ISSelectFileButtonPushed(app, event)
            app.ISInputImage.ImageSource = '';
            app.ISSpatResMeanImage.ImageSource = '';
            app.ISSpatResGaussImage.ImageSource = '';
            app.ISFreqILPFImage.ImageSource = '';
            app.ISFreqGLPFImage.ImageSource = '';
            app.ISFreqBLPFImage.ImageSource = '';

            pickFile(app, app.ISSelectedImage, app.ISInputImage);
        end

        % Button pushed function: ISRunButton
        function ISRunButtonPushed(app, event)
            image = app.ISInputImage.ImageSource;
            if isempty(image)
                app.ISSpatResultDesc.Text = 'No image selected';
                return;
            end

            [image, map] = imread(image);

            switch app.ISDomain.Value
                case 'Spatial'
                    n = app.ISKernelSize.Value;
                    if (mod(n, 2) == 0)
                        error('Kernel size n must be an odd integer.');
                    end
                    sigma = app.ISSigma.Value;

                    resultMean = SpatialImageSmoothing.applyMeanFilter(image, n);
                    resultGauss = SpatialImageSmoothing.applyGaussianFilter(image, n, sigma);
                    app.ISSpatResMeanImage.ImageSource = resultMean;
                    app.ISSpatResGaussImage.ImageSource = resultGauss;
                case 'Frequency'
                    d0 = app.ISD0EditField.Value;
                    n = app.ISnBLPFEditField.Value;

                    resultILPF = FreqImageSmoothing.applyILPF(image, d0);
                    app.ISFreqILPFImage.ImageSource = resultILPF;
                    resultGLPF = FreqImageSmoothing.applyGLPF(image, d0);
                    app.ISFreqGLPFImage.ImageSource = resultGLPF;
                    resultBLPF = FreqImageSmoothing.applyBLPF(image, d0, n);
                    app.ISFreqBLPFImage.ImageSource = resultBLPF;
            end
        end

        % Button pushed function: CSelectFileButton
        function CSelectFileButtonPushed(app, event)
            app.CInputImage.ImageSource = '';
            app.CResultImage.ImageSource = '';

            pickFile(app, app.CSelectedImage, app.CInputImage);
        end

        % Button pushed function: HPSelectFileButton
        function HPSelectFileButtonPushed(app, event)
            app.HPInputImage.ImageSource = '';
            app.HPFreqIHPFImage.ImageSource = '';
            app.HPFreqGHPFImage.ImageSource = '';
            app.HPFreqBHPFImage.ImageSource = '';

            pickFile(app, app.HPSelectedImage, app.HPInputImage);
        end

        % Button pushed function: SNSelectFileButton
        function SNSelectFileButtonPushed(app, event)
            app.SNInputImage.ImageSource = '';
            app.SNNoisedImage.ImageSource = '';
            app.SNMinImage.ImageSource = '';
            app.SNMaxImage.ImageSource = '';
            app.SNMedianImage.ImageSource = '';
            app.SNArithmeticImage.ImageSource = '';
            app.SNGeometricImage.ImageSource = '';
            app.SNHarmonicImage.ImageSource = '';
            app.SNContraharmonicImage.ImageSource = '';
            app.SNMidpointImage.ImageSource = '';
            app.SNAlphaTrimmedImage.ImageSource = '';

            pickFile(app, app.SNSelectedImage, app.SNInputImage);
        end

        % Button pushed function: HPRunButton
        function HPRunButtonPushed(app, event)
            image = app.HPInputImage.ImageSource;
            if isempty(image)
                app.HPResultDesc.Text = 'No image selected';
                return;
            end

            [image, map] = imread(image);
            d0 = app.HPD0EditField.Value;
            n = app.HPnBHPFEditField.Value;

            resultIHPF = HighPassFilter.applyIHPF(image, d0);
            app.HPFreqIHPFImage.ImageSource = resultIHPF;
            resultGHPF = HighPassFilter.applyGHPF(image, d0);
            app.HPFreqGHPFImage.ImageSource = resultGHPF;
            resultBHPF = HighPassFilter.applyBHPF(image, d0, n);
            app.HPFreqBHPFImage.ImageSource = resultBHPF;
        end

        % Value changed function: SNNoise
        function SNNoiseValueChanged(app, event)
            value = app.SNNoise.Value;

            switch value
                case 'Salt & Pepper'
                    app.SNResultDesc.Text = 'Noise Filter on Image with Salt & Pepper Noise';
                case 'Gaussian'
                    app.SNResultDesc.Text = 'Noise Filter on Image with Gaussian Noise';
            end
        end

        % Button pushed function: SNRunButton
        function SNRunButtonPushed(app, event)
            image = app.SNInputImage.ImageSource;
            if isempty(image)
                app.SNResultDesc.Text = 'No image selected';
                return;
            end

            [image, map] = imread(image);
            noiseDensity = app.NoiseDensityEditField.Value;
            q = app.QContraharmonicEditField.Value;
            n = app.WindowSizenxnEditField.Value;

            switch app.SNNoise.Value
                case 'Salt & Pepper'
                    result = SpatialNoiseFilter.applySaltPepperFilter(image, noiseDensity, n);
                case 'Gaussian'
                    result = SpatialNoiseFilter.applyGaussianFilter(image, noiseDensity, n);
            end

            app.SNNoisedImage.ImageSource = result;
            app.SNMinImage.ImageSource = SpatialNoiseFilter.applyMinFilter(result, n);
            app.SNMaxImage.ImageSource = SpatialNoiseFilter.applyMaxFilter(result, n);
            app.SNMedianImage.ImageSource = SpatialNoiseFilter.applyMedianFilter(result, n);
            app.SNArithmeticImage.ImageSource = SpatialNoiseFilter.applyArithmeticMeanFilter(result, n);
            app.SNGeometricImage.ImageSource = SpatialNoiseFilter.applyGeometricMeanFilter(result, n);
            app.SNHarmonicImage.ImageSource = SpatialNoiseFilter.applyHarmonicMeanFilter(result, n);
            app.SNContraharmonicImage.ImageSource = SpatialNoiseFilter.applyContraharmonicMeanFilter(result, n, q);
            app.SNMidpointImage.ImageSource = SpatialNoiseFilter.applyMidpointFilter(result, n);
            app.SNAlphaTrimmedImage.ImageSource = SpatialNoiseFilter.applyAlphaTrimmedFilter(result, n);
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

            % Create ConvolutionMenu
            app.ConvolutionMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.ConvolutionMenu.MenuSelectedFcn = createCallbackFcn(app, @ConvolutionMenuSelected, true);
            app.ConvolutionMenu.Text = 'Convolution';

            % Create ImageSmoothingMenu
            app.ImageSmoothingMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.ImageSmoothingMenu.MenuSelectedFcn = createCallbackFcn(app, @ImageSmoothingMenuSelected, true);
            app.ImageSmoothingMenu.Text = 'Image Smoothing';

            % Create HighpassFilterMenu
            app.HighpassFilterMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.HighpassFilterMenu.MenuSelectedFcn = createCallbackFcn(app, @HighpassFilterMenuSelected, true);
            app.HighpassFilterMenu.Text = 'High-pass Filter';

            % Create SpatialNoiseFilterMenu
            app.SpatialNoiseFilterMenu = uimenu(app.Assignment_2_PCD_UIFigure);
            app.SpatialNoiseFilterMenu.MenuSelectedFcn = createCallbackFcn(app, @SpatialNoiseFilterMenuSelected, true);
            app.SpatialNoiseFilterMenu.Text = 'Spatial Noise Filter';

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

            % Create HighPassFilterPanel
            app.HighPassFilterPanel = uipanel(app.Assignment_2_PCD_UIFigure);
            app.HighPassFilterPanel.BorderType = 'none';
            app.HighPassFilterPanel.BorderWidth = 0;
            app.HighPassFilterPanel.Title = 'High-Pass Filter';
            app.HighPassFilterPanel.BackgroundColor = [1 1 1];
            app.HighPassFilterPanel.FontName = 'Gloucester MT Extra Condensed';
            app.HighPassFilterPanel.FontWeight = 'bold';
            app.HighPassFilterPanel.FontSize = 16;
            app.HighPassFilterPanel.Position = [43 210 1013 478];

            % Create HPFreqResultsPanel
            app.HPFreqResultsPanel = uipanel(app.HighPassFilterPanel);
            app.HPFreqResultsPanel.BorderWidth = 0;
            app.HPFreqResultsPanel.Title = 'Results';
            app.HPFreqResultsPanel.BackgroundColor = [1 1 1];
            app.HPFreqResultsPanel.FontWeight = 'bold';
            app.HPFreqResultsPanel.FontSize = 16;
            app.HPFreqResultsPanel.Position = [367 35 608 368];

            % Create HPFreqBHPFImage
            app.HPFreqBHPFImage = uiimage(app.HPFreqResultsPanel);
            app.HPFreqBHPFImage.Position = [413 98 173 173];

            % Create HPFreqBHPFLabel
            app.HPFreqBHPFLabel = uilabel(app.HPFreqResultsPanel);
            app.HPFreqBHPFLabel.FontSize = 14;
            app.HPFreqBHPFLabel.FontWeight = 'bold';
            app.HPFreqBHPFLabel.Position = [417 279 115 25];
            app.HPFreqBHPFLabel.Text = 'BHPF Filter';

            % Create HPFreqGHPFImage
            app.HPFreqGHPFImage = uiimage(app.HPFreqResultsPanel);
            app.HPFreqGHPFImage.Position = [210 99 173 173];

            % Create HPFreqGHPFLabel
            app.HPFreqGHPFLabel = uilabel(app.HPFreqResultsPanel);
            app.HPFreqGHPFLabel.FontSize = 14;
            app.HPFreqGHPFLabel.FontWeight = 'bold';
            app.HPFreqGHPFLabel.Position = [214 280 115 25];
            app.HPFreqGHPFLabel.Text = 'GHPF Filter';

            % Create HPFreqIHPFImage
            app.HPFreqIHPFImage = uiimage(app.HPFreqResultsPanel);
            app.HPFreqIHPFImage.Position = [1 98 173 173];

            % Create HPFreqIHPFLabel
            app.HPFreqIHPFLabel = uilabel(app.HPFreqResultsPanel);
            app.HPFreqIHPFLabel.FontSize = 14;
            app.HPFreqIHPFLabel.FontWeight = 'bold';
            app.HPFreqIHPFLabel.Position = [5 279 115 25];
            app.HPFreqIHPFLabel.Text = 'IHPF Filter';

            % Create HPResultDesc
            app.HPResultDesc = uilabel(app.HPFreqResultsPanel);
            app.HPResultDesc.Position = [5 318 260 22];
            app.HPResultDesc.Text = 'Image smoothing in frequency domain';

            % Create nBLPFLabel_2
            app.nBLPFLabel_2 = uilabel(app.HPFreqResultsPanel);
            app.nBLPFLabel_2.HorizontalAlignment = 'right';
            app.nBLPFLabel_2.Position = [3 27 55 22];
            app.nBLPFLabel_2.Text = 'n (BHPF)';

            % Create HPnBHPFEditField
            app.HPnBHPFEditField = uieditfield(app.HPFreqResultsPanel, 'numeric');
            app.HPnBHPFEditField.Limits = [1 Inf];
            app.HPnBHPFEditField.Placeholder = '2';
            app.HPnBHPFEditField.Position = [73 27 54 22];
            app.HPnBHPFEditField.Value = 2;

            % Create D0FreqOnlyLabel_4
            app.D0FreqOnlyLabel_4 = uilabel(app.HPFreqResultsPanel);
            app.D0FreqOnlyLabel_4.HorizontalAlignment = 'right';
            app.D0FreqOnlyLabel_4.Position = [5 56 50 22];
            app.D0FreqOnlyLabel_4.Text = 'D0';

            % Create HPD0EditField
            app.HPD0EditField = uieditfield(app.HPFreqResultsPanel, 'numeric');
            app.HPD0EditField.Limits = [1 Inf];
            app.HPD0EditField.Placeholder = '50';
            app.HPD0EditField.Position = [73 56 54 22];
            app.HPD0EditField.Value = 50;

            % Create HPInputImage
            app.HPInputImage = uiimage(app.HighPassFilterPanel);
            app.HPInputImage.Position = [5 89 237 237];

            % Create HPInputImageLabel
            app.HPInputImageLabel = uilabel(app.HighPassFilterPanel);
            app.HPInputImageLabel.FontSize = 14;
            app.HPInputImageLabel.FontWeight = 'bold';
            app.HPInputImageLabel.Position = [5 335 84 25];
            app.HPInputImageLabel.Text = 'Input Image';

            % Create HPSelectedImage
            app.HPSelectedImage = uilabel(app.HighPassFilterPanel);
            app.HPSelectedImage.FontAngle = 'italic';
            app.HPSelectedImage.Position = [109 374 104 22];
            app.HPSelectedImage.Text = 'No image selected';

            % Create HPSelectFileButton
            app.HPSelectFileButton = uibutton(app.HighPassFilterPanel, 'push');
            app.HPSelectFileButton.ButtonPushedFcn = createCallbackFcn(app, @HPSelectFileButtonPushed, true);
            app.HPSelectFileButton.Position = [1 373 100 23];
            app.HPSelectFileButton.Text = 'Select File';

            % Create HPInputLabel
            app.HPInputLabel = uilabel(app.HighPassFilterPanel);
            app.HPInputLabel.Position = [1 403 68 22];
            app.HPInputLabel.Text = 'Input Image';

            % Create HPRunButton
            app.HPRunButton = uibutton(app.HighPassFilterPanel, 'push');
            app.HPRunButton.ButtonPushedFcn = createCallbackFcn(app, @HPRunButtonPushed, true);
            app.HPRunButton.FontSize = 14;
            app.HPRunButton.Position = [6 39 235 32];
            app.HPRunButton.Text = 'Run';

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
            app.ImageSmoothingPanel.Position = [43 210 1013 478];

            % Create ISSpatialResultsPanel
            app.ISSpatialResultsPanel = uipanel(app.ImageSmoothingPanel);
            app.ISSpatialResultsPanel.BorderWidth = 0;
            app.ISSpatialResultsPanel.Title = 'Results';
            app.ISSpatialResultsPanel.BackgroundColor = [1 1 1];
            app.ISSpatialResultsPanel.FontWeight = 'bold';
            app.ISSpatialResultsPanel.FontSize = 16;
            app.ISSpatialResultsPanel.Position = [367 36 608 368];

            % Create ISSpatResGaussImage
            app.ISSpatResGaussImage = uiimage(app.ISSpatialResultsPanel);
            app.ISSpatResGaussImage.Position = [215 98 171 173];

            % Create ISSpatResGaussLabel
            app.ISSpatResGaussLabel = uilabel(app.ISSpatialResultsPanel);
            app.ISSpatResGaussLabel.FontSize = 14;
            app.ISSpatResGaussLabel.FontWeight = 'bold';
            app.ISSpatResGaussLabel.Position = [219 279 115 25];
            app.ISSpatResGaussLabel.Text = 'Gaussian Filter';

            % Create ISSpatResMeanImage
            app.ISSpatResMeanImage = uiimage(app.ISSpatialResultsPanel);
            app.ISSpatResMeanImage.Position = [1 98 173 173];

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

            % Create D0FreqOnlyLabel_2
            app.D0FreqOnlyLabel_2 = uilabel(app.ISSpatialResultsPanel);
            app.D0FreqOnlyLabel_2.HorizontalAlignment = 'right';
            app.D0FreqOnlyLabel_2.Position = [242 54 39 22];
            app.D0FreqOnlyLabel_2.Text = 'Sigma';

            % Create ISSigma
            app.ISSigma = uieditfield(app.ISSpatialResultsPanel, 'numeric');
            app.ISSigma.Limits = [1 Inf];
            app.ISSigma.Placeholder = '50';
            app.ISSigma.Position = [299 54 54 22];
            app.ISSigma.Value = 1;

            % Create D0FreqOnlyLabel_3
            app.D0FreqOnlyLabel_3 = uilabel(app.ISSpatialResultsPanel);
            app.D0FreqOnlyLabel_3.HorizontalAlignment = 'right';
            app.D0FreqOnlyLabel_3.Position = [1 54 66 22];
            app.D0FreqOnlyLabel_3.Text = 'Kernel Size';

            % Create ISKernelSize
            app.ISKernelSize = uieditfield(app.ISSpatialResultsPanel, 'numeric');
            app.ISKernelSize.Limits = [1 Inf];
            app.ISKernelSize.Placeholder = '50';
            app.ISKernelSize.Position = [85 54 54 22];
            app.ISKernelSize.Value = 3;

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

            % Create nBLPFLabel
            app.nBLPFLabel = uilabel(app.ISFreqResultsPanel);
            app.nBLPFLabel.HorizontalAlignment = 'right';
            app.nBLPFLabel.Position = [8 15 53 22];
            app.nBLPFLabel.Text = 'n (BLPF)';

            % Create ISnBLPFEditField
            app.ISnBLPFEditField = uieditfield(app.ISFreqResultsPanel, 'numeric');
            app.ISnBLPFEditField.Limits = [1 Inf];
            app.ISnBLPFEditField.Placeholder = '2';
            app.ISnBLPFEditField.Position = [76 15 54 22];
            app.ISnBLPFEditField.Value = 2;

            % Create D0FreqOnlyLabel
            app.D0FreqOnlyLabel = uilabel(app.ISFreqResultsPanel);
            app.D0FreqOnlyLabel.HorizontalAlignment = 'right';
            app.D0FreqOnlyLabel.Position = [8 44 50 22];
            app.D0FreqOnlyLabel.Text = 'D0';

            % Create ISD0EditField
            app.ISD0EditField = uieditfield(app.ISFreqResultsPanel, 'numeric');
            app.ISD0EditField.Limits = [1 Inf];
            app.ISD0EditField.Placeholder = '50';
            app.ISD0EditField.Position = [76 44 54 22];
            app.ISD0EditField.Value = 50;

            % Create ISInputImage
            app.ISInputImage = uiimage(app.ImageSmoothingPanel);
            app.ISInputImage.Position = [6 143 162 162];

            % Create ISInputImageLabel
            app.ISInputImageLabel = uilabel(app.ImageSmoothingPanel);
            app.ISInputImageLabel.FontSize = 14;
            app.ISInputImageLabel.FontWeight = 'bold';
            app.ISInputImageLabel.Position = [6 313 84 25];
            app.ISInputImageLabel.Text = 'Input Image';

            % Create ISSelectedImage
            app.ISSelectedImage = uilabel(app.ImageSmoothingPanel);
            app.ISSelectedImage.FontAngle = 'italic';
            app.ISSelectedImage.Position = [110 352 104 22];
            app.ISSelectedImage.Text = 'No image selected';

            % Create ISSelectFileButton
            app.ISSelectFileButton = uibutton(app.ImageSmoothingPanel, 'push');
            app.ISSelectFileButton.ButtonPushedFcn = createCallbackFcn(app, @ISSelectFileButtonPushed, true);
            app.ISSelectFileButton.Position = [2 351 100 23];
            app.ISSelectFileButton.Text = 'Select File';

            % Create ISInputLabel
            app.ISInputLabel = uilabel(app.ImageSmoothingPanel);
            app.ISInputLabel.Position = [2 380 68 22];
            app.ISInputLabel.Text = 'Input Image';

            % Create ISRunButton
            app.ISRunButton = uibutton(app.ImageSmoothingPanel, 'push');
            app.ISRunButton.ButtonPushedFcn = createCallbackFcn(app, @ISRunButtonPushed, true);
            app.ISRunButton.FontSize = 14;
            app.ISRunButton.Position = [6 77 235 32];
            app.ISRunButton.Text = 'Run';

            % Create ProcessingDomainDropDownLabel
            app.ProcessingDomainDropDownLabel = uilabel(app.ImageSmoothingPanel);
            app.ProcessingDomainDropDownLabel.HorizontalAlignment = 'right';
            app.ProcessingDomainDropDownLabel.Position = [-4 409 109 22];
            app.ProcessingDomainDropDownLabel.Text = 'Processing Domain';

            % Create ISDomain
            app.ISDomain = uidropdown(app.ImageSmoothingPanel);
            app.ISDomain.Items = {'Spatial', 'Frequency'};
            app.ISDomain.ValueChangedFcn = createCallbackFcn(app, @ISDomainValueChanged, true);
            app.ISDomain.Position = [120 409 100 22];
            app.ISDomain.Value = 'Spatial';

            % Create ConvolutionPanel
            app.ConvolutionPanel = uipanel(app.Assignment_2_PCD_UIFigure);
            app.ConvolutionPanel.BorderType = 'none';
            app.ConvolutionPanel.BorderWidth = 0;
            app.ConvolutionPanel.Title = 'Convolution';
            app.ConvolutionPanel.BackgroundColor = [1 1 1];
            app.ConvolutionPanel.FontName = 'Gloucester MT Extra Condensed';
            app.ConvolutionPanel.FontWeight = 'bold';
            app.ConvolutionPanel.FontSize = 16;
            app.ConvolutionPanel.Position = [43 210 1013 478];

            % Create CResultImage
            app.CResultImage = uiimage(app.ConvolutionPanel);
            app.CResultImage.Position = [363 49 346 346];

            % Create CResultLabel
            app.CResultLabel = uilabel(app.ConvolutionPanel);
            app.CResultLabel.FontSize = 14;
            app.CResultLabel.FontWeight = 'bold';
            app.CResultLabel.Position = [363 409 133 25];
            app.CResultLabel.Text = 'Convolution Result';

            % Create CInputImage
            app.CInputImage = uiimage(app.ConvolutionPanel);
            app.CInputImage.Position = [6 106 237 237];

            % Create CInputImageLabel
            app.CInputImageLabel = uilabel(app.ConvolutionPanel);
            app.CInputImageLabel.FontSize = 14;
            app.CInputImageLabel.FontWeight = 'bold';
            app.CInputImageLabel.Position = [5 352 84 25];
            app.CInputImageLabel.Text = 'Input Image';

            % Create CSelectedImage
            app.CSelectedImage = uilabel(app.ConvolutionPanel);
            app.CSelectedImage.FontAngle = 'italic';
            app.CSelectedImage.Position = [109 391 104 22];
            app.CSelectedImage.Text = 'No image selected';

            % Create CSelectFileButton
            app.CSelectFileButton = uibutton(app.ConvolutionPanel, 'push');
            app.CSelectFileButton.ButtonPushedFcn = createCallbackFcn(app, @CSelectFileButtonPushed, true);
            app.CSelectFileButton.Position = [1 390 100 23];
            app.CSelectFileButton.Text = 'Select File';

            % Create CInputLabel
            app.CInputLabel = uilabel(app.ConvolutionPanel);
            app.CInputLabel.Position = [1 419 68 22];
            app.CInputLabel.Text = 'Input Image';

            % Create CRunButton
            app.CRunButton = uibutton(app.ConvolutionPanel, 'push');
            app.CRunButton.FontSize = 14;
            app.CRunButton.Position = [6 56 235 32];
            app.CRunButton.Text = 'Run';

            % Create SpatialNoiseFilter
            app.SpatialNoiseFilter = uipanel(app.Assignment_2_PCD_UIFigure);
            app.SpatialNoiseFilter.BorderColor = [1 1 1];
            app.SpatialNoiseFilter.HighlightColor = [1 1 1];
            app.SpatialNoiseFilter.BorderType = 'none';
            app.SpatialNoiseFilter.BorderWidth = 0;
            app.SpatialNoiseFilter.Title = 'Spatial Noise Filter';
            app.SpatialNoiseFilter.BackgroundColor = [1 1 1];
            app.SpatialNoiseFilter.FontWeight = 'bold';
            app.SpatialNoiseFilter.FontSize = 16;
            app.SpatialNoiseFilter.Position = [43 210 1013 478];

            % Create SNResultsPanel
            app.SNResultsPanel = uipanel(app.SpatialNoiseFilter);
            app.SNResultsPanel.BorderColor = [1 1 1];
            app.SNResultsPanel.HighlightColor = [1 1 1];
            app.SNResultsPanel.BorderType = 'none';
            app.SNResultsPanel.BorderWidth = 0;
            app.SNResultsPanel.Title = 'Results';
            app.SNResultsPanel.BackgroundColor = [1 1 1];
            app.SNResultsPanel.FontWeight = 'bold';
            app.SNResultsPanel.FontSize = 16;
            app.SNResultsPanel.Position = [341 7 660 460];

            % Create SNAlphaTrimmedImage
            app.SNAlphaTrimmedImage = uiimage(app.SNResultsPanel);
            app.SNAlphaTrimmedImage.Position = [540 78 112 112];

            % Create SNAlphaTrimmedLabel
            app.SNAlphaTrimmedLabel = uilabel(app.SNResultsPanel);
            app.SNAlphaTrimmedLabel.FontWeight = 'bold';
            app.SNAlphaTrimmedLabel.Position = [544 198 109 25];
            app.SNAlphaTrimmedLabel.Text = 'Alpha Trimmed';

            % Create SNMidpointImage
            app.SNMidpointImage = uiimage(app.SNResultsPanel);
            app.SNMidpointImage.Position = [406 78 112 112];

            % Create SNMidpointLabel
            app.SNMidpointLabel = uilabel(app.SNResultsPanel);
            app.SNMidpointLabel.FontWeight = 'bold';
            app.SNMidpointLabel.Position = [410 198 108 25];
            app.SNMidpointLabel.Text = 'Midpoint';

            % Create SNContraharmonicImage
            app.SNContraharmonicImage = uiimage(app.SNResultsPanel);
            app.SNContraharmonicImage.Position = [272 78 112 112];

            % Create SNContraharmonicLabel
            app.SNContraharmonicLabel = uilabel(app.SNResultsPanel);
            app.SNContraharmonicLabel.FontWeight = 'bold';
            app.SNContraharmonicLabel.Position = [276 198 109 25];
            app.SNContraharmonicLabel.Text = 'Contraharmonic';

            % Create SNHarmonicImage
            app.SNHarmonicImage = uiimage(app.SNResultsPanel);
            app.SNHarmonicImage.Position = [137 78 112 112];

            % Create SNHarmonicLabel
            app.SNHarmonicLabel = uilabel(app.SNResultsPanel);
            app.SNHarmonicLabel.FontWeight = 'bold';
            app.SNHarmonicLabel.Position = [141 198 108 25];
            app.SNHarmonicLabel.Text = 'Harmonic Mean';

            % Create SNGeometricImage
            app.SNGeometricImage = uiimage(app.SNResultsPanel);
            app.SNGeometricImage.Position = [2 78 112 112];

            % Create SNGeometricLabel
            app.SNGeometricLabel = uilabel(app.SNResultsPanel);
            app.SNGeometricLabel.FontWeight = 'bold';
            app.SNGeometricLabel.Position = [6 198 108 25];
            app.SNGeometricLabel.Text = 'Geometric mean';

            % Create SNArithmeticImage
            app.SNArithmeticImage = uiimage(app.SNResultsPanel);
            app.SNArithmeticImage.Position = [539 248 112 112];

            % Create SNArithmeticLabel
            app.SNArithmeticLabel = uilabel(app.SNResultsPanel);
            app.SNArithmeticLabel.FontWeight = 'bold';
            app.SNArithmeticLabel.Position = [543 368 131 25];
            app.SNArithmeticLabel.Text = 'Arithmetic Mean';

            % Create SNMedianImage
            app.SNMedianImage = uiimage(app.SNResultsPanel);
            app.SNMedianImage.Position = [405 248 112 112];

            % Create SNMedianLabel
            app.SNMedianLabel = uilabel(app.SNResultsPanel);
            app.SNMedianLabel.FontWeight = 'bold';
            app.SNMedianLabel.Position = [409 368 108 25];
            app.SNMedianLabel.Text = 'Median Filter';

            % Create SNMaxImage
            app.SNMaxImage = uiimage(app.SNResultsPanel);
            app.SNMaxImage.Position = [271 248 112 112];

            % Create SNMaxLabel
            app.SNMaxLabel = uilabel(app.SNResultsPanel);
            app.SNMaxLabel.FontWeight = 'bold';
            app.SNMaxLabel.Position = [275 368 109 25];
            app.SNMaxLabel.Text = 'Max Filter';

            % Create SNMinImage
            app.SNMinImage = uiimage(app.SNResultsPanel);
            app.SNMinImage.Position = [136 248 112 112];

            % Create SNMinLabel
            app.SNMinLabel = uilabel(app.SNResultsPanel);
            app.SNMinLabel.FontWeight = 'bold';
            app.SNMinLabel.Position = [140 368 108 25];
            app.SNMinLabel.Text = 'Min Filter';

            % Create SNNoisedImage
            app.SNNoisedImage = uiimage(app.SNResultsPanel);
            app.SNNoisedImage.Position = [1 248 112 112];

            % Create SNNoisedLabel
            app.SNNoisedLabel = uilabel(app.SNResultsPanel);
            app.SNNoisedLabel.FontWeight = 'bold';
            app.SNNoisedLabel.Position = [5 368 119 25];
            app.SNNoisedLabel.Text = 'Image with Noise';

            % Create SNResultDesc
            app.SNResultDesc = uilabel(app.SNResultsPanel);
            app.SNResultDesc.Position = [5 407 260 22];
            app.SNResultDesc.Text = 'Noise Filter with Salt & Pepper';

            % Create WindowSizenxnEditFieldLabel
            app.WindowSizenxnEditFieldLabel = uilabel(app.SNResultsPanel);
            app.WindowSizenxnEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowSizenxnEditFieldLabel.Position = [401 41 112 22];
            app.WindowSizenxnEditFieldLabel.Text = 'Window Size (n x n)';

            % Create WindowSizenxnEditField
            app.WindowSizenxnEditField = uieditfield(app.SNResultsPanel, 'numeric');
            app.WindowSizenxnEditField.Position = [528 41 100 22];

            % Create QContraharmonicEditFieldLabel
            app.QContraharmonicEditFieldLabel = uilabel(app.SNResultsPanel);
            app.QContraharmonicEditFieldLabel.HorizontalAlignment = 'right';
            app.QContraharmonicEditFieldLabel.Position = [399 10 114 22];
            app.QContraharmonicEditFieldLabel.Text = ' Q (Contraharmonic)';

            % Create QContraharmonicEditField
            app.QContraharmonicEditField = uieditfield(app.SNResultsPanel, 'numeric');
            app.QContraharmonicEditField.Position = [528 10 100 22];

            % Create NoiseDensityEditFieldLabel
            app.NoiseDensityEditFieldLabel = uilabel(app.SNResultsPanel);
            app.NoiseDensityEditFieldLabel.HorizontalAlignment = 'right';
            app.NoiseDensityEditFieldLabel.Position = [1 38 79 22];
            app.NoiseDensityEditFieldLabel.Text = 'Noise Density';

            % Create NoiseDensityEditField
            app.NoiseDensityEditField = uieditfield(app.SNResultsPanel, 'numeric');
            app.NoiseDensityEditField.Position = [95 38 100 22];

            % Create SNInputImage
            app.SNInputImage = uiimage(app.SpatialNoiseFilter);
            app.SNInputImage.Position = [5 68 237 237];

            % Create SNInputImageLabel
            app.SNInputImageLabel = uilabel(app.SpatialNoiseFilter);
            app.SNInputImageLabel.FontSize = 14;
            app.SNInputImageLabel.FontWeight = 'bold';
            app.SNInputImageLabel.Position = [5 313 219 25];
            app.SNInputImageLabel.Text = 'Input Image';

            % Create SNSelectedImage
            app.SNSelectedImage = uilabel(app.SpatialNoiseFilter);
            app.SNSelectedImage.FontAngle = 'italic';
            app.SNSelectedImage.Position = [109 352 104 22];
            app.SNSelectedImage.Text = 'No image selected';

            % Create SNSelectFileButton
            app.SNSelectFileButton = uibutton(app.SpatialNoiseFilter, 'push');
            app.SNSelectFileButton.ButtonPushedFcn = createCallbackFcn(app, @SNSelectFileButtonPushed, true);
            app.SNSelectFileButton.Position = [1 351 100 23];
            app.SNSelectFileButton.Text = 'Select File';

            % Create SNInputLabel
            app.SNInputLabel = uilabel(app.SpatialNoiseFilter);
            app.SNInputLabel.Position = [1 380 68 22];
            app.SNInputLabel.Text = 'Input Image';

            % Create SNRunButton
            app.SNRunButton = uibutton(app.SpatialNoiseFilter, 'push');
            app.SNRunButton.ButtonPushedFcn = createCallbackFcn(app, @SNRunButtonPushed, true);
            app.SNRunButton.FontSize = 14;
            app.SNRunButton.Position = [6 14 235 32];
            app.SNRunButton.Text = 'Run';

            % Create NoiseLabel
            app.NoiseLabel = uilabel(app.SpatialNoiseFilter);
            app.NoiseLabel.HorizontalAlignment = 'right';
            app.NoiseLabel.Position = [-4 406 36 22];
            app.NoiseLabel.Text = 'Noise';

            % Create SNNoise
            app.SNNoise = uidropdown(app.SpatialNoiseFilter);
            app.SNNoise.Items = {'Salt & Pepper', 'Gaussian'};
            app.SNNoise.ValueChangedFcn = createCallbackFcn(app, @SNNoiseValueChanged, true);
            app.SNNoise.Position = [47 406 134 22];
            app.SNNoise.Value = 'Salt & Pepper';

            % Create Line_1
            app.Line_1 = uiimage(app.Assignment_2_PCD_UIFigure);
            app.Line_1.Position = [1 175 1080 10];
            app.Line_1.ImageSource = fullfile(pathToMLAPP, 'assets', 'LineHor.png');

            % Create Line_2
            app.Line_2 = uiimage(app.Assignment_2_PCD_UIFigure);
            app.Line_2.Position = [334 179 13 542];
            app.Line_2.ImageSource = fullfile(pathToMLAPP, 'assets', 'LineVert.png');

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