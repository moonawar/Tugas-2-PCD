function main1()
    % Memilih citra
    imgId = input('Masukkan nama file gambar: ', 's');
    basepath = '../images/';
    img = imread(strcat(basepath, imgId));

    % Mask yang digunakan sesuai dengan contoh pada spesifikasi
    mask1 = (1/16) * [1 2 1; 2 4 2; 1 2 1];
    mask2 = [0 -1 0; -1 4 -1; 0 -1 0];
    mask3 = (1/140) * [
        1 1 2 2 2 1 1;
        1 2 2 4 2 2 1;
        2 2 4 8 4 2 2;
        2 4 8 16 8 4 2;
        2 2 4 8 4 2 2;
        1 2 2 4 2 2 1;
        1 1 2 2 2 1 1];
    mask4 = [-1 -1 -1; -1 17 -1; -1 -1 -1];

    % Memproses dan menampilkan citra
    ImageConv.processAndDisplay(img, mask1, "Konvolusi Mask 1");
    ImageConv.processAndDisplay(img, mask2, "Konvolusi Mask 2");
    ImageConv.processAndDisplay(img, mask3, "Konvolusi Mask 3");
    ImageConv.processAndDisplay(img, mask4, "Konvolusi Mask 4");
end