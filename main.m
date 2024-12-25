n = 47;
m = 2;
level = 16;
snr = 20;
fd = 2000;
nd = 3;
%signal = generateFlow(n);
%figure(),stem(signal), title('Generated signal')
%modulation
% signal_qpsk = qpsk(signal);
% figure(),subplot(2,1,1),title('QPSK'),stem(signal_qpsk.I),ylabel('I'),subplot(2,1,2),stem(signal_qpsk.Q),ylabel('Q'), hold on
% signal_psk8 = psk8(signal);
% figure(),subplot(2,1,1),title('8PSK'),stem(signal_psk8.I),ylabel('I'),subplot(2,1,2),stem(signal_psk8.Q),ylabel('Q'), hold on
% signal_bpsk = bpsk(signal);
% figure(),subplot(2,1,1),title('BPSK'),stem(signal_psk8.I),ylabel('I'),subplot(2,1,2),stem(signal_psk8.Q),ylabel('Q'), hold on

%etalon
I_qpsk_etalon = floor((signal_qpsk.I/max(awgn(signal_qpsk.I,snr)))*(2.^(level - 1) - 1));
Q_qpsk_etalon = floor((signal_qpsk.Q/max(awgn(signal_qpsk.Q,snr)))*(2.^(level - 1) - 1));
I_psk8_etalon = floor((signal_psk8.I/max(awgn(signal_psk8.I,snr)))*(2.^(level - 1) - 1));
Q_qpsk8_etalon = floor((signal_psk8.Q/max(awgn(signal_psk8.Q,snr)))*(2.^(level - 1) - 1));

%etalon exp
A0_qpsk = sqrt(I_qpsk_etalon.^2 + Q_qpsk_etalon.^2);
phi0_qpsk = atan(Q_qpsk_etalon./I_qpsk_etalon);

%tuned
signal_qpsk_tuned = freqtune(fd,length(phi0_qpsk));
Ik_qpsk = signal_qpsk_tuned.I;
Qk_qpsk = signal_qpsk_tuned.Q;
Ik_qpsk_norm = floor((Ik_qpsk/max(awgn(Ik_qpsk,snr)))*(2.^(level - 1) - 1));
Qk_qpsk_norm = floor((Qk_qpsk/max(awgn(Qk_qpsk,snr)))*(2.^(level - 1) - 1));
Ak_qpsk = sqrt(Ik_qpsk_norm.^2 + Qk_qpsk_norm.^2);
phik_qpsk = atan(Qk_qpsk_norm./Ik_qpsk_norm);

%dopler
Id_qpsk = A0_qpsk.*cos(phik_qpsk + 2*pi*phi0_qpsk);
Qd_qpsk = A0_qpsk.*sin(phik_qpsk + 2*pi*phi0_qpsk);
%figure(),plot(Id_qpsk,Qd_qpsk,'g*'),hold on

%awgn
I_qpsk_awgn = awgn(signal_qpsk.I,snr);
Q_qpsk_awgn = awgn(signal_qpsk.Q,snr);
I_psk8_awgn = awgn(signal_psk8.I,snr);
Q_psk8_awgn = awgn(signal_psk8.Q,snr);

%discretize
I_qpsk_discrt = overdiscretize(I_qpsk_awgn,m);
Q_qpsk_discrt = overdiscretize(Q_qpsk_awgn,m);
I_psk8_discrt = overdiscretize(I_psk8_awgn,m);
Q_psk8_discrt = overdiscretize(Q_psk8_awgn,m);

%quant
I_qpsk_qvt = quvnt(I_qpsk_discrt,level);
Q_qpsk_qvt = quvnt(Q_qpsk_discrt,level);
I_psk8_qvt = quvnt(I_psk8_discrt,level);
Q_psk8_qvt = quvnt(Q_psk8_discrt,level);

%graphics

figure(),plot(I_qpsk_qvt,Q_qpsk_qvt, 'bx',I_qpsk_etalon,Q_qpsk_etalon, 'ro',Id_qpsk,Qd_qpsk,'g*'),title('QPSK'), xlabel('I'), ylabel('Q'),grid on, grid minor
figure(),plot(I_psk8_qvt,Q_psk8_qvt, 'bx',I_psk8_etalon,Q_qpsk8_etalon, 'ro'),title('8PSK'), xlabel('I'), ylabel('Q'),grid on,grid minor

% figure(),plot(I_qpsk_awgn,Q_qpsk_awgn, 'rx'),title('noised QPSK'), xlabel('I'), ylabel('Q'),grid on
% figure(),plot(I_psk8_awgn,Q_psk8_awgn, 'rx'),title('noised 8PSK'), xlabel('I'), ylabel('Q'),grid on



