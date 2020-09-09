path = 'C:\Users\dnhth\Desktop\Adaptive EE Inpainting';
Inputs=dir(strcat(path,'\dataset\*.jpg'));
Masks=dir(strcat(path,'\mask\*.png'));
% Note: white is for corrupted regions.

for k=1:length(Inputs)
    s1 = strsplit(Inputs(k).name, '.');
    for p=1:length(Masks)
        s2 = strsplit(Masks(p).name, '.');
        fname = strcat(s2{1}, '_', s1{1}, '.png');
        
        K = double(imread(strcat(path,'\mask\', Masks(p).name)));
        Iori = im2double(imread(strcat(path,'\dataset\', Inputs(k).name)));

        K(K==0)=0;
        K(K~=0)=1;
        K=1-K;
        Icorr = Iori;
        Icorr(K==0)=1;
        imwrite(Icorr, strcat(path, '\corrupted\', fname));
    end
end