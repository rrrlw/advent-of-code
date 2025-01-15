#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

const int NUM_PPL = 9;
int change[NUM_PPL][NUM_PPL] = {0};
map<string,int>names;

int main()
{
    // input
    ifstream in("temp.in");

    string from, to, temp, dir;
    int tempChange, currFrom, currTo, counterNames = 0;
    while (!in.eof())
    {
        in >> from >> temp >> dir >> tempChange >> temp >> temp >> temp >> temp >> temp >> temp >> to;
        if (in.eof()) break;

        to = to.substr(0, to.length() - 1); // remove period at end of sentence
        if (dir == "lose")
            tempChange *= -1;

        if (!names.contains(from))
            names[from] = counterNames++;

        if (!names.contains(to))
            names[to] = counterNames++;

        change[names[from]][names[to]] = tempChange;
    }
    names["Narrator"] = counterNames++;

    // add names to vector to test all permutations (inefficient but works on the small sample size)
    vector<string>tests;
    for (auto const& [key, val] : names)
        tests.push_back(key);

    int totalChange, maxChange = 0;
    do {
        totalChange = 0;
        for (int i = 0; i < tests.size(); i++)
        {
            if (i == 0)
            {
                totalChange += change[names[tests[i]]][names[tests[tests.size() - 1]]];
                totalChange += change[names[tests[i]]][names[tests[i+1]]];
            }
            else if (i == tests.size() - 1)
            {
                totalChange += change[names[tests[i]]][names[tests[i-1]]];
                totalChange += change[names[tests[i]]][names[tests[0]]];
            }
            else
            {
                totalChange += change[names[tests[i]]][names[tests[i-1]]];
                totalChange += change[names[tests[i]]][names[tests[i+1]]];
            }
        }

        if (maxChange < totalChange)
            maxChange = totalChange;
    } while (next_permutation(tests.begin(), tests.end()));

    // print max value
    cout << maxChange << endl;

    // clean up and exit
    names.clear();
    return 0;
}