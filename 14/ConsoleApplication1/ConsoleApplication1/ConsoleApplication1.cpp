#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

// Функция для создания матрицы смежности из списка ребер
vector<vector<int>> createMatrix(vector<pair<int, int>>& edges, int n) {
    vector<vector<int>> Matrix(n, vector<int>(n, 0));
    for (auto edge : edges) {
        Matrix[edge.first - 1][edge.second - 1] = 1;
        Matrix[edge.second - 1][edge.first - 1] = 1;
    }
    return Matrix;
}

// Функция для создания массива смежных вершин из матрицы смежности
vector<vector<int>> createList(vector<vector<int>>& Matrix) {
    int n = Matrix.size();
    vector<vector<int>> List(n);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (Matrix[i][j] == 1) {
                List[i].push_back(j + 1);
            }
        }
    }
    return List;
}

// Функция для формирования списка ребер из массива смежных вершин
vector<pair<int, int>> createEdges(vector<vector<int>>& List) {
    vector<pair<int, int>> edges;
    for (int i = 0; i < List.size(); i++) {
        for (int j = 0; j < List[i].size(); j++) {
            if (i < List[i][j]) {
                edges.push_back({ i + 1, List[i][j] });
            }
        }
    }
    return edges;
}

int main() {
    ifstream file("graph.txt");
    int n, m;
    file >> n >> m;

    vector<pair<int, int>> edges;
    int u, v;
    for (int i = 0; i < m; i++) {
        file >> u >> v;
        edges.push_back({ u, v });
    }
    file.close();

    vector<vector<int>> Matrix = createMatrix(edges, n);
    ofstream MatrixFile("matrix.txt");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            MatrixFile << Matrix[i][j] << " ";
        }
        MatrixFile << endl;
    }
    MatrixFile.close();

    vector<vector<int>> List = createList(Matrix);
    ofstream ListFile("list.txt");
    for (int i = 0; i < n; i++) {
        ListFile << i + 1 << ": ";
        for (int j = 0; j < List[i].size(); j++) {
            ListFile << List[i][j] << " ";
        }
        ListFile << endl;
    }
    ListFile.close();

    vector<pair<int, int>> Edges = createEdges(List);
    ofstream EdgesFile("edges.txt");
    for (auto edge : Edges) {
        EdgesFile << edge.first << " " << edge.second << endl;
    }
    EdgesFile.close();

    return 0;
}