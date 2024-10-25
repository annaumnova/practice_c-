#include "generator/waver.h"

int main()
{
    //names of generated wav
    std::string filename1 = "D:/signal.wav";
    std::string filename2 = "D:/multisignal.wav";
    //std::string filename3 = "D:/noised_signal.wav";
    //std::string filename4 = "D:/noised_multisignal.wav";


    //parameters of harmonic signal
    double  dt, omega, ampl;
    std::cout << "Enter frecquency (omega): ";
    std::cin >> omega;
    std::cout << "Enter T (period): ";
    std::cin >> dt;
    std::cout << "Enter A (amplitude): ";
    std::cin >> ampl;

    //c,d,e
    std::vector<double> oms {2903.04,2349.28,2637.04,2903.04};

    //generate signal
    Generator::SignalGenerator hs(omega,dt,ampl);
    std::vector <double> f = hs.signalFunc(omega,dt,ampl);

    //generate multisignal
    Generator::SignalGenerator mhs(oms,dt,ampl);
    std::vector <double> mf = mhs.multisignalFunc(oms,dt,ampl);

    //hs.printSignal(f);

    //convert to wav
    WaveConventer::Waver ws;
    ws.conventerWav(dt,filename1,f);
    ws.conventerWav(dt,filename2,mf);

    //add gaussian noise, then write to wav
    //f = hs.addNoise(0.0,0.1);
    //ws.conventerWav(dt,filename3,f);

    //hs.printSignal(f);


    return 0;
}
