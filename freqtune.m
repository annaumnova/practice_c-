function y = freqtune(Fdop,N)
for k = 1:N
    I(k) = cos(2*pi*Fdop*k);
    Q(k) = sin(2*pi*Fdop*k);
end
y = struct('I',I,'Q',Q);
end