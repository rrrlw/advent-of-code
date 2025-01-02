#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

// inefficient functions, but whatever
vector<short> nextSeq(vector<short> current)
{
    vector<short> answer;

    // special case of single digit sequence
    if (current.size() == 1)
    {
        answer.push_back(1);
        answer.push_back(current[0]);
        return answer;
    }

    int currFreq = 1, currVal = current[0];
    for (int i = 1; i < current.size(); i++)
    {
        // switch
        if (current[i] != current[i-1])
        {
            // update answer sequence
            answer.push_back(currFreq);
            answer.push_back(currVal);

            // reset tracker variables
            currFreq = 1;
            currVal = current[i];
        }

        // not a switch
        else
            currFreq++;
    }

    // final addition
    answer.push_back(currFreq);
    answer.push_back(currVal);

    return answer;
}

int nextSeqLen(vector<short> current)
{
    int numSwitches = 1;
    for (int i = 1; i < current.size(); i++)
        if (current[i] != current[i-1])
            numSwitches++;

    return numSwitches * 2;
}

int main()
{
    // input
    const string INPUT_VAL = "1113122113";
    const int NUM_ITER_1 = 40,
              NUM_ITER_2 = 50;

    vector<short> inputSeq;
    for (int i = 0; i < INPUT_VAL.length(); i++)
        inputSeq.push_back(INPUT_VAL[i] - '0');

    cout << "DONE WITH INPUT" << endl;

    // process: part 1
    vector<short> curr(inputSeq);
    for (int i = 0; i < NUM_ITER_1 - 1; i++)
        curr = nextSeq(curr);

    // output: part 1
    cout << "Part 1: " << nextSeqLen(curr) << endl;

    // process: part 2
    for (int i = 0; i < NUM_ITER_2 - NUM_ITER_1; i++)
        curr = nextSeq(curr);

    // output: part 2
    cout << "Part 2: " << nextSeqLen(curr) << endl;

    // clean up and exit
    return 0;
}