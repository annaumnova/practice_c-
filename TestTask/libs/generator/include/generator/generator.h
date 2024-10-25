#ifndef GENERATOR_H
#define GENERATOR_H

#include <string>
#include <cmath>
#include <vector>
#include <iostream>
#include <string.h>
#include <cmath>
#include <stdio.h>
#include <iterator>
#include <fstream>
#include <random>
#define Fs  44100
#define PI  3.14

namespace Generator {

class SignalGenerator{
private:
    double omega;
    std::vector<double> oms;
    double T;
    double ampl;
public:
    SignalGenerator(double om, double t, double amplt);
    SignalGenerator(std::vector<double> om, double t, double amplt);
    std::vector<double> signal;
    std::vector<double> signalFunc(double omega, double T, double ampl);
    std::vector<double> multisignalFunc(std::vector<double> om, double T, double ampl);
    std::vector<double> addNoise(double mean, double stddev);
    void sigToFile(std::vector<double> sig, std::string filename);
    void printSignal(std::vector<double> sig);
};

}

#endif
