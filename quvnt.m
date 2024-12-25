function y = quvnt(flow,M)
sm = max(abs(flow));
y = floor((flow./sm)*(2.^(M-1)-1));
end