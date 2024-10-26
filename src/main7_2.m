function main7_2()
    % Memilih citra
    imgId = input('Masukkan nama file gambar (contoh: "gambar.jpg"): ', 's');
    basepath = '../images/';  % Ganti dengan jalur folder gambar Anda
    imgPath = strcat(basepath, imgId);
    
    % Memastikan file citra ada di jalur yang benar
    if ~isfile(imgPath)
        error('File tidak ditemukan. Pastikan file ada di folder yang benar.');
    end
    
    % Membuat objek LuckyRichardson
    lucky = LuckyRichardson(imgPath);
    
    % Mengatur parameter untuk pemrosesan citra
    len = 8;        % Panjang blur
    theta = 10;     % Sudut blur
    iterations = 12; % Jumlah iterasi untuk restorasi

    % Memproses citra
    lucky.processImage(len, theta, iterations);
end
