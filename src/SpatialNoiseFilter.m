classdef SpatialNoiseFilter
    methods(Static)
        function result = applySaltPepperNoise(image, density)
            result = imnoise(image, 'salt & pepper', density);
        end

        function result = applyGaussianNoise(image, mean, variance)
            result = imnoise(image, 'gaussian', mean, variance);
        end

        % IMAGE INPUT PREPROCESSING (Handling RGB dan Grayscale)
        function result = applyMinFilter(image, window_size)
            if size(image, 3) == 3 
                redChannel = SpatialNoiseFilter.applyMinFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyMinFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyMinFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyMinFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyMaxFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyMaxFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyMaxFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyMaxFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyMaxFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyMedianFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyMedianFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyMedianFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyMedianFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyMedianFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyArithmeticMeanFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyArithmeticMeanFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyArithmeticMeanFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyArithmeticMeanFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyArithmeticMeanFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyGeometricMeanFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyGeometricMeanFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyGeometricMeanFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyGeometricMeanFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyGeometricMeanFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyHarmonicMeanFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyHarmonicMeanFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyHarmonicMeanFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyHarmonicMeanFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyHarmonicMeanFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyContraharmonicMeanFilter(image, window_size, Q)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyContraharmonicMeanFilterSingleCh(image(:, :, 1), window_size, Q);
                greenChannel = SpatialNoiseFilter.applyContraharmonicMeanFilterSingleCh(image(:, :, 2), window_size, Q);
                blueChannel = SpatialNoiseFilter.applyContraharmonicMeanFilterSingleCh(image(:, :, 3), window_size, Q);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyContraharmonicMeanFilterSingleCh(image, window_size, Q);
                result = cat(3, result, result, result);
            end
        end

        function result = applyMidpointFilter(image, window_size)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyMidpointFilterSingleCh(image(:, :, 1), window_size);
                greenChannel = SpatialNoiseFilter.applyMidpointFilterSingleCh(image(:, :, 2), window_size);
                blueChannel = SpatialNoiseFilter.applyMidpointFilterSingleCh(image(:, :, 3), window_size);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyMidpointFilterSingleCh(image, window_size);
                result = cat(3, result, result, result);
            end
        end

        function result = applyAlphaTrimmedFilter(image, window_size, d)
            if size(image, 3) == 3
                redChannel = SpatialNoiseFilter.applyAlphaTrimmedFilterSingleCh(image(:, :, 1), window_size, d);
                greenChannel = SpatialNoiseFilter.applyAlphaTrimmedFilterSingleCh(image(:, :, 2), window_size, d);
                blueChannel = SpatialNoiseFilter.applyAlphaTrimmedFilterSingleCh(image(:, :, 3), window_size, d);

                result = cat(3, redChannel, greenChannel, blueChannel);
            else
                result = SpatialNoiseFilter.applyAlphaTrimmedFilterSingleCh(image, window_size, d);
                result = cat(3, result, result, result);
            end
        end

        % IMAGE INPUT PROCESSING IMPLEMENTATION
        function result = applyMinFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);

            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai minimum dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = min(local_neighbourhood(:));
                end
            end

            result = uint8(result);
        end

        function result = applyMaxFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);

            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai maksimum dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = max(local_neighbourhood(:));
                end
            end

            result = uint8(result);
        end

        function result = applyMedianFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);

            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai median dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = median(local_neighbourhood(:));
                end
            end

            result = uint8(result);
        end

        function result = applyArithmeticMeanFilterSingleCh(image, window_size)
            % Arithmetic mean dapat menggunakan kernel mean (sama saja)
            kernel = ones(window_size) / window_size^2;
            result = ImageConv.customConvolve(image, kernel);
        end

        function result = geometricMeanLocal(local_neighbourhood)
            mn = numel(local_neighbourhood);
            sum_product = 1;

            local_neighbourhood = double(local_neighbourhood);

            % Hitung perkalian dari semua elemen local neighbourhood
            for i = 1:mn
                sum_product = sum_product * local_neighbourhood(i);
            end

            % Hitung geometric mean (sum_product)^(1/mn))
            geometric_mean = sum_product ^ (1 / mn);
            result = geometric_mean;
        end

        function result = applyGeometricMeanFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);
            
            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai geometric mean dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = SpatialNoiseFilter.geometricMeanLocal(local_neighbourhood(:));
                end
            end

            result = uint8(result);
        end

        function result = harmonicMeanLocal(local_neighbourhood)
            sum_reciprocal = 0;
            mn = numel(local_neighbourhood);

            local_neighbourhood = double(local_neighbourhood);

            % Hitung reciprocal dari semua elemen local neighbourhood
            for i = 1:mn
                sum_reciprocal = sum_reciprocal + 1 / local_neighbourhood(i);
            end

            % Hitung harmonic mean (mn / sum_reciprocal)
            harmonic_mean = mn / sum_reciprocal;
            result = harmonic_mean;
        end

        function result = applyHarmonicMeanFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);
            
            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai harmonic mean dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = SpatialNoiseFilter.harmonicMeanLocal(local_neighbourhood(:));
                end
            end

            result = uint8(result);
        end

        function result = contraharmonicMeanLocal(local_neighbourhood, Q)
            sum_power = 0;
            sum_denom = 0;
            mn = numel(local_neighbourhood);

            local_neighbourhood = double(local_neighbourhood);
            
            % Hitung sum power (bagian atas) dan sum denominator (bagian bawah)
            for i = 1:mn
                sum_power = sum_power + local_neighbourhood(i) ^ (Q + 1);
                sum_denom = sum_denom + local_neighbourhood(i) ^ Q;
            end

            % Hitung contraharmonic mean (sum_power / sum_denom)
            contraharmonic_mean = sum_power / sum_denom;
            result = contraharmonic_mean;
        end

        function result = applyContraharmonicMeanFilterSingleCh(image, window_size, Q)
            [m, n] = size(image);
            result = zeros(m, n);

            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate');

            for i = 1:m
                for j = 1:n
                    % Cari nilai contraharmonic mean dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    result(i, j) = SpatialNoiseFilter.contraharmonicMeanLocal(local_neighbourhood(:), Q);
                end
            end

            result = uint8(result);
        end

        function result = applyMidpointFilterSingleCh(image, window_size)
            [m, n] = size(image);
            result = zeros(m, n);
            
            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai midpoint ((max + min) / 2) dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    min_val = min(local_neighbourhood(:));
                    max_val = max(local_neighbourhood(:));
                    result(i, j) = (min_val + max_val) / 2;
                end
            end

            result = uint8(result);
        end

        function result = applyAlphaTrimmedFilterSingleCh(image, window_size, d)
            [m, n] = size(image);
            result = zeros(m, n);
            
            % Tambahkan padding untuk mengatasi out of bound index
            pad_size = floor(window_size / 2);
            padded_image = padarray(image, [pad_size, pad_size], 'replicate'); % Padding dengan replikasi nilai terdekat

            for i = 1:m
                for j = 1:n
                    % Cari nilai alpha-trimmed mean dari local neighbourhood
                    local_neighbourhood = padded_image(i:i+window_size-1, j:j+window_size-1);
                    sorted = sort(local_neighbourhood(:));

                    % Hilangkan d elemen terkecil dan terbesar (menghilangkan outlier/noise)
                    trimmed = sorted(d+1:end-d);

                    % Hitung rata-rata dari trimmed
                    result(i, j) = mean(trimmed);
                end
            end

            result = uint8(result);
        end
    end
end