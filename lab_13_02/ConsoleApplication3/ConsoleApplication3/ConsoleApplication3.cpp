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
double xx1 = 0;
double xx2 = 0;
double xx3 = 0;
double yy1 = 0;
double yy2 = 0;
double yy3 = 0;
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
void findIntersectionPoint(const vector<vector<double>>& matrix,int n) {
    double x, y;
    y = matrix[1][2] / matrix[1][1];
    x = (matrix[0][2] - matrix[0][1] * y) / matrix[0][0];
    switch (n)
    {
    case 1:
    {
        xx1 = x;
        yy1 = y;
        break;
    }
    case 2:
    {
        xx2 = x;
        yy2 = y;
        break;
    }
    case 3:
    {
        xx3 = x;
        yy3 = y;
        break;
    }
    }
    if ((x == INFINITY) or (y == INFINITY) or (x!=x) or (y!=y))  { outfile << "Не треугольник"; exit(1); }
    else
        outfile << "Координаты точки пересечения: (" << x << ", " << y << ")" << endl;
}

int main() {
    setlocale(LC_ALL, "Russian");
    string line;
    vector<vector<double>> lines(3, vector<double>(3));
    vector<vector<double>> matrix(2, vector<double>(3));
    ifstream inputFile("input.txt");
    if (!inputFile.is_open()) {
        cerr << "Невозможно открыть файл" << endl;
        return 1;
    }
    int i = 0;
    int j = 1;
    bool eq = false;
    int k = 1;
    int num = 0;
    int ch = 0;
    getline(inputFile, line);
    outfile << line << "\n";
    while (ch < size(line)) {
        if ((ch == 0) and (!isdigit(line[ch])))
        {
            switch (line[ch])
            {
                case 'x':
                {
                    lines[i][0] = 1;
                    ch++;
                    break;
                }
                case 'y':
                {
                    lines[i][1] = 1;
                    ch++;
                    break;
                }
            }
        }
        if (isdigit(line[ch]))
        {
            num *= k;
            k *= 10;
            num += (int)line[ch] - 48;
        }
        else if ((ch > 0) and isdigit(line[ch - 1]))
        {
            switch (line[ch])
            {
            case'x':
            {
                lines[i][0] = num * j;
                if (num == 0) lines[i][0] = 1;
                num = 0;
                k = 1;
                break;
            }
            case'y':
            {
                lines[i][1] = num * j;
                if (num == 0) lines[i][1] = 1;
                num = 0;
                k = 1;
                break;
            }
            default:
            {
                if (eq)lines[i][2] += num*j;
                else lines[i][2] -= num*j;
                num = 0;
                k = 1;
                break;
            }
            }
        }
        else
        {
            switch (line[ch])
            {
            case'x':
            {
                lines[i][0] = j;
                num = 0;
                k = 1;
                break;
            }
            case'y':
            {
                lines[i][1] = j;
                num = 0;
                k = 1;
                break;
            }

            }
        }
        switch (line[ch])
        {
        case'-':
        {
            j = -1;
            break;
        }
        case'+':
        {
            j = 1;
            break;
        }
        case'=':
        {
            eq = true;
            j = 1;
            break;
        }
        }
        if (line[ch] == ',') {
            eq = false;
            i++;
            j = 1;
        }

        ch++;

    }
    lines[i][2] += num*j;

    
    outfile << lines[0][0] << " " << lines[0][1] << " " << lines[0][2] << "\n" << lines[1][0] << " " << lines[1][1] << " " << lines[1][2] << "\n"<<lines[2][0]<<" "<<lines[2][1]<<" "<<lines[2][2]<<"\n";
    Gnuplot gp;
    vector<pair<double, double> > xy_pts_A;
    for (double x = -20; x < 20; x += 1) {
        double y = (x * lines[0][0] - lines[0][2]) / (-lines[0][1]);
        xy_pts_A.push_back(std::make_pair(x, y));
    }
    vector<pair<double, double> > xy_pts_B;
    for (double x = -20; x < 20; x += 1) {
        double y = (x * lines[1][0] - lines[1][2]) / (-lines[1][1]);
        xy_pts_B.push_back(std::make_pair(x, y));
    }
    vector<pair<double, double> > xy_pts_C;
    for (double x = -20; x < 20; x += 1) {
        double y = (x * lines[2][0] - lines[2][2]) / (-lines[2][1]);
        xy_pts_C.push_back(std::make_pair(x, y));
    }
    gp << "set xrange [-10:10]\nset yrange [-10:10]\n";
    gp << "plot" << gp.file1d(xy_pts_A) << "with lines title 'f1',"
        << gp.file1d(xy_pts_B) << "with lines title 'f2',"<<gp.file1d(xy_pts_C)<<"with lines title 'f3'" << std::endl;
#ifdef _WIN32
    std::cout << "Press enter to exit." << std::endl;
    std::cin.get();
#endif
    matrix[0] = lines[0];
    matrix[1] = lines[1];
    // Приведение матрицы к ступенчатому виду
    rowEchelonForm(matrix);

    // Нахождение точки пересечения прямых
    findIntersectionPoint(matrix,1);
    matrix[0] = lines[0];
    matrix[1] = lines[2];
    rowEchelonForm(matrix);
    findIntersectionPoint(matrix,2);
    matrix[0] = lines[1];
    matrix[1] = lines[2];
    rowEchelonForm(matrix);
    findIntersectionPoint(matrix, 3);
    double a = xx1 - xx3;
    double b = yy1-yy3;
    double c = xx2-xx3;
    double d = yy2 - yy3;
    double p = (a * d - b * c) / 2;

    outfile << "Площадь треугольника: " <<p<<" "<<a<<b<<c<<d;

    return 0;
}