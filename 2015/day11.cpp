#include <iostream>

using namespace std;

// fixed password length (problem specification)
const int PASS_LEN = 8;

// find next password sequence (in-place char array)
void increment(char* currPass)
{
    bool done = false;
    int index = PASS_LEN - 1;
    
    while (!done)
    {
        switch (currPass[index])
        {
            case 'z':
                currPass[index] = 'a';
                index--;
                break;

            default:
                currPass[index]++;
                done = true;
                break;
        }
    }
}

// check if a given password is valid (i.e., meets all 3 conditions)
bool validPass(char* currPass)
{
    // check condition 1
    bool straight = false;
    for (int i = 2; i < PASS_LEN; i++)
        if (currPass[i] == currPass[i-1] + 1 &&
            currPass[i] == currPass[i-2] + 2)
        {
            straight = true;
            break;
        }
    if (!straight)
        return false;

    // check condition 2
    for (int i = 0; i < PASS_LEN; i++)
        switch (currPass[i])
        {
            case 'i':
            case 'o':
            case 'l':
                return false;
        }

    // check condition 3
    char firstOverlap;
    int numOverlaps = 0;
    for (int i = 1; i < PASS_LEN && numOverlaps < 2; i++)
    {
        if (currPass[i] == currPass[i-1])
        {
            // first overlap
            if (numOverlaps == 0)
            {
                numOverlaps++;
                firstOverlap = currPass[i];
            }

            // second overlap
            else
            {
                // only count it if it's a different character overlap
                // not combined with outer condition for code clarity
                if (currPass[i] != firstOverlap)
                    numOverlaps++;
            }
        }
    }
    if (numOverlaps < 2)
        return false;

    // passed all conditions
    return true;
}

int main()
{
    // input
    char inputPass[PASS_LEN] = {'h', 'x', 'b', 'x', 'w', 'x', 'b', 'a'};

    // process: part 1
    char currPass[PASS_LEN];
    for (int i = 0; i < PASS_LEN; i++)
        currPass[i] = inputPass[i];

    do {
        increment(currPass);
    } while (!validPass(currPass));

    // output: part 1
    cout << "Part 1: ";
    for (int i = 0; i < PASS_LEN; i++)
        cout << currPass[i];
    cout << endl;

    // process: part 2
    do {
        increment(currPass);
    } while (!validPass(currPass));

    // output: part 2
    cout << "Part 2: ";
    for (int i = 0; i < PASS_LEN; i++)
        cout << currPass[i];
    cout << endl;

    // clean up and exit
    return 0;
}