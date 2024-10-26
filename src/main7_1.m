function main7_1()
    % Memilih citra
    imgId = input('Masukkan nama file gambar (contoh: "gambar.jpg"): ', 's');
    basepath = '../images/';  % Ganti dengan jalur folder gambar Anda
    imgPath = strcat(basepath, imgId);
    
    % Memastikan file citra ada di jalur yang benar
    if ~isfile(imgPath)
        error('File tidak ditemukan. Pastikan file ada di folder yang benar.');
    end

    % Parameter untuk motion blur
    LEN = input('Masukkan panjang blur (LEN) (contoh: 20): ');
    THETA = input('Masukkan sudut blur (THETA) dalam derajat (contoh: 30): ');
    noisePower = input('Masukkan noise power (contoh: 0 untuk tanpa noise): ');
    
    % Buat objek WienerFilter dengan parameter yang ditentukan
    wienerFilter = WienerFilter(imgPath, LEN, THETA, noisePower);
    
    % Terapkan filter Wiener buatan sendiri dan MATLAB
    wienerFilter = wienerFilter.applyCustomWienerFilter();
    wienerFilter = wienerFilter.applyMATLABWienerFilter();
    
    % Tampilkan hasil menggunakan fungsi displayResults di kelas
    wienerFilter.displayResults();
end
