#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include <algorithm>
#include <vector>

using namespace std;

// check if a report is safe
bool safeReport(vector<int> values)
{
    int len = values.size();

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

// inefficient but quicker to code than ignoring elements when creating second
// array and swapping out two values in each iteration
bool dampenedSafeReport(vector<int> values)
{
    // if any removal works, report is safe
    int temp;
    for (int i = 0; i < values.size(); i++)
    {
        // remove curr
        temp = values[i];
        values.erase(values.begin() + i);

        // check safety w/o it
        if (safeReport(values)) return true;

        // add back at the right position
        values.insert(values.begin() + i, temp);
    }

    // no single removal was sufficient --> report is unsafe
    return false;
}

int main()
{
    // setup
    ifstream in("day2.in");
    vector<int> vals;
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
        vals.reserve(numLevels);
        eval = stringstream(currLine);
        i = 0;
        while (eval >> currVal)
            vals.push_back(currVal);

        // check if done
        getline(in, currLine);
        if (in.eof()) break;

        // process single report
        if (dampenedSafeReport(vals)) counter++;

        // clean up
        vals.clear();
    }

    // output
    cout << counter << endl;

    // close out
    in.close();
    return 0;
}