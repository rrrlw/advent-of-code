#include <iostream>
#include <fstream>
#include <string>

using namespace std;

const int GRID_LEN = 100,
          NUM_NEIGHBORS = 8,
          NUM_STEPS = 100;
const int nX[NUM_NEIGHBORS] = {0, 1, 1, 1, 0, -1, -1, -1},
          nY[NUM_NEIGHBORS] = {1, 1, 0, -1, -1, -1, 0, 1};
bool grid[GRID_LEN][GRID_LEN];
bool current[GRID_LEN][GRID_LEN], prior[GRID_LEN][GRID_LEN];

int lightsOn()
{
    int counter = 0;

    for (int i = 0; i < GRID_LEN; i++)
        for (int j = 0; j < GRID_LEN; j++)
            counter += current[i][j];

    return counter;
}

bool statePrior(int r, int c)
{
    if (r < 0 || r >= GRID_LEN || c < 0 || c >= GRID_LEN) return false;
    return prior[r][c];
}

int numNeighborsPrior(int r, int c)
{
    int counter = 0;

    for (int i = 0; i < NUM_NEIGHBORS; i++)
        counter += statePrior(r + nY[i], c + nX[i]);

    return counter;
}

// go through a single step on the prior grid
void iterate()
{
    // set previous to last step
    for (int i = 0; i < GRID_LEN; i++)
        for (int j = 0; j < GRID_LEN; j++)
            prior[i][j] = current[i][j];

    // calculate current based on provided automaton rules
    int tempN;
    for (int i = 0; i < GRID_LEN; i++)
        for (int j = 0; j < GRID_LEN; j++)
            if (prior[i][j])
            {
                tempN = numNeighborsPrior(i, j);
                current[i][j] = (tempN == 2 || tempN == 3) ? true : false;
            }
            else
                current[i][j] = (numNeighborsPrior(i, j) == 3) ? true : false;
}

int main()
{
    // input
    ifstream in("day18.in");
    string temp;
    for (int i = 0; i < GRID_LEN; i++)
    {
        getline(in, temp);
        for (int j = 0; j < GRID_LEN; j++)
            current[i][j] = grid[i][j] = (temp[j] == '#') ? true : false;
    }

    // part 1: iterate thru normal cellular automaton
    for (int step = 0; step < NUM_STEPS; step++)
        iterate();

    // output: part 1
    cout << "Part 1: " << lightsOn() << endl;

    // reset for part 2
    for (int i = 0; i < GRID_LEN; i++)
        for (int j = 0; j < GRID_LEN; j++)
            current[i][j] = grid[i][j];
    current[0][0] = current[0][GRID_LEN - 1] = current[GRID_LEN - 1][0] = current[GRID_LEN - 1][GRID_LEN - 1] = true;

    // part 2: iterate thru cellular automaton with corner lights all fixed at 'on' state
    for (int step = 0; step < NUM_STEPS; step++)
    {
        iterate();
        current[0][0] = current[0][GRID_LEN - 1] = current[GRID_LEN - 1][0] = current[GRID_LEN - 1][GRID_LEN - 1] = true;
    }

    // output: part 2
    cout << "Part 2: " << lightsOn() << endl;

    // close out and exit
    return 0;
}
