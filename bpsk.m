function y  = bpsk(flow)
if (mod(length(flow),2) ~= 0)
    flow(end+1) = 0;
end
%length(flow)
b = reshape(flow,2,[]);
Lb = length(b);

%components
I = zeros(1,Lb);
Q = zeros(1,Lb);

for i = 1:Lb
  comm = b(:,i)';
    if(comm == [0 0])
        I(i) = 1; %Q = 0;
    end
    if(comm == [0 1]) %01
        Q(i) = 0; I(i) = 1;
    end
    if(comm == [1 1]) %11
        I(i) = -1; Q(i) = 0;
    end
    if(comm == [1 0]) %10
         Q(i) = 0;  I(i) = -1;
    end
end
y = struct('I',I,'Q',Q);

%graphics
plot(y.I,y.Q, 'ro')
title('BPSK'), xlabel('I'), ylabel('Q')
xlim([-2 2])
ylim([-2 2])
grid on
end