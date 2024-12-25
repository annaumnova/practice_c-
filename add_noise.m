function y = ad_noise(signal,snr)
%signal_noised = zeros(1,length(signal));
for j = 1:length(snr)
    for i = 1:length(signal)
    signal_noised(j,i) = awgn(signal(i),snr(j));
    end
end
y = signal_noised;
end