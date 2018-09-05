 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These codes are written by Prof. Jayanta Mukherjee, IIT Kharagpur during 2008 to  2011. The codes may be used freely for 
% any academic and research purpose with appropriate acknowledgment. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y=delta_LRT_extended_neighborhood(X,delta,m,n)
% Computes delta local rank transform of an gray scale image X
%in a (2m+1)x(2n+1) neighborhood

[height width depth]=size(X);

Y=zeros(height,width);

for i=1:height
    for j=1:width
        rank_count=0;
        for k=-m:m
            for l=-n:n
                if(((i+k)>0) && ((i+k)<=height))
                    if(((j+l)>0) && ((j+l)<=width))
                        if(X(i+k,j+l)+delta <X(i,j))
                            rank_count=rank_count+1;
                        end;
                    end;
                end;
            end;
        end;
         Y(i,j)=rank_count;
    end;
end;
return;
