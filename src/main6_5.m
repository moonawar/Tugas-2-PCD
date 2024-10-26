function main6_5()
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
    
    % Buang frekuensi yang mengganggu (Notch Filter berbentuk blok)
    % Definisikan area frekuensi yang akan di-nol-kan (dihilangkan)
    cols = [14, 40, 61, 66, 87, 113, 118, 139, 165, 191, ...
           212, 217, 238, 243, 264, 290, 316, 342, ...
           368, 389, 394, 415, 420, 441, 467, ...
           493, 514, 519, 540, 545, 566, 571, 592, ...
           618];

    for j = cols
        F(1:476, j-1:j+1) = 0;
    end

    % Hasil Fourier setelah *notch filter*
    S2_filtered = log(1 + abs(F));

    % Ambil bagian real dari inverse FFT of G
    G = real(ifft2(ifftshift(F))); % Terapkan inverse Fourier Transform
    
    % Buat subplot untuk menampilkan semua citra
    figure('Position', [100, 100, 800, 800]);
    
    % Tampilkan citra asli
    subplot(2, 2, 1);
    imshow(f, []); title('Citra Input');
    
    % Tampilkan spektrum Fourier sebelum *notch filter*
    subplot(2, 2, 2);
    imshow(S2, []); title('Fourier Spectrum Sebelum Notch Filter');
    
    % Tampilkan spektrum Fourier setelah *notch filter*
    subplot(2, 2, 3);
    imshow(S2_filtered, []); title('Fourier Spectrum Setelah Notch Filter');
    
    % Tampilkan hasil akhir setelah penerapan *notch filter*
    subplot(2, 2, 4);
    imshow(G, []); title('Citra Output Setelah Notch Filter');
end
