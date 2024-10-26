classdef LuckyRichardson
    properties
        ImageOriginal
        PSF
    end
    
    methods
        function obj = LuckyRichardson(imagePath)
            % Constructor: baca citra
            obj.ImageOriginal = imread(imagePath);
        end
        
        function processImage(obj, len, theta, iterations)
            % Mengatur PSF untuk motion blur
            obj.PSF = fspecial('motion', len, theta);
            
            % Merestorasi citra menggunakan metode Lucy-Richardson
            restoredImage = deconvlucy(obj.ImageOriginal, obj.PSF, iterations);
            
            % Menampilkan citra input, citra yang diperbaiki, dan perbedaan citra
            obj.showImages(restoredImage);
        end
        
        function showImages(obj, restoredImage)
            % Menampilkan citra input, citra yang diperbaiki, dan perbedaan citra
            figure('Position', [100, 100, 1500, 600]);
            subplot(1, 3, 1);
            imshow(obj.ImageOriginal); 
            title('Citra Asli (Blurred)');
            
            subplot(1, 3, 2);
            imshow(restoredImage); 
            title('Citra Terestorasi');
            
            subplot(1, 3, 3);
            diffImage = imabsdiff(obj.ImageOriginal, restoredImage);
            imshow(diffImage); 
            title('Perbedaan Citra');
        end
    end
end
