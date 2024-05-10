#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

using namespace std;

unordered_map<int, int> parent;
vector<bool> alone;
int nsize;

int find(int x) {
    if (parent[x] == x) {
        return x;
    }
    return parent[x] = find(parent[x]);
}

void unite(int x, int y) {
    x = find(x);
    y = find(y);
    if (x != y) {
        parent[y] = x;
    }
}

int main() {
    ifstream input("input.txt");
    ofstream output("output.txt");

    int a, b, m1, m2;
    vector<pair<int, int>> pairs;
    while (true) {
        input >> a >> b;
        if (a == -1 && b == -1) {
            break;
        }
        m1 = max(a, b)+1;
        m2 = alone.size();
        alone.resize(max(m1, m2));
        alone[a] = true;
        alone[b] = true;
        pairs.push_back({a, b});
        parent[a] = a;
        parent[b] = b;
    }

    for (auto& p : pairs) {
        unite(p.first, p.second);
    }

    unordered_map<int, vector<int>> family_trees;
    for (auto& it : parent) {
        family_trees[find(it.second)].push_back(it.first);
    }
    for (bool i : alone)
    {
        if (!i)
            nsize++;
    }
    output << "Number of family trees: " << family_trees.size()+nsize << endl << endl;
    for (auto& tree : family_trees) {
        output << "Family tree: ";
        for (int i : tree.second) {
            output << i << " ";
        }
        output << endl;
    }
    for (int i = 0; i< alone.size(); i++)
    {
        if (!alone[i])
            output << "Family tree : " << i << endl;
    }
    
    input.close();
    output.close();

    return 0;
}