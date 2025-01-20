#include <iostream>
#include <fstream>
#include <set>
#include <string>
#include <vector>
#include <map>

using namespace std;

map<string,int>dist;
vector<string> findVec, replaceVec;
int counter = 0, counterA = 0;
string original;
int minDepth = 100000,
    maxReplaceLen = 0;

int main()
{
    // process input
    ifstream in("day19.in");
    string tempFind, tempReplace, tempWaste;
    while (true)
    {
        in >> tempFind >> tempWaste >> tempReplace;
        if (in.eof())
        {
            original = tempFind;
            break;
        }

        findVec.push_back(tempFind);
        replaceVec.push_back(tempReplace);

        if (maxReplaceLen < tempReplace.length())
            maxReplaceLen = tempReplace.length();
    }

    // part 1: try all combos and track potentials in set
    set<string> replacements;
    string tempReplacement;
    for (int i = 0; i < original.length(); i++)
    {
        // try all replacements
        for (int j = 0; j < findVec.size(); j++)
        {
            if (findVec[j].length() + i > original.length()) continue;

            if (original.substr(i, findVec[j].length()) == findVec[j])
            {
                tempReplacement = original;
                tempReplacement.replace(i, findVec[j].length(), replaceVec[j]);
                replacements.insert(tempReplacement);
            }
        }
    }

    // output: part 1
    cout << "Part 1: " << replacements.size() << endl;

    // close out and exit
    return 0;
}
