classdef FreqImageSmoothing
    methods(Static)
        function g = applyILPF(image, D0)
            if size(image, 3) == 3
                redChannel = FreqImageSmoothing.applyILPFSingleChannel(image(:, :, 1), D0);
                greenChannel = FreqImageSmoothing.applyILPFSingleChannel(image(:, :, 2), D0);
                blueChannel = FreqImageSmoothing.applyILPFSingleChannel(image(:, :, 3), D0);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = FreqImageSmoothing.applyILPFSingleChannel(image, D0);
                g = cat(3, g, g, g);
            end
        end

        function g = applyILPFSingleChannel(image, D0)
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

            % Bagian 2 : Buat Ideal Low Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = double(D <= D0);
            H = fftshift(H);

            % Bagian 3 : Operasi Filtering
            G = H .* F;
            G = ifftshift(G);

            % Bagian 4 : Transformasi Citra Kembali ke Ranah Spasial
            g = ifft2(G); % Inverse Fourier Transform
            g = real(g); % Mengambil bagian real dari citra hasil inversi
            g = g(1:M, 1:N); % Keluarkan bagian citra yang asli (tanpa padding)
        end

        function g = applyGLPF(image, D0)
            if size(image, 3) == 3
                redChannel = FreqImageSmoothing.applyGLPFSingleChannel(image(:, :, 1), D0);
                greenChannel = FreqImageSmoothing.applyGLPFSingleChannel(image(:, :, 2), D0);
                blueChannel = FreqImageSmoothing.applyGLPFSingleChannel(image(:, :, 3), D0);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = FreqImageSmoothing.applyGLPFSingleChannel(image, D0);
                g = cat(3, g, g, g);
            end
        end

        function g = applyGLPFSingleChannel(image, D0)
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

            % Bagian 2 : Buat Ideal Low Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = exp(-(D.^2) / (2 * D0^2));
            H = fftshift(H);

            % Bagian 3 : Operasi Filtering
            G = H .* F;
            G = ifftshift(G);

            % Bagian 4 : Transformasi Citra Kembali ke Ranah Spasial
            g = ifft2(G); % Inverse Fourier Transform
            g = real(g); % Mengambil bagian real dari citra hasil inversi
            g = g(1:M, 1:N); % Keluarkan bagian citra yang asli (tanpa padding)
        end

        function g = applyBLPF(image, D0, n)
            if size(image, 3) == 3
                redChannel = FreqImageSmoothing.applyBLPFSingleChannel(image(:, :, 1), D0, n);
                greenChannel = FreqImageSmoothing.applyBLPFSingleChannel(image(:, :, 2), D0, n);
                blueChannel = FreqImageSmoothing.applyBLPFSingleChannel(image(:, :, 3), D0, n);

                g = cat(3, redChannel, greenChannel, blueChannel);
            else
                g = FreqImageSmoothing.applyBLPFSingleChannel(image, D0, n);
                g = cat(3, g, g, g);
            end
        end

        function g = applyBLPFSingleChannel(image, D0, n)
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

            % Bagian 2 : Buat Ideal Low Pass Filter dalam Ranah Frekuensi
            u = 0:(P-1);
            v = 0:(Q-1);

            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;

            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);

            H = 1./(1 + (D/D0).^(2*n));
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