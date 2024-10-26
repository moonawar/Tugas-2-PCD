function main6_6()
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
    cols = [1, 101, 201, 301, 401, 501, 601, 701, 801, 901, 1000];
    rows1 = [1, 134, 267, 400, 533, 666];
    rows2 = [68, 201, 334, 467, 600];

    rad = 9;

    for j = cols(2:end-1)
        for i = 1:666
            if j == 501
                if abs(i-333) > 20
                    F(i, j-1:j+1) = 0;
                end
            end    
        end
    end

    for j = 1:length(cols)
        if mod(j, 2) == 1 
            current_rows = rows1;
        else
            current_rows = rows2; 
        end
        
        col_index = cols(j); 
        
        for row = current_rows
            if row == 334 && col_index == 501
            else
                row_start = max(row - rad, 1);
                row_end = min(row + rad, size(F, 1));
                
                if col_index == 1
                    F(row_start:row_end, col_index:col_index + rad) = 0;
                elseif col_index == 1000
                    F(row_start:row_end, col_index - rad:col_index) = 0;
                else
                    F(row_start:row_end, col_index - rad:col_index) = 0;
                end
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
