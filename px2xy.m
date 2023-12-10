function [x,y] = px2xy(x_im,y_im)
  scale=100/415; % px/mm
  vx=340*scale;  % mm
  vy=212*scale;  % mm
  ty=95;         % mm
  x=x_im*scale-vx;
  y=-y_im*scale+vy+ty;
end
