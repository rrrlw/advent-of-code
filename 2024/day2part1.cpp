#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include <algorithm>

using namespace std;

// check if a report is safe
bool safeReport(int *values, int len)
{
    // edge cases, just in case
    if (len <= 1) return true;
    if (values[0] == values[1]) return false;

    // loop through and check safety (check first separately to establish direction)
    int currDiff = abs(values[1] - values[0]);
    bool currDirection,
         direction = values[1] > values[0];             // check direction
    if (currDiff < 1 || currDiff > 3) return false;     // check values

    for (int i = 2; i < len; i++)
    {
        // check direction
        currDirection = values[i] > values[i-1];
        if (currDirection != direction) return false;

        // check values
        currDiff = abs(values[i] - values[i-1]);
        if (currDiff < 1 || currDiff > 3) return false;
    }

    // passed safety checks
    return true;
}

int main()
{
    // setup
    ifstream in("day2.in");
    int *vals;
    int i,
        counter = 0,
        numLevels,
        currVal,
        counterLines = 0;
    string currLine;
    stringstream eval;

    // eval line-by-line
    getline(in, currLine);
    while (!in.eof())
    {
        // input single report
        numLevels = count(currLine.begin(), currLine.end(), ' ') + 1;
        vals = new int[numLevels];
        eval = stringstream(currLine);
        i = 0;
        while (eval >> currVal)
            vals[i++] = currVal;

        // check if done
        getline(in, currLine);
        if (in.eof()) break;

        // process single report
        if (safeReport(vals, numLevels)) counter++;

        // clean up
        delete[] vals;
    }

    // output
    cout << counter << endl;

    // close out
    in.close();
    return 0;
}