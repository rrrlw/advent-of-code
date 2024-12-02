#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

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

    // sort & calculate difference
    sort(first.begin(), first.end());
    sort(second.begin(), second.end());
    long long counter = 0;
    for (int i = 0; i < first.size() && i < second.size(); i++)
    {
        counter += abs(first[i] - second[i]);
        // cout << first[i] << " " << second[i] << " " << counter << '\n';
    }

    // output total distance
    cout << counter << endl;
    // cout << first.size() << " " << second.size() << endl;

    // end
    in.close();
    return 0;
}