#include <iostream>
#include <fstream>
#include <queue>
#include <vector>
#include <string>

using namespace std;

const int dx[] = { 0, 1, 1, 1, 0, -1, -1, -1 };
const int dy[] = { 1, 1, 0, -1, -1, -1, 0, 1 };

int main() {
    ifstream infile("maze.txt");
    if (!infile) {
        cout << "Ошибка при открытии файла!" << endl;
        return 1;
    }

    vector<string> maze;
    string line;
    while (getline(infile, line)) {
        maze.push_back(line);
    }

    int rows = maze.size();
    int cols = maze[0].size();

    vector<vector<bool>> visited(rows, vector<bool>(cols, false));
    vector<vector<int>> dist(rows, vector<int>(cols, INT_MAX));
    vector<vector<pair<int, int>>> parent(rows, vector<pair<int, int>>(cols, make_pair(-1, -1)));

    queue<pair<int, int>> q;
    int start_x, start_y, finish_x, finish_y;
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (maze[i][j] == 's') {
                start_x = i;
                start_y = j;
                q.push(make_pair(i, j));
                dist[i][j] = 0;
                visited[i][j] = true;
            }
            if (maze[i][j] == 'f') {
                finish_x = i;
                finish_y = j;
            }
        }
    }

    while (!q.empty()) {
        pair<int, int> curr = q.front();
        q.pop();

        for (int k = 0; k < 8; ++k) {
            int new_x = curr.first + dx[k];
            int new_y = curr.second + dy[k];

            if (new_x >= 0 && new_x < rows && new_y >= 0 && new_y < cols && maze[new_x][new_y] != '#' && !visited[new_x][new_y]) {
                q.push(make_pair(new_x, new_y));
                visited[new_x][new_y] = true;
                dist[new_x][new_y] = dist[curr.first][curr.second] + 1;
                parent[new_x][new_y] = make_pair(curr.first, curr.second);
            }
        }
    }

    if (!visited[finish_x][finish_y]) {
        cout << "Путь не существует!" << endl;
        return 0;
    }

    pair<int, int> curr = make_pair(finish_x, finish_y);
    while (maze[curr.first][curr.second] != 's') {
        maze[curr.first][curr.second] = '*';
        curr = parent[curr.first][curr.second];
    }

    for (int i = 0; i < rows; ++i) {
        cout << maze[i] << endl;
    }

    return 0;
}