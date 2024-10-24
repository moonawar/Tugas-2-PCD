classdef SpatialImageSmoothing
    methods(Static)
        function meanKernel = createMeanKernel(n)
            meanKernel = ones(n) / n^2;
        end

        function gaussianKernel = createGaussianKernel(n, sigma)
            [X, Y] = meshgrid(-floor(n/2):floor(n/2), -floor(n/2):floor(n/2));
            gaussianKernel = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
            gaussianKernel = gaussianKernel / sum(gaussianKernel(:));
        end

        function result = applyMeanFilter(image, n)
            if size(image, 3) == 3
                redChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 1), n);
                greenChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 2), n);
                blueChannel = SpatialImageSmoothing.applyMeanFilterSingleChannel(image(:, :, 3), n);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialImageSmoothing.applyMeanFilterSingleChannel(image, n);
                result = cat(3, result, result, result);
            end
        end

        function result = applyMeanFilterSingleChannel(image, n)
            kernel = SpatialImageSmoothing.createMeanKernel(n);
            result = imfilter(image, kernel, 'same', 'replicate');
        end

        function result = applyGaussianFilter(image, n, sigma)
            if size(image, 3) == 3
                redChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 1), n, sigma);
                greenChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 2), n, sigma);
                blueChannel = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image(:, :, 3), n, sigma);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialImageSmoothing.applyGaussianFilterSingleChannel(image, n, sigma);
                result = cat(3, result, result, result);
            end
        end

        function result = applyGaussianFilterSingleChannel(image, n, sigma)
            kernel = SpatialImageSmoothing.createGaussianKernel(n, sigma);
            result = imfilter(image, kernel, 'same', 'replicate');
        end
    end
end