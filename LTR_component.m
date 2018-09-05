 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These codes are written by Prof. Jayanta Mukherjee, IIT Kharagpur during 2008 to  2011. The codes may be used freely for 
% any academic and research purpose with appropriate acknowledgment. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y=LTR_component(X,lval,rval)
% retains values between lval and rval and assigns zero to others
[height width depth]=size(X);

Y=zeros(height,width);

for i=1:height
    for j=1:width
        if((X(i,j)>=lval) && (X(i,j)<=rval))
            Y(i,j)=X(i,j);
        end
    end
end
return