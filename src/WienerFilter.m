classdef WienerFilter
    properties
        originalImage;        % Citra asli
        blurredImage;         % Citra yang sudah diblur
        restoredImageCustom;  % Citra yang direstorasi dengan filter Wiener buatan sendiri
        restoredImageMATLAB;  % Citra yang direstorasi dengan fungsi Wiener bawaan MATLAB
        PSF;                  % Point Spread Function (PSF) untuk motion blur
        noisePower;           % Power dari noise (default: 0)
    end
    
    methods
        % Konstruktor kelas
        function obj = WienerFilter(imagePath, len, theta, noisePower)
            if nargin < 4
                noisePower = 0; % Default nilai NSR jika tidak ada noise
            end
            obj.originalImage = im2double(imread(imagePath)); % Baca citra
            obj.noisePower = noisePower; % Set noise power
            obj.PSF = fspecial('motion', len, theta); % Buat PSF untuk motion blur
            
            % Lakukan blur pada citra berwarna
            if size(obj.originalImage, 3) == 3
                obj.blurredImage = zeros(size(obj.originalImage)); % Inisialisasi citra blur
                for c = 1:3
                    obj.blurredImage(:, :, c) = imfilter(obj.originalImage(:, :, c), obj.PSF, 'conv', 'circular');
                end
            else
                obj.blurredImage = imfilter(obj.originalImage, obj.PSF, 'conv', 'circular'); % Lakukan blur untuk grayscale
            end
        end
        
        % Fungsi untuk melakukan restorasi dengan filter Wiener buatan sendiri
        function obj = applyCustomWienerFilter(obj)
            % Transformasi Fourier dari blurred image dan PSF
            G = fft2(obj.blurredImage);
            H = fft2(obj.PSF, size(obj.originalImage, 1), size(obj.originalImage, 2));
            H_conj = conj(H); % Konjugat dari H
            
            % Rumus Wiener: R = (H_conj / (|H|^2 + NSR)) * G
            S_f = abs(G).^2; % Estimasi spektrum daya dari citra
            S_n = obj.noisePower; % Estimasi spektrum daya dari noise
            NSR = S_n ./ (S_f + eps); % Perhitungan NSR, sekarang S_n dibagi elemen-wise
        
            % Wiener filter formula
            R = (H_conj ./ (abs(H).^2 + NSR)) .* G;
            obj.restoredImageCustom = real(ifft2(R)); % Inverse FFT untuk mendapatkan hasil restorasi
        end

        % Fungsi untuk melakukan restorasi dengan filter Wiener bawaan MATLAB
        function obj = applyMATLABWienerFilter(obj)
            % Lakukan restorasi pada setiap saluran warna
            obj.restoredImageMATLAB = zeros(size(obj.blurredImage));
            for c = 1:3
                obj.restoredImageMATLAB(:, :, c) = deconvwnr(obj.blurredImage(:, :, c), obj.PSF, obj.noisePower);
            end
        end
        
        % Fungsi untuk menampilkan hasil menggunakan subplot
        function displayResults(obj)
            figure('Position', [100, 100, 1500, 600]);
            subplot(2, 3, 1), imshow(obj.originalImage), title('Original Image');
            subplot(2, 3, 2), imshow(obj.blurredImage), title('Blurred Image');
            subplot(2, 3, 3), imshow(obj.restoredImageCustom), title('Restored Image (Custom Wiener)');
            subplot(2, 3, 4), imshow(obj.restoredImageMATLAB), title('Restored Image (MATLAB Wiener)');
            subplot(2, 3, 5), imshow(imabsdiff(obj.originalImage, obj.restoredImageCustom)), title('Diff: Original vs Custom');
            subplot(2, 3, 6), imshow(imabsdiff(obj.originalImage, obj.restoredImageMATLAB)), title('Diff: Original vs MATLAB');
        end

        % Fungsi untuk menampilkan hasil restorasi tanpa tampilan blur
        function displayRestorationOnly(obj)
            figure('Position', [100, 100, 1200, 400]);
            subplot(1, 3, 1), imshow(obj.originalImage), title('Original Image');
            subplot(1, 3, 2), imshow(obj.restoredImageCustom), title('Restored Image (Custom Wiener)');
            subplot(1, 3, 3), imshow(imabsdiff(obj.originalImage, obj.restoredImageCustom)), title('Difference: Original vs Restored');
        end
    end
end
