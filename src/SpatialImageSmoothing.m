classdef SpatialImageSmoothing
    methods(Static)
        function result = applyMeanFilter(image)
            % Apply mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            filterSize = 3;
            result = imboxfilt(image, filterSize);
        end

        function result = applyGaussianFilter(image)
            % Apply Gaussian filter to the image
            % image: input image
            % sigma: standard deviation of the Gaussian filter
            % result: smoothed image
            sigma = 1;
            result = imgaussfilt(image, sigma);
        end
    end
end