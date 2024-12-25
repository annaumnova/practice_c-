function b = overdiscretize(flow,m)
% Fs = 44100;
% Fsymb = 22050;

%m = 2.0;
%s = [1 1 -1 -1 -1];
n = length(flow);
Mn = floor(m*n);
k = 1;

for j = 1:Mn
  if floor(j/m) <= k
      b(j) = flow(k);
  else 
    k = k + 1;
    b(j) = flow(k);
  end
end
end

