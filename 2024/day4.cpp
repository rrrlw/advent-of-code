#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

int main()
{
    // input grid
    ifstream in("day4.in");

    vector<string> inputGrid;
    string temp;
    while (!in.eof())
    {
        getline(in, temp);
        if (in.eof()) break;

        inputGrid.push_back(temp);
    }

    int numRows = inputGrid.size(),
        numCols = inputGrid[0].length();

    char **grid = new char*[numRows];
    for (int i = 0; i < numRows; i++)
    {
        grid[i] = new char[numCols];

        for (int j = 0; j < numCols; j++)
            grid[i][j] = inputGrid[i].at(j);
    }

    // part1: count occurrences of XMAS
    int counter = 0;
    for (int i = 0; i < numRows; i++)
    {
        for (int j = 0; j < numCols; j++)
        {
            // current letter must be 'X'
            if (grid[i][j] != 'X') continue;

            // up
            if (i >= 3 && grid[i-1][j] == 'M' && grid[i-2][j] == 'A' && grid[i-3][j] == 'S') counter++;

            // down
            if (i + 3 < numRows && grid[i+1][j] == 'M' && grid[i+2][j] == 'A' && grid[i+3][j] == 'S') counter++;

            // left
            if (j >= 3 && grid[i][j-1] == 'M' && grid[i][j-2] == 'A' && grid[i][j-3] == 'S') counter++;

            // right
            if (j + 3 < numCols && grid[i][j+1] == 'M' && grid[i][j+2] == 'A' && grid[i][j+3] == 'S') counter++;

            // up-left
            if (i >= 3 && j >= 3 && grid[i-1][j-1] == 'M' && grid[i-2][j-2] == 'A' && grid[i-3][j-3] == 'S') counter++;

            // up-right
            if (i >= 3 && j + 3 < numCols && grid[i-1][j+1] == 'M' && grid[i-2][j+2] == 'A' && grid[i-3][j+3] == 'S') counter++;

            // down-left
            if (i + 3 < numRows && j >= 3 && grid[i+1][j-1] == 'M' && grid[i+2][j-2] == 'A' && grid[i+3][j-3] == 'S') counter++;

            // down-right
            if (i + 3 < numRows && j + 3 < numCols && grid[i+1][j+1] == 'M' && grid[i+2][j+2] == 'A' && grid[i+3][j+3] == 'S') counter++;
        }
    }

    // part1: output
    cout << counter << endl;

    // part2: count occurrences of MAS in an X format
    counter = 0;
    for (int i = 1; i < numRows - 1; i++)
    {
        for (int j = 1; j < numCols - 1; j++)
        {
            // current letter must be 'A'
            if (grid[i][j] != 'A') continue;

            // 'M's up
            if (grid[i-1][j-1] == 'M' && grid[i-1][j+1] == 'M' && grid[i+1][j+1] == 'S' && grid[i+1][j-1] == 'S') counter++;

            // 'M's down
            if (grid[i-1][j-1] == 'S' && grid[i-1][j+1] == 'S' && grid[i+1][j+1] == 'M' && grid[i+1][j-1] == 'M') counter++;

            // 'M's left
            if (grid[i-1][j-1] == 'M' && grid[i-1][j+1] == 'S' && grid[i+1][j+1] == 'S' && grid[i+1][j-1] == 'M') counter++;

            // 'M's right
            if (grid[i-1][j-1] == 'S' && grid[i-1][j+1] == 'M' && grid[i+1][j+1] == 'M' && grid[i+1][j-1] == 'S') counter++;
        }
    }

    // part2: output
    cout << counter << endl;

    // close out
    for (int i = 0; i < numRows; i++)
        delete[] grid[i];
    delete[] grid;
    in.close();
    return 0;
}