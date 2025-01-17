#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

vector<int> values;     // provided as input
const int SUM = 150;
int **subsets;          // fill in w/ DP processing

bool *included;
int comboCounter;
const int FINAL_DEPTH = 4; // simple manual calculation for part 2

// search for all combos of size FINAL_DEPTH that add up to SUM
void dfsCombo(int depth, int lastIndex)
{
    // leaf node: check if combo adds up to SUM
    if (depth == 4)
    {
        int counter = 0;
        for (int i = 0; i < values.size(); i++)
            if (included[i])
                counter += values[i];

        if (counter == SUM)
            comboCounter++;

        return ;
    }

    // try all the remaining combos
    for (int i = lastIndex + 1; i < values.size(); i++)
    {
        if (included[i]) continue;

        included[i] = true;
        dfsCombo(depth + 1, i);
        included[i] = false;
    }
}

int main()
{
    // process input
    ifstream in("day17.in");
    int temp;
    while (!in.eof())
    {
        in >> temp;
        if (in.eof()) break;

        values.push_back(temp);
    }

    // calculate number of subset sums (dynamic programming, not space optimized)
    subsets = new int*[values.size() + 1];
    for (int i = 0; i <= values.size(); i++)
    {
        subsets[i] = new int[SUM + 1];
        for (int j = 0; j <= SUM; j++)
            subsets[i][j] = 0;
    }
    
    // base case: one way to get a sum of 0 (empty set)
    subsets[0][0] = 1;
    int currVal;
    for (int i = 1; i <= values.size(); i++)
    {
        currVal = values[i - 1];
        for (int j = 0; j <= SUM; j++)
        {

            // don't use element i
            subsets[i][j] = subsets[i - 1][j];

            // use element i
            if (j >= currVal)
                subsets[i][j] += subsets[i - 1][j - currVal];
        }
    }

    // output: part 1
    cout << "Part 1: " << subsets[values.size()][SUM] << endl;

    // part 2: took a couple min to manually figure out 4 are needed
    // try all combinations of 4 and count how many add up to 150
    included = new bool[values.size()];
    comboCounter = 0;
    dfsCombo(0, -1);

    // output: part 2
    cout << "Part 2: " << comboCounter << endl;

    // close out and exit
    for (int i = 0; i <= values.size(); i++)
        delete[] subsets[i];
    delete[] subsets;
    delete[] included;
    values.clear();
    return 0;
}