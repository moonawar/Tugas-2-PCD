classdef HighPassFilter
    methods(Static)
        function result = applyIHPF(image, D0)
            % Apply ideal high-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % result: sharpened image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    if D > D0
                        H(u, v) = 1;
                    end
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end

        function result = applyGHPF(image, D0)
            % Apply Gaussian high-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % result: sharpened image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    H(u, v) = 1 - exp(-(D^2) / (2 * D0^2));
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end

        function result = applyBHPF(image, D0, n)
            % Apply Butterworth high-pass filter to the image
            % image: input image
            % D0: cutoff frequency
            % n: order of the filter
            % result: sharpened image
            F = fft2(image);
            F = fftshift(F);
            [M, N] = size(F);
            H = zeros(M, N);
            for u = 1:M
                for v = 1:N
                    D = sqrt((u - M/2)^2 + (v - N/2)^2);
                    H(u, v) = 1 / (1 + (D0 / D)^(2 * n));
                end
            end
            G = H .* F;
            G = ifftshift(G);
            result = ifft2(G);
        end
    end
end