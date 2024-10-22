classdef SpatialNoiseFilter
    methods(Static)
        function result = applySaltPepperNoise(image, p)
            % Apply salt-and-pepper noise to the image
            % image: input image
            % p: noise density
            % result: image with salt-and-pepper noise
            [M, N] = size(image);
            result = image;
            for i = 1:M
                for j = 1:N
                    r = rand;
                    if r < p / 2
                        result(i, j) = 0;
                    elseif r < p
                        result(i, j) = 255;
                    end
                end
            end
        end

        function result = applyMinFilter(image, filterSize)
            % Apply min filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = ordfilt2(image, 1, ones(filterSize));
        end

        function result = applyMaxFilter(image, filterSize)
            % Apply max filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = ordfilt2(image, filterSize^2, ones(filterSize));
        end

        function result = applyMedianFilter(image, filterSize)
            % Apply median filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = medfilt2(image, [filterSize filterSize]);
        end

        function result = applyArithmeticMeanFilter(image, filterSize)
            % Apply arithmetic mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = imfilter(image, ones(filterSize) / filterSize^2);
        end

        function result = applyGeometricMeanFilter(image, filterSize)
            % Apply geometric mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = exp(imfilter(log(image + 1), ones(filterSize) / filterSize^2)) - 1;
        end

        function result = applyHarmonicMeanFilter(image, filterSize)
            % Apply harmonic mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            result = filter2(1 ./ (image + 1), ones(filterSize) / filterSize^2);
            result = 1 ./ result;
        end

        function result = applyContraharmonicMeanFilter(image, filterSize, Q)
            % Apply contraharmonic mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % Q: order of the filter
            % result: smoothed image
            result = filter2(image.^(Q + 1), ones(filterSize) / filterSize^2);
            result = result ./ filter2(image.^Q, ones(filterSize) / filterSize^2);
        end

        function result = applyMidpointFilter(image, filterSize)
            % Apply midpoint filter to the image
            % image: input image
            % filterSize: size of the filter
            % result: smoothed image
            minImage = SpatialNoiseFilter.applyMinFilter(image, filterSize);
            maxImage = SpatialNoiseFilter.applyMaxFilter(image, filterSize);
            result = (double(minImage) + double(maxImage)) / 2;
        end

        function result = applyAlphaTrimmedMeanFilter(image, filterSize, d)
            % Apply alpha-trimmed mean filter to the image
            % image: input image
            % filterSize: size of the filter
            % d: number of pixels to be trimmed
            % result: smoothed image
            result = ordfilt2(image, d + 1, ones(filterSize));
            result = ordfilt2(result, filterSize^2 - d, ones(filterSize));
        end
    end
end