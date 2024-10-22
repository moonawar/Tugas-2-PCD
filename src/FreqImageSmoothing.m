classdef FreqImageSmoothing
    methods(Static)
        function result = applyILPF(image, D0)
            % Apply ideal low-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % result: smoothed image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    if D <= D0
                        H(u, v) = 1;
                    end
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end

        function result = applyBLPF(image, D0)
            % Apply Butterworth low-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % result: smoothed image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    H(u, v) = 1 / (1 + (D / D0)^2);
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end

        function result = applyGLPF(image, D0)
            % Apply Gaussian low-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % result: smoothed image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    H(u, v) = exp(-(D^2) / (2 * D0^2));
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end
    end
end