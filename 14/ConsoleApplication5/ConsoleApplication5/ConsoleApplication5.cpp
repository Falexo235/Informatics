#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

using namespace std;

bool canDrawFigure(int numVertices, vector<pair<int, int>> edges) {
    unordered_map<int, int> degree;

    for (int i = 0; i < edges.size(); i++) {
        degree[edges[i].first]++;
        degree[edges[i].second]++;
    }

    int oddDegreeCount = 0;
    for (auto it = degree.begin(); it != degree.end(); it++) {
        if (it->second % 2 != 0) {
            oddDegreeCount++;
        }
    }

    if (oddDegreeCount == 0 || oddDegreeCount == 2) {
        return true;
    }
    else {
        return false;
    }
}

int main() {
    ifstream file("figure.txt");
    if (!file.is_open()) {
        cout << "Error opening file." << endl;
        return 1;
    }

    int numVertices, numEdges;
    file >> numVertices >> numEdges;

    vector<pair<int, int>> edges;

    for (int i = 0; i < numEdges; i++) {
        int v1, v2;
        file >> v1 >> v2;
        edges.push_back(make_pair(v1, v2));
    }

    file.close();

    if (canDrawFigure(numVertices, edges)) {
        cout << "yes" << endl;
    }
    else {
        cout << "no" << endl;
    }

    return 0;
}