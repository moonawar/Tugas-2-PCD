classdef HomomorphicFilter
    properties
        LowPassD0 % Cutoff frequency untuk low-pass filter
        HighPassD0 % Cutoff frequency untuk high-pass filter
        GammaL % Faktor pengali untuk low frequencies
        GammaH % Faktor pengali untuk high frequencies
    end
    
    methods
        % Konstruktor untuk menginisialisasi parameter filter
        function obj = HomomorphicFilter(LowPassD0, HighPassD0, GammaL, GammaH)
            obj.LowPassD0 = LowPassD0;
            obj.HighPassD0 = HighPassD0;
            obj.GammaL = GammaL;
            obj.GammaH = GammaH;
        end
        
        % Fungsi utama untuk menerapkan filter homomorphic
        function result = applyFilter(obj, img)
            % Cek apakah citra berwarna atau grayscale
            if size(img, 3) == 3
                % Proses setiap kanal warna secara terpisah
                result = zeros(size(img));
                for channel = 1:3
                    result(:, :, channel) = obj.processChannel(double(img(:, :, channel)) / 255);
                end
                result = im2uint8(result); % Konversi ke format 8-bit
            else
                % Jika grayscale, proses langsung
                result = obj.processChannel(double(img) / 255);
                result = im2uint8(result); % Konversi ke format 8-bit
            end
        end
        
        % Fungsi untuk memproses setiap kanal warna atau citra grayscale
        function channel_result = processChannel(obj, img)
            % Log transform untuk meningkatkan kontras
            img_log = log1p(img);
            
            % Transformasi Fourier
            img_fft = fft2(img_log);
            img_fft_shifted = fftshift(img_fft);
            
            % Membangun filter homomorphic
            [rows, cols] = size(img);
            [u, v] = meshgrid(-floor(cols/2):floor((cols-1)/2), -floor(rows/2):floor((rows-1)/2));
            D = sqrt(u.^2 + v.^2);
            % Gaussian low-pass filter
            low_pass = exp(-(D.^2) / (2 * obj.LowPassD0^2));
            % Gaussian high-pass filter
            high_pass = 1 - exp(-(D.^2) / (2 * obj.HighPassD0^2));
            % Kombinasi filter
            H = obj.GammaL + (obj.GammaH - obj.GammaL) * (high_pass .* low_pass);
            
            % Terapkan filter pada transformasi Fourier
            img_filtered_fft = img_fft_shifted .* H;
            img_filtered_fft = ifftshift(img_filtered_fft);
            img_filtered = ifft2(img_filtered_fft);
            img_filtered = real(img_filtered);
            
            % Eksponensial invers untuk kembali ke domain spasial
            channel_result = exp(img_filtered) - 1;
            channel_result = mat2gray(channel_result); % Normalisasi hasil
        end
        
        % Fungsi untuk menampilkan citra asli dan hasil filter
        function displayResults(obj, original, filtered)
            figure('Position', [100, 100, 1000, 600]);
            subplot(1, 2, 1); imshow(original); title('Original Image');
            subplot(1, 2, 2); imshow(filtered); title('Filtered Image (Homomorphic)');
        end
    end
end
