function  show_s_dif(cover,stego)
% ����Ƕ�룬cover��stego��ֵ��ʾ
    figure;
    stego = int32(stego);
    cover=  int32(cover);
    D = stego-cover;
    imshow(D,[]);
    title('Difference between the two input matrix')
end
