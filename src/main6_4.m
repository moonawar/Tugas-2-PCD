function main6_4()
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
    F(247:249, 431:433) = 0;
    F(247:249, 231:233) = 0;
    
    peaks = [197, 223, 273, 298];

    for j = 332:333
        for i = 1:522
            if ismember(i, peaks)
                F(i-1:i+1, j-1:j+1) = 0;
            end
        end
    end

    for j = 232:233
        for i = 1:522
            if ismember(i, peaks)
                F(i-1:i+1, j-1:j+1) = 0; 
            end
        end
    end
    
    for j = 432:433
        for i = 1:522
            if ismember(i, peaks)
                F(i-1:i+1, j-1:j+1) = 0; 
            end
        end
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
