classdef HighPassFilter
    methods(Static)
        function g = applyIHPF(image, D0)
            if size(image, 3) == 3
                redChannel = HighPassFilter.applyIHPFSingleChannel(image(:, :, 1), D0);
                greenChannel = HighPassFilter.applyIHPFSingleChannel(image(:, :, 2), D0);
                blueChannel = HighPassFilter.applyIHPFSingleChannel(image(:, :, 3), D0);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = HighPassFilter.applyIHPFSingleChannel(image, D0);
                g = cat(3, g, g, g);
            end
        end

        function g = applyIHPFSingleChannel(image, D0)
            % Bagian 1 : Transformasi Image Input ke Ranah Frekuensi
            % Menambahkan Padding pada Citra
            [M, N] = size(image);
            P = 2 * M;
            Q = 2 * N;

            % Copy citra original ke dalam citra yang sudah di padding
            f = im2double(image);
            fp = zeros(P, Q);
            for i = 1:M
                for j = 1:N
                    fp(i, j) = f(i, j);
                end
            end

            % Transformasi ke Ranah Frekuensi
            F = fft2(fp);
            F = fftshift(F);

            % Bagian 2 : Buat Ideal High Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = double(D <= D0);
            H = 1 - H; % ONE MINUS DARI LOW PASS FILTER
            H = fftshift(H);

            % Bagian 3 : Operasi Filtering
            G = H .* F;
            G = ifftshift(G);

            % Bagian 4 : Transformasi Citra Kembali ke Ranah Spasial
            g = ifft2(G); % Inverse Fourier Transform
            g = real(g); % Mengambil bagian real dari citra hasil inversi
            g = g(1:M, 1:N); % Keluarkan bagian citra yang asli (tanpa padding)
        end

        function g = applyGHPF(image, D0)
            if size(image, 3) == 3
                redChannel = HighPassFilter.applyGHPFSingleChannel(image(:, :, 1), D0);
                greenChannel = HighPassFilter.applyGHPFSingleChannel(image(:, :, 2), D0);
                blueChannel = HighPassFilter.applyGHPFSingleChannel(image(:, :, 3), D0);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = HighPassFilter.applyGHPFSingleChannel(image, D0);
                g = cat(3, g, g, g);
            end
        end

        function g = applyGHPFSingleChannel(image, D0)
            % Bagian 1 : Transformasi Image Input ke Ranah Frekuensi
            % Menambahkan Padding pada Citra
            [M, N] = size(image);
            P = 2 * M;
            Q = 2 * N;

            % Copy citra original ke dalam citra yang sudah di padding
            f = im2double(image);
            fp = zeros(P, Q);
            for i = 1:M
                for j = 1:N
                    fp(i, j) = f(i, j);
                end
            end

            % Transformasi ke Ranah Frekuensi
            F = fft2(fp);
            F = fftshift(F);

            % Bagian 2 : Buat Gaussian High Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = exp(-(D.^2) / (2 * D0^2));
            H = 1 - H; % ONE MINUS DARI LOW PASS FILTER
            H = fftshift(H);

            % Bagian 3 : Operasi Filtering
            G = H .* F;
            G = ifftshift(G);

            % Bagian 4 : Transformasi Citra Kembali ke Ranah Spasial
            g = ifft2(G); % Inverse Fourier Transform
            g = real(g); % Mengambil bagian real dari citra hasil inversi
            g = g(1:M, 1:N); % Keluarkan bagian citra yang asli (tanpa padding)
        end

        function g = applyBHPF(image, D0, n)
            if size(image, 3) == 3
                redChannel = HighPassFilter.applyBHPFSingleChannel(image(:, :, 1), D0, n);
                greenChannel = HighPassFilter.applyBHPFSingleChannel(image(:, :, 2), D0, n);
                blueChannel = HighPassFilter.applyBHPFSingleChannel(image(:, :, 3), D0, n);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = HighPassFilter.applyBHPFSingleChannel(image, D0, n);
                g = cat(3, g, g, g);
            end
        end

        function g = applyBHPFSingleChannel(image, D0, n)
            % Bagian 1 : Transformasi Image Input ke Ranah Frekuensi
            % Menambahkan Padding pada Citra
            [M, N] = size(image);
            P = 2 * M;
            Q = 2 * N;

            % Copy citra original ke dalam citra yang sudah di padding
            f = im2double(image);
            fp = zeros(P, Q);
            for i = 1:M
                for j = 1:N
                    fp(i, j) = f(i, j);
                end
            end

            % Transformasi ke Ranah Frekuensi
            F = fft2(fp);
            F = fftshift(F);

            % Bagian 2 : Buat Butterworth High Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = 1./(1 + (D/D0).^(2*n));
            H = 1 - H; % ONE MINUS DARI LOW PASS FILTER
            H = fftshift(H);

            % Bagian 3 : Operasi Filtering
            G = H .* F;
            G = ifftshift(G);

            % Bagian 4 : Transformasi Citra Kembali ke Ranah Spasial
            g = ifft2(G); % Inverse Fourier Transform
            g = real(g); % Mengambil bagian real dari citra hasil inversi
            g = g(1:M, 1:N); % Keluarkan bagian citra yang asli (tanpa padding)
        end
    end
end