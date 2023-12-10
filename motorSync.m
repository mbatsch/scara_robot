function motorSync(r,fiL,fiR)

    % Pins for left motor 
    configurePin(r,14,'DigitalOutput');   
    configurePin(r,15,'DigitalOutput');   
    configurePin(r,23,'DigitalOutput');   
    configurePin(r,24,'DigitalOutput');
    
    % Pins for right motor
    configurePin(r,25,'DigitalOutput');   
    configurePin(r,12,'DigitalOutput');   
    configurePin(r,16,'DigitalOutput');   
    configurePin(r,20,'DigitalOutput'); 

    ratio=64;  % Gearbox reduction ratio
    st_rev=64; % Steps per rev. in Half-Step operation
    
    seqL=zeros(8,4); % memory allocation for left motor sequence
    seqR=zeros(8,4); % memory allocation for right motor sequence
    stepCount=8;     % number of step sequences for half-step operation

    % Define sequences for clockwise (+) and counterclockwise (-) movement
    if fiL>0
        seqL(1,:)=[1,0,0,0];
        seqL(2,:)=[1,1,0,0];
        seqL(3,:)=[0,1,0,0];
        seqL(4,:)=[0,1,1,0];
        seqL(5,:)=[0,0,1,0];
        seqL(6,:)=[0,0,1,1];
        seqL(7,:)=[0,0,0,1];
        seqL(8,:)=[1,0,0,1];
    elseif fiL<0
        seqL(8,:)=[1,0,0,0];
        seqL(7,:)=[1,1,0,0];
        seqL(6,:)=[0,1,0,0];
        seqL(5,:)=[0,1,1,0];
        seqL(4,:)=[0,0,1,0];
        seqL(3,:)=[0,0,1,1];
        seqL(2,:)=[0,0,0,1];
        seqL(1,:)=[1,0,0,1];
    else
        seqL=zeros(8,4);
    end
    
    if fiR>0
        seqR(1,:)=[1,0,0,0];
        seqR(2,:)=[1,1,0,0];
        seqR(3,:)=[0,1,0,0];
        seqR(4,:)=[0,1,1,0];
        seqR(5,:)=[0,0,1,0];
        seqR(6,:)=[0,0,1,1];
        seqR(7,:)=[0,0,0,1];
        seqR(8,:)=[1,0,0,1];
    elseif fiR<0
        seqR(8,:)=[1,0,0,0];
        seqR(7,:)=[1,1,0,0];
        seqR(6,:)=[0,1,0,0];
        seqR(5,:)=[0,1,1,0];
        seqR(4,:)=[0,0,1,0];
        seqR(3,:)=[0,0,1,1];
        seqR(2,:)=[0,0,0,1];
        seqR(1,:)=[1,0,0,1];
    else
        seqR=zeros(8,4);
    end

    revsL=abs(fiL)/(2*pi);            % conversion from rad to revolutions
    stepsL=round(revsL*st_rev*ratio); % conversion from revs to number of steps
    
    revsR=abs(fiR)/(2*pi);            % conversion from rad to revolutions
    stepsR=round(revsR*st_rev*ratio); % conversion from revs to number of steps
    
    stepTime=2/1000;%1.5

    if stepsL>=stepsR
        dStep=round(stepsL/stepsR);
        j=1;
        jj=1;
        for i=1:stepsR
            setStepR(r,seqR(j,1),seqR(j,2),seqR(j,3),seqR(j,4));
            for ii=1:dStep
                setStepL(r,seqL(jj,1),seqL(jj,2),seqL(jj,3),seqL(jj,4));    
                delay(stepTime);
                if jj==stepCount
                   jj=1;
                else
                   jj=jj+1;
                end
            end

            if j==stepCount
                j=1;
            else
                j=j+1;
            end
        end
    else
        dStep=round(stepsR/stepsL);
        j=1;
        jj=1;
        for i=1:stepsL
            setStepL(r,seqL(j,1),seqL(j,2),seqL(j,3),seqL(j,4));
            for ii=1:dStep
                setStepR(r,seqR(jj,1),seqR(jj,2),seqR(jj,3),seqR(jj,4));    
                delay(stepTime);
                if jj==stepCount
                   jj=1;
                else
                   jj=jj+1;
                end
            end

            if j==stepCount
                j=1;
            else
                j=j+1;
            end
        end
    end
setStepR(r,0,0,0,0); % zero the right motor pins
setStepL(r,0,0,0,0); % zero the left motor pins 
end
