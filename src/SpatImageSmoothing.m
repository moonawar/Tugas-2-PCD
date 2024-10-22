classdef SpatImageSmoothing
    methods(Static)
        function result = applyMeanFilter(image, filterSize)
            % Apply mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = imboxfilt(image, filterSize);
        end

        function result = applyGaussianFilter(image, sigma)
            % Apply Gaussian filter to the image
            % image: input image
            % sigma: standard deviation of the Gaussian filter
            % result: smoothed image
            result = imgaussfilt(image, sigma);
        end
    end
end