function main4_a()
    % Memilih citra
    imgId = input('Masukkan nama file gambar: ', 's');
    basepath = '../images/';
    img = imread(strcat(basepath, imgId));
    
    % Inisialisasi filter homomorphic dengan parameter
    lowPassD0 = 18;
    highPassD0 = 1500;
    gammaL = 0.004;
    gammaH = 50.0;
    
    % Membuat objek filter
    homomorphicFilter = HomomorphicFilter(lowPassD0, highPassD0, gammaL, gammaH);
    
    % Terapkan filter
    filtered_img = homomorphicFilter.applyFilter(img);
    
    % Tampilkan hasil
    homomorphicFilter.displayResults(img, filtered_img);
end
