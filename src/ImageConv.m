classdef ImageConv
    methods (Static)
        function convolvedImage = customConvolve(image, kernel)
            % Konvolusi citra yang diimplementasi sendiri
            if size(image, 3) == 3  % Mengecek apakah citra merupakan citra grayscale atau berwarna
                convolvedImage = zeros(size(image), 'like', image);
                for channel = 1:3
                    convolvedImage(:, :, channel) = imfilter(image(:, :, channel), kernel, 'same', 'replicate');
                end
            else
                convolvedImage = imfilter(image, kernel, 'same', 'replicate');
            end
        end

        function convolvedImageBuiltin = builtInConvolve(image, kernel)
            % Konvolusi citra menggunakan built-in library matlab
            if size(image, 3) == 3  % Mengecek apakah citra merupakan citra grayscale atau berwarna
                convolvedImageBuiltin = zeros(size(image), 'like', image);
                for channel = 1:3
                    convolvedImageBuiltin(:, :, channel) = conv2(double(image(:, :, channel)), double(kernel), 'same');
                end
            else
                convolvedImageBuiltin = conv2(double(image), double(kernel), 'same');
            end
        end

        function processAndDisplay(image, mask, maskTitle)
            convolvedImageCustom = ImageConv.customConvolve(image, mask);
            convolvedImageBuiltin = ImageConv.builtInConvolve(image, mask);
            
            % Menampilkan citra beserta histogram
            ImageConv.displayResults(image, convolvedImageCustom, convolvedImageBuiltin, maskTitle);
        end

        function displayResults(image, convolvedImageCustom, convolvedImageBuiltin, titleStr)
            figure('Position', [100, 100, 1500, 600]);
            sgtitle(titleStr);

            % Citra input
            subplot(2, 3, 1);
            imshow(image);
            title('Citra input');

            % Citra konvolusi yang diimplementasi sendiri
            subplot(2, 3, 2);
            imshow(uint8(convolvedImageCustom));
            title('Citra hasil konvolusi');

            % Citra konvolusi menggunakan built-in library
            subplot(2, 3, 3);
            imshow(uint8(convolvedImageBuiltin));
            title('Citra hasil konvolusi (built-in)');

            % Histogram citra input
            subplot(2, 3, 4);
            if size(image, 3) == 3  % Citra berwarna
                hold on;
                histogram(image(:, :, 1), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.4);
                histogram(image(:, :, 2), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.4);
                histogram(image(:, :, 3), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.4);
                hold off;
                title('Histogram citra input');
                xlabel('Intensity');
                ylabel('Frequency');
            else
                imhist(image);
                title('Histogram citra input');
            end

            % Histogram citra terkonvolusi (implementasi sendiri)
            subplot(2, 3, 5);
            if size(convolvedImageCustom, 3) == 3  % Citra berwarna
                hold on;
                histogram(convolvedImageCustom(:, :, 1), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.4);
                histogram(convolvedImageCustom(:, :, 2), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.4);
                histogram(convolvedImageCustom(:, :, 3), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.4);
                hold off;
                title('Histogram konvolusi');
                xlabel('Intensity');
                ylabel('Frequency');
            else
                imhist(convolvedImageCustom);
                title('Histogram konvolusi');
            end

            % Histogram citra terkonvolusi (built-in library)
            subplot(2, 3, 6);
            if size(convolvedImageBuiltin, 3) == 3  % Citra berwarna
                hold on;
                histogram(convolvedImageBuiltin(:, :, 1), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.4);
                histogram(convolvedImageBuiltin(:, :, 2), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.4);
                histogram(convolvedImageBuiltin(:, :, 3), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.4);
                hold off;
                title('Histogram konvolusi (built-in)');
                xlabel('Intensity');
                ylabel('Frequency');
            else
                imhist(convolvedImageBuiltin);
                title('Histogram konvolusi (built-in)');
            end
        end
    end
end