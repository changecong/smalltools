#include <fstream>  // ofstream
#include <sys/time.h>  // gettimeofday

// define macros
#define TIME_DURATION timeuse

// initialize
#define TIME_INIT struct timeval start, end;  \
    unsigned long timeuse; \
    std::ofstream myFile;

// get start time
#define TIME_START gettimeofday(&start, NULL);
// get end time
#define TIME_END gettimeofday(&end, NULL); \
    timeuse = 1000000 * ( end.tv_sec - start.tv_sec ) + end.tv_usec - start.tv_usec; // get the microseconds 

// write to file
// nzmax
#define TIME_WRITE_TO_FILE(filename, arg) myFile.open(filename, ios::app);  \
    myFile << "Whatever you want to put here!";
    myFile.close();

#endif
