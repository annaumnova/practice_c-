function y = psk8(flow)
Lf = length(flow);

if(mod(Lf,3) == 1)
    flow(end+2) = 0;
   
end
if(mod(Lf,3) == 2)
    flow(end+1) = 0;
end  

b = reshape(flow,3,[]);
Lb = size(b,2);

%components
I = zeros(1,Lb);
Q = zeros(1,Lb);

for i = 1:Lb
  comm = b(:,i)';
    if(comm == [0 0 0])
        I(i) = sqrt(2)/2; Q(i) = sqrt(2)/2;
    end
    if(comm == [0 0 1]) %001
        I(i) = 1; Q(i) = 0; 
    end
     if(comm == [0 1 0]) %010
        I(i) = -1; Q(i) = 0; 
    end
    if(comm == [0 1 1]) %011
        I(i) = -sqrt(2)/2; Q(i) = -sqrt(2)/2;
    end
     if(comm == [1 0 0]) %100
         Q(i) = -1; I(i) = 0;
    end
    if(comm == [1 0 1]) %101
        I(i) = sqrt(2)/2; Q(i) = -sqrt(2)/2; 
    end
       if(comm == [1 1 0]) %110
        I(i) = -sqrt(2)/2; Q(i) = sqrt(2)/2; 
    end
        if(comm == [1 1 1]) %111
        I(i) = 0; Q(i) = -1; 
    end
end
y = struct('I',I,'Q',Q,'flow',flow);

%graphics
% plot(y.I,y.Q, 'ro')
% title('8PSK'), xlabel('I'), ylabel('Q')
% axis([-2 2 -2 2])
% %xlim([-2 2]),
% %ylim([-2 2])
% grid on

end