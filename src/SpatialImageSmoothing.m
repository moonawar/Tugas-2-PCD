classdef SpatialImageSmoothing
    methods(Static)
        function meanKernel = createMeanKernel(n)
            % Mean kernel adalah kernel yang semua elemennya bernilai 1/n^2
            meanKernel = ones(n) / n^2;
        end

        function gaussianKernel = createGaussianKernel(n, sigma)
            % Bentuk meshgrid dari -floor(n/2) sampai floor(n/2)
            [X, Y] = meshgrid(-floor(n/2):floor(n/2), -floor(n/2):floor(n/2));

            % Hitung kernel gaussian berdasarkan posisi X dan Y pada meshgrid, dengan sigma sebagai parameter
            gaussianKernel = exp(-(X.^2 + Y.^2) / (2 * sigma^2));

            % Normalisasi kernel
            gaussianKernel = gaussianKernel / sum(gaussianKernel(:));
        end

        function result = applyMeanFilter(image, n)
            if size(image, 3) == 3 % Handle citra RGB
                redChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 1), n);
                greenChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 2), n);
                blueChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 3), n);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else % Handle citra grayscale
                result = SpatialImageSmoothing.applyMeanFilterSingleChannel(image, n);
                result = cat(3, result, result, result);
            end
        end

        function result = applyMeanFilterSingleChannel(image, n)
            % Bangkitkan kernel untuk mean filter
            kernel = SpatialImageSmoothing.createMeanKernel(n);

            % Aplikasikan filter ke citra (konvolusi)
            result = ImageConv.customConvolve(image, kernel);
        end

        function result = applyGaussianFilter(image, n, sigma)
            if size(image, 3) == 3 % Handle citra RGB
                redChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 1), n, sigma);
                greenChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 2), n, sigma);
                blueChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 3), n, sigma);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else % Handle citra grayscale
                result = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image, n, sigma);
                result = cat(3, result, result, result);
            end
        end

        function result = applyGaussianFilterSingleChannel(image, n, sigma)
            % Bangkitkan kernel untuk gaussian filter
            kernel = SpatialImageSmoothing.createGaussianKernel(n, sigma);

            % Aplikasikan filter ke citra (konvolusi)
            result = ImageConv.customConvolve(image, kernel);
        end
    end
end