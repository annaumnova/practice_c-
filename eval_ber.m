function y = eval_ber(signal,signal_noised,snr,rep)
BER_SNR = [];
SNR_g = [];
%rep = 10000;
Nbits = 1000;
data = round(rand(Nbits,1));
for m = 1:length(snr)       
    ber_sum = 0;
    for v = 1:rep
        data_QPSK = step(signal, signal_noised(m)');
        [err BER] = biterr(data_QPSK,data);    % подсчет BER  
        ber_sum = ber_sum+BER;                 % накопление BER для всех прогонов для данного SNR
    end
    BER = ber_sum./rep;         % BER для данного SNR
    BER_SNR = [BER_SNR BER];    % накопление массива BER
    SNR_g = [SNR_g snr(m)];        % накопление массива SNR
end
y = struct('ber',BER,'snr',SNR_g);

figure()
semilogy(SNR_g, BER_SNR)
title ('Зависимость BER(SNR)')
hold on
end
 
