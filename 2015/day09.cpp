#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include <vector>

using namespace std;

int counter;

int main()
{
    // setup file input
    ifstream in("day9.in");

    // setup info
    set<string> places;
    map<string,int> placeID;

    // input
    string waste1, waste2, place1, place2;
    int distance;

    counter = 0;
    while (!in.eof())
    {
        in >> place1 >> waste1 >> place2 >> waste2 >> distance;
        if (in.eof()) break;

        if (!places.contains(place1))
        {
            placeID[place1] = counter++;
            places.insert(place1);
        }
        if (!places.contains(place2))
        {
            placeID[place2] = counter++;
            places.insert(place2);
        }
    }

    int numPlaces = places.size();
    int **dist = new int*[numPlaces];
    for (int i = 0; i < numPlaces; i++)
    {
        dist[i] = new int[numPlaces];
        for (int j = 0; j < numPlaces; j++)
            dist[i][j] = 1 << 20; // ~1 million, should be large enough
    }

    in.close();
    in.open("day9.in");

    int id1, id2;
    while (!in.eof())
    {
        in >> place1 >> waste1 >> place2 >> waste2 >> distance;
        if (in.eof()) break;

        id1 = placeID[place1];
        id2 = placeID[place2];
        dist[id1][id2] = dist[id2][id1] = distance;
    }

    // check every permutation and keep track of min distance
    vector<int> vals;
    for (int i = 0; i < numPlaces; i++)
        vals.push_back(i);

    int currDist, minDist = 1 << 20, // ~ 1 million, should be sufficiently large
        maxDist = 0;
    bool complete;
    do {
        // evaluate permutation distance
        currDist = 0;
        complete = true;
        for (int i = 1; i < numPlaces; i++)
        {
            if (dist[vals[i-1]][vals[i]] == 1 << 20)
            {
                complete = false;
                break;
            }

            currDist += dist[vals[i-1]][vals[i]];
        }

        // check & update
        if (complete && minDist > currDist)
            minDist = currDist;
        if (complete && maxDist < currDist)
            maxDist = currDist;
    } while (next_permutation(vals.begin(), vals.end()));

    // part 1: output
    cout << "Part 1: " << minDist << endl;
    cout << "Part 2: " << maxDist << endl;

    // clean up and exit
    for (int i = 0; i < numPlaces; i++)
        delete[] dist[i];
    delete[] dist;
    places.clear();
    placeID.clear();
    vals.clear();
    return 0;
}