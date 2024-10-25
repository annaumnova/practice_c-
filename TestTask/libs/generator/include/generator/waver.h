#ifndef WAVER_H
#define WAVER_H

#include <string>
#include <cmath>
#include <vector>
#include <iostream>
#include <string.h>
#include <cmath>
#include <stdio.h>
#include <iterator>
#include <fstream>
#include <cstdint> //int16_t, int32_t
#include "generator/generator.h"

#define mono 1
#define stereo 2
#define bitdepth 16

namespace WaveConventer{

class Waver{
private:
    struct WavHeader{                   //44 bytes
        char chunkId[4];                //symbols "RIFF", [0..3]
        unsigned  long chunkSize;        //[4..7]
        char format[4];                 //symbols "WAVE", [8..11]
        char subchunk1Id[4];            //symbols "fmt"
        unsigned long subchunk1Size;    //[16..19], 16 for PCM
        unsigned short audioformat;     //[20..21], 2 bytes
        unsigned short numChannels;     //[22..23], 2 bytes
        unsigned long sampleRate;       //[24..27], 4 bytes
        unsigned long byteRate;         //[28..31], 4 bytes
        unsigned short blockAlign;      //[32..33]
        unsigned short bitsPerSample;   //[34..35], number of bits per sample (audio bit depth)
        char subchunk2Id[4];            //symbols "data", [36..39]
        unsigned long subchunk2Size;    //number of bytes in data area, [40..43]
        //data; //wav data, [44..]
    }header;

public:
    std::ofstream audiofile;
    void conventerWav(int dt, std::string filename, std::vector<double> &sig);
    void writeToFile(std::ofstream &outs, int value, int size);
};


}

#endif // WAVER_H
