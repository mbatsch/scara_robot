function centroids = getOBJcoords(r)%#codegen

    w = webcam(r,'/dev/video0','640x480');
    rgbImage = snapshot(w);
    
    [im,jm,km]=size(rgbImage);
    binaryMask=zeros(im,jm);
    for i=1:im 
        for j=1:jm
            if j>=98 && j<=585 && i>=11 && i<=412
                binaryMask(i,j)=1;
            else
                binaryMask(i,j)=0;
            end
        end
    end
    
    kern = [1 2 1; 0 0 0; -1 -2 -1];
    h = conv2(rgbImage(:,:,1),kern,'same');
    v = conv2(rgbImage(:,:,1),kern','same');
    e = sqrt(h.*h + v.*v);
    BW = logical(((e > 25) * 340 ).*binaryMask);
    
    SE = strel("disk",1);
    
    BW=imdilate(BW,SE);
    BW = imfill(BW,'holes');
    BW=imerode(BW,SE);
    BW = bwareaopen(BW, 100);
    
    hBlob = vision.BlobAnalysis('AreaOutputPort',false,'BoundingBoxOutputPort',false);
    centroids = hBlob(BW);

end
