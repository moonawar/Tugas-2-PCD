classdef InverseFiltering
    properties
        BlurredImage
        RecoveredImage
    end
    
    methods
        function obj = InverseFiltering(imagePath)
            % Membaca citra blur dari path yang diberikan
            obj.BlurredImage = imread(imagePath);
            obj.RecoveredImage = obj.applyInverseFiltering(obj.BlurredImage);
        end
        
        function recoveredImage = applyInverseFiltering(obj, blurredImage)
            % Mengonversi citra ke domain double
            blurredImage = im2double(blurredImage);
            [M, N] = size(blurredImage);
            
            % Membuat filter Gaussian
            H = fspecial('gaussian', [5 5], 2);
            H = psf2otf(H, [M N]); % Mengubah ke domain frekuensi
            
            % Menghitung Fourier Transform dari citra yang blur
            B = fft2(blurredImage);
            
            % Menghindari pembagian dengan nol
            H(H < 1e-6) = 1e-6; % Untuk stabilitas numerik
            
            % Melakukan inverse filtering
            R = B ./ H; % Melakukan pembagian
            recoveredImage = real(ifft2(R)); % Mengembalikan ke domain spasial
            recoveredImage = max(0, min(recoveredImage, 1)); % Pastikan nilai pixel antara 0 dan 1
        end
        
        function displayImages(obj)
            % Menampilkan citra
            figure;
            
            subplot(1, 2, 1);
            imshow(obj.BlurredImage);
            title('Citra Blur');
            
            subplot(1, 2, 2);
            imshow(obj.RecoveredImage);
            title('Citra Diperbaiki');
        end
    end
end
