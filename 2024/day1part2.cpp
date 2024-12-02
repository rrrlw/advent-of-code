#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <map>

using namespace std;

long long similarityScore(vector<long long> &first, vector<long long> &second)
{
    // use map STL for quicker search
    map<long long, long long> tracker, freq;
    
    // only add elements to map that are in first vector
    for (int i = 0; i < first.size(); i++)
    {
        tracker[first[i]] = 0;

        if (freq.contains(first[i]))
            freq[first[i]]++;
        else
            freq[first[i]] = 1;
    }

    // calculate similarity score using second vector
    for (int i = 0; i < second.size(); i++)
        if (freq.contains(second[i]))
            tracker[second[i]] += second[i] * freq[second[i]];

    // calculate sum of score in map & return
    long long counter = 0;

    for (auto const& [key, val] : tracker)
        counter += val;

    return counter;
}

int main()
{
    // setup file input
    ifstream in("day1.in");

    // input data
    long long temp1, temp2;
    vector<long long> first, second;
    while (!in.eof())
    {
        in >> temp1 >> temp2;
        if (in.eof()) break;

        first.push_back(temp1);
        second.push_back(temp2);
    }

    // calculate similarity score
    long long counter = similarityScore(first, second);

    // output total distance
    cout << counter << endl;

    // end
    in.close();
    return 0;
}