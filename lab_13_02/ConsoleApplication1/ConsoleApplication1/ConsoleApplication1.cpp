#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <cmath>
#include <gnuplot-iostream.h>
#pragma comment(lib, "libboost_iostreams-vc142-mt-gd-x32-1_85.lib")
#pragma comment(lib, "libboost_filesystem-vc142-mt-gd-x32-1_85.lib")
using namespace std;
ofstream outfile("output.txt");
// Функция для вывода матрицы

void printMatrix(const vector<vector<double>>& matrix) {
    for (const auto& row : matrix) {
        for (double element : row) {
            outfile << element << " ";
        }
        outfile << endl;
    }
}

// Функция для приведения матрицы к ступенчатому виду
void rowEchelonForm(vector<vector<double>>& matrix) {
    int rows = matrix.size();
    int cols = matrix[0].size();

    int lead = 0;
    for (int r = 0; r < rows; r++) {
        if (cols <= lead) {
            return;
        }

        int i = r;
        while (matrix[i][lead] == 0) {
            i++;
            if (rows == i) {
                i = r;
                lead++;
                if (cols == lead) {
                    return;
                }
            }
        }
        if (i != r) {
            swap(matrix[i], matrix[r]);
        }

        double div = matrix[r][lead];
        if (div != 0) {
            for (int j = 0; j < cols; j++) {
                matrix[r][j] /= div;
            }
        }

        for (int j = 0; j < rows; j++) {
            if (j != r) {
                double sub = matrix[j][lead];
                for (int k = 0; k < cols; k++) {
                    matrix[j][k] -= (sub * matrix[r][k]);
                }
            }
        }
        lead++;
    }
}
int nthFind(const std::string& str, const std::string& findMe, int nth)
{
    size_t  pos = 0;
    int     cnt = 0;

    while (cnt != nth)
    {
        pos += 1;
        pos = str.find(findMe, pos);
        if (pos == std::string::npos)
            return -1;
        cnt++;
    }
    return pos;
}
// Функция для нахождения точки пересечения прямых
void findIntersectionPoint(const vector<vector<double>>& matrix) {
    double x, y;
    y = matrix[1][2] / matrix[1][1];
    x = (matrix[0][2] - matrix[0][1] * y) / matrix[0][0];
    if ((x == INFINITY) or (y == INFINITY)) outfile << "Нет точки пересечения";
    else
    outfile << "Координаты точки пересечения: (" << x << ", " << y << ")" << endl;
}

int main() {
    setlocale(LC_ALL, "Russian");
    string line;
    vector<vector<double>> lines(2, vector<double>(3));
    ifstream inputFile("input.txt");
    if (!inputFile.is_open()) {
        cerr << "Невозможно открыть файл" << endl;
        return 1;
    }
    int i = 0;
    int j = 0;
    int k = 1;
    getline(inputFile, line);
    outfile << line<<"\n";
    for (int l = 0; l < 2; l++)
    {
        k = 1;
        
        if (line[0] == 'x') lines[0][0] = 1;
        int h = 0;
        if (lines[0][0] == 1) h = l;
        else h = l + 1;
        if (!(lines[l][0]==1))
        {
            i = nthFind(line, "x", h);
            while (i > 0)
            {
                i--;
                if (isdigit(line[i])) j = (int)line[i] - 48;
                else break;
                j *= k;
                lines[l][0] += j;
                k = k* 10;
            }
        }
        k = 1;
        i = nthFind(line, "y", l+1);
            while (i > 0)
            {
                i--;
                if (isdigit(line[i])) j = (int)line[i] - 48;
                else break;
                j *= k;
                lines[l][1] += j;
                k *= 10;
            }
            if (lines[l][1] < 1) lines[l][1] = 1;
            k = 1;
            i = nthFind(line, "=", l+1);
            while (!isdigit(line[i])) i++;
            while (i < line.length())
            {
                if (isdigit(line[i])) j = (int)line[i] - 48;
                else break;
                lines[l][2] *= k;
                lines[l][2] += j;
                k *= 10;
                i++;
            }
           
    }
    outfile << lines[0][0] << " " << lines[0][1] << " " << lines[0][2] << "\n" << lines[1][0] << " " << lines[1][1] << " " << lines[1][2] << "\n";
    Gnuplot gp;
    vector<pair<double, double> > xy_pts_A;
    for (double x = -10; x < 10; x += 0.1) {
        double y = (x*lines[0][0]-lines[0][2])/(-lines[0][1]);
        xy_pts_A.push_back(std::make_pair(x, y));
    }
    vector<pair<double, double> > xy_pts_B;
    for (double x = -10; x < 10; x += 0.1) {
        double y = (x*lines[1][0] - lines[1][2]) / (-lines[1][1]);
        xy_pts_B.push_back(std::make_pair(x, y));
    }
    gp << "set xrange [-10:10]\nset yrange [-10:10]\n";
    gp << "plot" << gp.file1d(xy_pts_A) << "with lines title 'f1',"
        << gp.file1d(xy_pts_B) << "with lines title 'f2'" << std::endl;
#ifdef _WIN32
    std::cout << "Press enter to exit." << std::endl;
    std::cin.get();
#endif
    // Приведение матрицы к ступенчатому виду
    rowEchelonForm(lines);

    // Вывод ступенчатой матрицы (для проверки)
    outfile << "Ступенчатая матрица:" << endl;
    printMatrix(lines);

    // Нахождение точки пересечения прямых
    findIntersectionPoint(lines);


    return 0;
}