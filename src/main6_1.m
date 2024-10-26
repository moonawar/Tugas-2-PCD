function main6_1()
    % Memilih citra
    imgId = input('Masukkan nama file gambar: ', 's');
    basepath = '../images/';
    img = imread(strcat(basepath, imgId));
    
    % Jika gambar adalah RGB, konversi ke grayscale
    if size(img, 3) == 3
        f = rgb2gray(img);
    else
        f = img;
    end

    % Lakukan transformasi Fourier
    F = fft2(f);
    F = fftshift(F); % Pindahkan asal transformasi ke pusat
    S2 = log(1 + abs(F)); % Hitung magnitudo dan gunakan log untuk menerangi tampilan
    
    % Parameter filter
    D0 = 15; % Frekuensi cutoff
    W = 5;   % Lebar pita
    n = 1;   % Orde

    % Bangkitkan fungsi penapis H berukuran M x N (Butterworth Bandreject Filter)
    [M, N] = size(f); % Mendapatkan ukuran citra
    u = 0:(M-1);
    v = 0:(N-1);

    % Menghitung indeks untuk meshgrid
    idx = find(u > M/2);
    u(idx) = u(idx) - M;
    idy = find(v > N/2);
    v(idy) = v(idy) - N;

    % Menghitung meshgrid
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);
    H = 1 ./ (1 + ((D * W) ./ (D.^2 - D0^2)).^(2 * n));
    H = fftshift(H); 

    % Kalikan F dengan H
    G = H .* F;

    % Ambil bagian real dari inverse FFT of G
    G = real(ifft2(ifftshift(G))); % Terapkan inverse, discrete Fourier transform
    
    % Buat subplot untuk menampilkan semua citra
    figure('Position', [100, 100, 800, 800]);
    
    % Tampilkan citra asli
    subplot(2, 2, 1);
    imshow(f, []); title('Citra Input');
    
    % Tampilkan spektrum Fourier
    subplot(2, 2, 2);
    imshow(S2, []); title('Fourier Spectrum');
    hold on;
    theta = linspace(0, 2*pi, 100); % Sudut lingkaran
    x0 = size(S2, 2)/2; % Tengah gambar (sumbu X)
    y0 = size(S2, 1)/2; % Tengah gambar (sumbu Y)
    
    % Lingkaran batas bawah (D0 - W/2)
    D_low = D0 - W/2;
    xCircleLow = x0 + D_low * cos(theta); % Koordinat lingkaran bawah (X)
    yCircleLow = y0 + D_low * sin(theta); % Koordinat lingkaran bawah (Y)
    plot(xCircleLow, yCircleLow, 'b--', 'LineWidth', 1.5); % Gambar lingkaran batas bawah

    % Lingkaran batas atas (D0 + W/2)
    D_high = D0 + W/2;
    xCircleHigh = x0 + D_high * cos(theta); % Koordinat lingkaran atas (X)
    yCircleHigh = y0 + D_high * sin(theta); % Koordinat lingkaran atas (Y)
    plot(xCircleHigh, yCircleHigh, 'b--', 'LineWidth', 1.5); % Gambar lingkaran batas atas

    % Anotasi untuk nilai D0 dan W
    plot(x0 + D0 * cos(theta), y0 + D0 * sin(theta), 'r-', 'LineWidth', 1.5); % Gambar lingkaran pada D0
    text(x0 + D0 + 10, y0, ['D0 = ' num2str(D0)], 'Color', 'red', 'FontSize', 10);
    text(x0 + D_high + 10, y0, ['W = ' num2str(W)], 'Color', 'blue', 'FontSize', 10);
    hold off;

    % Tampilkan Butterworth Bandreject Filter
    subplot(2, 2, 3);
    imshow(H, []); title('Butterworth Bandreject Filter');
    
    % Tampilkan hasil akhir setelah penerapan filter
    subplot(2, 2, 4);
    imshow(G, []); title('Citra Output');
end
