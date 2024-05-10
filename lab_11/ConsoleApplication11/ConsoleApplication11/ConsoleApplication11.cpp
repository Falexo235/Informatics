#include <iostream>
#include <fstream>
#include <vector>
using namespace std;
int main()
{
    ifstream fin;
    int i, j, maxnum, count, maxlen, clen;
    fin.open("test.txt");
    string coms, maxs, word;
    vector<string> vec, curws, maxws;
    if (fin)
    {
        while (fin >> word)
        {
            vec.insert(vec.end(), word);
        }
    }
    fin.close();
    maxnum = 0;
    maxlen = 0;

    for (i = 0; i < vec.size(); i++)
    {
        curws.clear();
        count = 0;
        clen = vec[i].length();
        word = vec[i];
        for (j = 0; j < vec.size(); j++)
        {
            if (i != j)
            {
                    if (vec[j].rfind(vec[i], 0) == 0)
                    {
                        count++;
                        curws.insert(curws.end(), vec[j]);
                    }
            }
        }
        if (count > 0)
        {
            if (clen > maxlen)
            {
                maxws.clear();
                maxlen = clen;
                maxs = word;
                maxws.insert(maxws.begin(), curws.begin(), curws.end());
            }
            if (count > maxnum) 
            {
                maxnum = count;
                coms = word;
            }
        }
    }
    if (maxnum == 0)
    {
        ofstream fout1("out1.txt");
        fout1 << "NO";
        ofstream fout2("out2.txt");
        fout2 << "NO";
    }
    else
    {
        ofstream fout1("out1.txt");
        fout1 << maxs << " ";
        for (i = 0; i < maxws.size(); i++) fout1 << maxws[i] << " ";
        ofstream fout2("out2.txt");
        fout2 << coms << " " << maxnum;
    }
}