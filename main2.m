n = 23;
m = 2;
level = 16;
snr = 0:0.2:25;
rep = 10000;
fd = 2000;
nd = 3;
signal = generateFlow(n);

for i = 1:length(snr)
ber_theor(i) =  qfunc(sqrt(2*snr(i)));
end
figure()
semilogy(snr,ber_theor,'r'), title('BER'),grid on , grid minor
hold on 

%modulation
signal_qpsk = qpsk(signal);
%figure(),subplot(2,1,1),title('QPSK'),stem(signal_qpsk.I),ylabel('I'),subplot(2,1,2),stem(signal_qpsk.Q),ylabel('Q'), hold on
signal_psk8 = psk8(signal);
%figure(),subplot(2,1,1),title('8PSK'),stem(signal_qpsk.I),ylabel('I'),subplot(2,1,2),stem(signal_qpsk.Q),ylabel('Q'), hold on
signal_bpsk = bpsk(signal);
%figure(),subplot(2,1,1),title('BPSK'),stem(signal_qpsk.I),ylabel('I'),subplot(2,1,2),stem(signal_qpsk.Q),ylabel('Q'), hold on


%awgn
I_qpsk_awgn = add_noise(signal_qpsk.I,snr);
Q_qpsk_awgn = add_noise(signal_qpsk.Q,snr);
I_psk8_awgn = add_noise(signal_psk8.I,snr);
Q_psk8_awgn = add_noise(signal_psk8.Q,snr);
I_bpsk_awgn = add_noise(signal_bpsk.I,snr);
Q_bpsk_awgn = add_noise(signal_bpsk.Q,snr);

%eval theor ber
ber_I_qpsk = eval_ber(signal_qpsk.I,I_qpsk_awgn,snr,rep);

%graphics

%figure(),plot(I_qpsk_awgn,Q_qpsk_awgn, 'bx',signal_qpsk.I,signal_qpsk.Q,'ro'),title('QPSK'), xlabel('I'), ylabel('Q'),grid on, grid minor
%figure(),plot(I_psk8_qvt,Q_psk8_qvt,'bx',signal_psk8.I,signal_psk8.Q,'ro'),title('8PSK'), xlabel('I'), ylabel('Q'),grid on,grid minor
%figure(),plot(I_bpsk_awgn,Q_bpsk_awgn,'bx',signal_bpsk.I,signal_bpsk.Q,'ro'),title('BPSK'), xlabel('I'), ylabel('Q'),grid on, grid minor

%figure(),plot(I_qpsk_awgn,Q_qpsk_awgn, 'rx'),title('noised QPSK'), xlabel('I'), ylabel('Q'),grid on
%figure(),plot(I_psk8_awgn,Q_psk8_awgn, 'rx'),title('noised 8PSK'), xlabel('I'), ylabel('Q'),grid on



