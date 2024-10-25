#include "waver.h"


void WaveConventer::Waver::conventerWav(int dt, std::string filename, std::vector<double> &sig){
    std::ofstream outs(filename,std::ios::binary);

    //params
    int byterate = (int)Fs*(bitdepth / 8);
    int blockallign = (int) (bitdepth / 8);
    int numberOfSamples = (int)Fs*dt;

    //Header chunk
    outs << "RIFF"; //riff header
    outs << "----"; //unknown size of data
    outs << "WAVE";

    //Format chunk
    outs << "fmt ";                     //4th chacter is the space
    writeToFile(outs,16,4);             //size
    writeToFile(outs,1,2);              //compression code
    writeToFile(outs,1,2);              //number of channels
    writeToFile(outs,Fs,4);             //sample rate
    writeToFile(outs,byterate,4);       //byte rate
    writeToFile(outs,blockallign,2);    //block allign
    writeToFile(outs,bitdepth,2);       //bit depth

    //Data chunk
    outs << "data";
    outs << "----"; //unknown size of data
    int prepos = outs.tellp();

    for(int i = 0; i < numberOfSamples; i++){
       int intsample = static_cast<int>(sig[i]);
       writeToFile(outs,intsample,4);
    }

    int postpos = outs.tellp();

    outs.seekp(prepos - 4);
    writeToFile(outs,postpos - prepos, 4);

    outs.seekp(4,std::ios::beg); //size of written
    writeToFile(outs,postpos - 8, 4);


    outs.close();
}

void WaveConventer::Waver:: writeToFile(std::ofstream &outs, int value, int size){
 outs.write(reinterpret_cast<const char*>(&value),size);
}



