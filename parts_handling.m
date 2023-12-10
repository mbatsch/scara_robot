function parts_handling()%#codegen

    r=raspi();
    motorSync(r,0,0)

    boxCoords=[-91,120;91,120;-91,45;91,45];
    centroids = getOBJcoords(r);
    [numOBJ, numCoords]=size(centroids);
    
    [fiL0,fiR0]=invKin(0,29.3);
    
    fiL=fiL0;
    fiR=fiR0;
    
    for i=1:numOBJ    
        [x,y]=px2xy(centroids(i,1), centroids(i,2));
        [fiLr,fiRr]=invKin(x,y);
        dfiL=-(fiLr-fiL);
        dfiR=-(fiRr-fiR);
        motorSync(r,dfiL,dfiR);
        fiL=fiLr;
        fiR=fiRr;

        delay(1);
        magOn(r);
        delay(1);

        [fiLr,fiRr]=invKin(boxCoords(i,1),boxCoords(i,2));
        dfiL=-(fiLr-fiL);
        dfiR=-(fiRr-fiR);
        motorSync(r,dfiL,dfiR);
        fiL=fiLr;
        fiR=fiRr;

        delay(1);
        magOff(r);
        delay(1);
   end

[fiLr,fiRr]=invKin(0,29.3);
dfiL=-(fiLr-fiL);
dfiR=-(fiRr-fiR);
motorSync(r,dfiL,dfiR);

end
