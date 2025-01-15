#include <iostream>

using namespace std;

const int NUM_INGREDIENTS = 4,
          NUM_PROPERTIES = 5,
          CAPACITY = 100,
          DESIRED_CALS = 500;
const int PROPERTIES[NUM_INGREDIENTS][NUM_PROPERTIES] = {
    {2, 0, -2, 0, 3}, // sprinkles
    {0, 5, -3, 0, 3}, // butterscotch
    {0, 0, 5, -1, 8}, // chocolate
    {0, -1, 0, 5, 8}  // candy
};

int main()
{
    // try all combinations and identify the optimal one
    int maxCounter = 0, candy, tempCounter, calCounter,
        tempC, tempD, tempF, tempT,
        maxCounter2 = 0;
    int counts[NUM_INGREDIENTS];
    for (counts[0] = 1; counts[0] < CAPACITY; counts[0]++) // sprinkles
    {
        for (counts[1] = 1; counts[0] + counts[1] < CAPACITY; counts[1]++) // butterscotch
        {
            for (counts[2] = 1; counts[0] + counts[1] + counts[2] < CAPACITY; counts[2]++) // chocolate
            {
                counts[3] = CAPACITY - counts[0] - counts[1] - counts[2];
                
                tempC = tempD = tempF = tempT = calCounter = 0;
                for (int i = 0; i < NUM_INGREDIENTS; i++)
                {
                    tempC += counts[i] * PROPERTIES[i][0];
                    tempD += counts[i] * PROPERTIES[i][1];
                    tempF += counts[i] * PROPERTIES[i][2];
                    tempT += counts[i] * PROPERTIES[i][3];

                    calCounter += counts[i] * PROPERTIES[i][4];
                }

                if (tempC < 0) tempC = 0;
                if (tempD < 0) tempD = 0;
                if (tempF < 0) tempF = 0;
                if (tempT < 0) tempT = 0;

                tempCounter = tempC * tempD * tempF * tempT;

                if (maxCounter < tempCounter)
                    maxCounter = tempCounter;

                if (calCounter == DESIRED_CALS && maxCounter2 < tempCounter)
                    maxCounter2 = tempCounter;
            }
        }
    }

    // outputs
    cout << "Part 1: " << maxCounter << endl;
    cout << "Part 2: " << maxCounter2<< endl;

    // close out and exit
    return 0;
}