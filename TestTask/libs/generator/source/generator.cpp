#include "generator.h"

//constructor
Generator::SignalGenerator::SignalGenerator(double om, double t, double amplt){
    omega = om;
    T = t;
    ampl = amplt;
}

Generator::SignalGenerator::SignalGenerator(std::vector<double> om, double t, double amplt){
    oms = om;
    T = t;
    ampl = amplt;
}

//generate harmonic signal
std::vector<double> Generator::SignalGenerator::signalFunc(double omega, double T, double ampl){
    double k = 0; double step = 1*pow(Fs,-1);
    for(; k < T;  k+=step){
        double u = ampl*cos(2*PI*omega*k);
        signal.push_back(u);
    }
    return signal;
}

//generate multisignal like sequence of notes with different frequencies
std::vector<double> Generator::SignalGenerator::
    multisignalFunc(std::vector<double> om, double T, double ampl){

    int repeats = T/om.size(); //period of 1 note
    double k = 0;
    double step = 1*pow(Fs,-1);
    //double u = 0;
    for(int j = 0; j < T; j+=T){
        for(int i = 0; i < (int)om.size();i++){
            for(; k < repeats;  k+=step){
                double u = ampl*cos(2*PI*om[i]*k);
                signal.push_back(u);
            }
            k = 0;
        }
    }
    return signal;
}

//add noise to generated signal
std::vector<double> Generator::SignalGenerator::addNoise(double mean, double stddev){
    std::default_random_engine generator;
    std::normal_distribution<double> dist(mean, stddev);
    std::vector<double> sig;
     // Add Gaussian noise
    for (auto &x: signal){
          x = x + dist(generator);
          sig.push_back(x);
    }
    for(int i = 0; i < (int)sig.size(); i++)
        signal[i] = signal[i] + sig[i];

    return signal ;
}

//write values to .txt file
void Generator::SignalGenerator::sigToFile(std::vector<double> sig, std::string filename){
    std::ofstream output(filename);
    std::ostream_iterator<double> outiterator(output, "\n");
    std::copy(sig.begin(), sig.end(), outiterator);
}

//print signal to console
void Generator::SignalGenerator::printSignal(std::vector<double> sig){
    for (size_t i = 0; i < sig.size(); ++i) {
        std::cout << "s[" << i << "] = " << sig[i] << std::endl;
    }
}
