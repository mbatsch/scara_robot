function [fiL,fiR] = invKin(xT,yT)
    l1=75;  % arm length in mm
    l2=95;  % arm length in mm
    e=45/2; % half of the distance between motor shafts in mm
    
    fiR=atan2(yT,xT-e)-acos(((xT-e)^2+yT^2+l1^2-l2^2)/(2*l1*sqrt((xT-e)^2+yT^2)));
    fiL=atan2(yT,xT+e)+acos(((xT+e)^2+yT^2+l1^2-l2^2)/(2*l1*sqrt((xT+e)^2+yT^2)));
end
