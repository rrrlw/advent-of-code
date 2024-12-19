#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <set>

using namespace std;

// global variables
int **grid;
int **partOneGrid;
int numRows, numCols,
    nextX, nextY,
    origX, origY,
    tempXDelta, tempYDelta,
    currRow, currCol,
    xDelta, yDelta;
set<string> visited;
vector<string> gridInput;

// utility functions
bool onMap(int currX, int currY, int nRow, int nCol)
{
    return (currX >= 0 && currY >= 0 && currX < nCol && currY < nRow);
}
string dirToStr(int currX, int currY, int xDelta, int yDelta)
{
    return to_string(currX) + "," + to_string(currY) + "," + to_string(xDelta) + "," + to_string(yDelta);
}

// get counter for part 1
int solvePartOne()
{
    // simulate steps
    while (onMap(currCol, currRow, numRows, numCols))
    {
        // calculate next step
        nextX = currCol + xDelta;
        nextY = currRow + yDelta;

        // stop if off of map
        if (!onMap(nextX, nextY, numRows, numCols)) break;

        // move if you can
        if (grid[nextY][nextX] >= 0)
        {
            grid[nextY][nextX] = 1;
            currCol = nextX;
            currRow = nextY;
        }

        // rotate otherwise
        else
        {
            tempXDelta = xDelta;
            tempYDelta = yDelta;

            if (xDelta != 0) xDelta = 0;
            else xDelta -= tempYDelta;

            if (yDelta != 0) yDelta = 0;
            else yDelta += tempXDelta;
        }
    }

    // save grid
    for (int i = 0; i < numRows; i++)
        for (int j = 0; j < numCols; j++)
            partOneGrid[i][j] = grid[i][j];

    // count visited steps
    int counter = 0;
    for (int i = 0; i < numRows; i++)
        for (int j = 0; j < numCols; j++)
            if (grid[i][j] > 0)
                counter++;
    
    return counter;
}

// solve a single iteration of part 2
bool infinitePartTwo()
{
    currRow = origY;
    currCol = origX;
    xDelta = 0;
    yDelta = -1;
    visited.clear();
    for (int i = 0; i < numRows; i++)
        for (int j = 0; j < numCols; j++)
            switch (gridInput[i][j])
            {
                // empty space
                case '.':
                    grid[i][j] = 0;
                    break;
                
                // obstruction
                case '#':
                    grid[i][j] = -1;
                    break;
                
                // current position
                case '^':
                    grid[i][j] = 1;
                    currRow = i;
                    currCol = j;
                    break;

                // ??
                default:
                    cerr << "Unexpected map element: " << gridInput[i][j] << endl;
                    grid[i][j] = 0;
                    break;
            }

    // simulate steps
    string tempLoc;
    while (onMap(currCol, currRow, numRows, numCols))
    {
        tempLoc = dirToStr(currRow, currCol, xDelta, yDelta);
        if (visited.contains(tempLoc)) return true;
        visited.insert(tempLoc);

        // calculate next step
        nextX = currCol + xDelta;
        nextY = currRow + yDelta;

        // stop if off of map
        if (!onMap(nextX, nextY, numRows, numCols)) break;

        // move if you can
        if (grid[nextY][nextX] >= 0)
        {
            grid[nextY][nextX] = 1;
            currCol = nextX;
            currRow = nextY;
        }

        // rotate otherwise
        else
        {
            tempXDelta = xDelta;
            tempYDelta = yDelta;

            if (xDelta != 0) xDelta = 0;
            else xDelta -= tempYDelta;

            if (yDelta != 0) yDelta = 0;
            else yDelta += tempXDelta;
        }
    }

    return false;
}

// get answer for part 2
int solvePartTwo()
{
    int counter = 0;

    for (int i = 0; i < numRows; i++)
        for (int j = 0; j < numCols; j++)
            if (partOneGrid[i][j] > 0)
            {
                gridInput[i][j] = '#';

                if (infinitePartTwo()) counter++;

                gridInput[i][j] = '.';
            }

    return counter;
}

int main()
{
    // setup
    ifstream in("day6.in");

    // input
    string temp;
    while (!in.eof())
    {
        getline(in, temp);
        if (in.eof()) break;

        gridInput.push_back(temp);
    }

    // set up visited tracker
    numRows = gridInput.size();
    numCols = gridInput[0].length();

    grid = new int*[numRows];
    partOneGrid = new int*[numRows];
    for (int i = 0; i < numRows; i++)
    {
        grid[i] = new int[numCols];
        partOneGrid[i] = new int[numCols];
        for (int j = 0; j < numCols; j++)
        {
            switch (gridInput[i][j])
            {
                // empty space
                case '.':
                    grid[i][j] = 0;
                    break;
                
                // obstruction
                case '#':
                    grid[i][j] = -1;
                    break;
                
                // current position
                case '^':
                    grid[i][j] = 1;
                    currRow = i;
                    currCol = j;
                    origX = currCol;
                    origY = currRow;
                    break;

                // ??
                default:
                    cerr << "Unexpected map element: " << gridInput[i][j] << endl;
                    grid[i][j] = 0;
                    break;
            }
        }
    }

    xDelta = 0;
    yDelta = -1;

    // output
    cout << "Part 1: " << solvePartOne() << endl;
    cout << "Part 2: " << solvePartTwo() << endl;

    // clean up
    for (int i = 0; i < numRows; i++)
    {
        delete[] grid[i];
        delete[] partOneGrid[i];
    }
    delete[] grid;
    delete[] partOneGrid;

    in.close();
    
    return 0;
}