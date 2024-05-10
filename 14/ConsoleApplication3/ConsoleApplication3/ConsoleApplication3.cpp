#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

using namespace std;

unordered_map<char, vector<char>> graph;

int countRoutes(char start, char end) {
    if (start == end) {
        return 1;
    }

    int routes = 0;
    for (char city : graph[start]) {
        routes += countRoutes(city, end);
    }
    return routes;
}

int main() {
    setlocale(LC_ALL, "Russian");
    ifstream input("roads.txt");
    char city1, city2;

    while (input >> city1 >> city2) { // читаем данные из файла и создаем граф
        graph[city1].push_back(city2);
    }

    char start = 'a';
    char end = 'l';
    int routes = countRoutes(start, end);

    cout << "Количество маршрутов из города " << start << " в город " << end << ": " << routes << endl;

    return 0;
}