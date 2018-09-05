function[xx, yy] = ravi_LRT_new(Y)

deltaP=15; deltaN=-13;

nx=4; ny=4; % (2nx+1).(2ny+1) neighborhood size
 
Y=Y(:,:,2);

outP=delta_LRT_extended_neighborhood(Y,deltaP,nx,ny);
outN=delta_LRT_extended_neighborhood(Y,deltaN,nx,ny);
outP_interval=double(LTR_component(outP,5,400));
outN_interval=double(LTR_component(outN,5,400));
  
xx = uint8(imadjust(uint8(outP_interval)));
yy = uint8(imadjust(uint8(outN_interval)));