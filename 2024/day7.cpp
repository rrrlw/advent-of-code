#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <sstream>

using namespace std;

// global vars
vector<unsigned long long> operands;
vector<char> operators;
unsigned long long output, counter1, counter2;

// get value of current expression (single check in DFS)
unsigned long long evaluate(bool part2)
{
    unsigned long long value = operands[0], temp;

    for (int i = 1; i < operands.size(); i++)
        switch (operators[i-1])
        {
            case '+':
                value += operands[i];
                break;

            case '*':
                value *= operands[i];
                break;

            // operator is only valid for part 2
            case '|':
                if (!part2) break;

                temp = operands[i];
                while (temp > 0)
                {
                    temp /= 10;
                    value *= 10;
                }
                value += operands[i];
                break;

            default:
                break;
        }

    return value;
}

// there definitely exists a faster way to do this (single DFS for both parts w/ diff evaluation at end)
// but will take time to implement from starting point of part 1 solution and solution still runs quickly
bool dfsSearch(int index, bool part2)
{
    // leaf node
    if (index == operators.size())
    {
        if (evaluate(part2) == output) return true;
        else return false;
    }

    // branch deeper (try both operators)
    bool answer = false;
    operators[index] = '+';
    answer |= dfsSearch(index + 1, part2);
    operators[index] = '*';
    answer |= dfsSearch(index + 1, part2);
    operators[index] = '|';
    answer |= dfsSearch(index + 1, part2);

    // could not find a combo of operators that worked
    return answer;
}

int main()
{
    // setup
    ifstream in("day7.in");
    counter1 = counter2 = 0;

    // read in cases
    string temp;
    unsigned long long tempNum;
    while (!in.eof())
    {
        // setup
        operands.clear();
        operators.clear();

        // input
        getline(in, temp);
        if (in.eof()) break;
        temp.erase(temp.find(':'), 1);

        stringstream ss(temp);
        ss >> output;
        while (ss >> tempNum) operands.push_back(tempNum);

        // process
        for (int i = 0; i < operands.size() - 1; i++) operators.push_back(' ');

        if (dfsSearch(0, false)) counter1 += output;
        if (dfsSearch(0, true))  counter2 += output;
    }

    // output
    cout << "Part 1: " << counter1 << "\nPart 2: " << counter2 << endl;

    // close out
    in.close();
    return 0;
}
