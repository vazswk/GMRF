function  show_s_dif(cover,stego)
% 空域嵌入，cover与stego差值显示
    figure;
    stego = int32(stego);
    cover=  int32(cover);
    D = stego-cover;
    imshow(D,[]);
    title('Difference between the two input matrix')
end
