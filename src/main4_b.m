function main4_b()
    % Memilih citra
    imgId = input('Masukkan nama file gambar: ', 's');
    basepath = '../images/';
    img = imread(strcat(basepath, imgId));
    
    % Membuat objek dari kelas UnsharpMasking
    unsharpObj = UnsharpMasking(img);
    
    % Menerapkan Unsharp Masking dan menampilkan hasil
    unsharpObj = unsharpObj.applyFilter();
    unsharpObj.showImages();
end
