classdef UnsharpMasking
    properties
        OriginalImage;
        SharpenedImage;
        Amount = 1.5; % Faktor intensitas dari mask
        Radius = 600;   % Radius filter Gaussian
    end
    
    methods
        function obj = UnsharpMasking(image)
            obj.OriginalImage = image;
        end
        
        function obj = applyFilter(obj)
            % Step 1: Apply Gaussian Blur
            blurred = imgaussfilt(obj.OriginalImage, obj.Radius);
            
            % Step 2: Calculate the mask (difference between original and blurred)
            mask = double(obj.OriginalImage) - double(blurred);
            
            % Step 3: Add the mask to the original image (applying unsharp masking)
            obj.SharpenedImage = uint8(double(obj.OriginalImage) + obj.Amount * mask);
        end
        
        function showImages(obj)
            % Menampilkan citra asli dan citra hasil Unsharp Masking
            figure;
            subplot(1, 2, 1);
            imshow(obj.OriginalImage);
            title('Citra Asli');
            
            subplot(1, 2, 2);
            imshow(obj.SharpenedImage);
            title('Citra Hasil Unsharp Masking');
        end
    end
end
