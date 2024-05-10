#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <cmath>
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
void findIntersectionPoint(const vector<vector<double>>& lines) {
    //double x, y, z;
    /*z = matrix[2][3] / matrix[2][1];
    y = matrix[1][3] / matrix[1][1];
    x = (matrix[0][3] - matrix[0][1] * y) / matrix[0][0];
    */
    double detA = lines[0][0] * (lines[1][1] * lines[2][2] - lines[1][2] * lines[2][1]) - lines[0][1] * (lines[1][0] * lines[2][2] - lines[1][2] * lines[2][0]) + lines[0][2] * (lines[1][0] * lines[2][1] - lines[1][1] * lines[2][0]);
    if (detA == 0) {
        outfile << "Точка пересечения не существует" << endl;
        return;
    }

    double detX = lines[0][3] * (lines[1][1] * lines[2][2] - lines[1][2] * lines[2][1]) - lines[0][1] * (lines[1][3] * lines[2][2] - lines[1][2] * lines[2][3]) + lines[0][2] * (lines[1][3] * lines[2][1] - lines[1][1] * lines[2][3]);
    double detY = lines[0][0] * (lines[1][3] * lines[2][2] - lines[1][2] * lines[2][3]) - lines[0][3] * (lines[1][0] * lines[2][2] - lines[1][2] * lines[2][0]) + lines[0][2] * (lines[1][0] * lines[2][3] - lines[1][3] * lines[2][0]);
    double detZ = lines[0][0] * (lines[1][1] * lines[2][3] - lines[1][3] * lines[2][1]) - lines[0][1] * (lines[1][0] * lines[2][3] - lines[1][3] * lines[2][0]) + lines[0][3] * (lines[1][0] * lines[2][1] - lines[1][1] * lines[2][0]);

    double x = detX / detA;
    double y = detY / detA;
    double z = detZ / detA;

    outfile << "Точка пересечения: (" << x << ", " << y << ", " << z << ")" << endl;

}

int main() {
    setlocale(LC_ALL, "Russian");
    string line;
    vector<vector<double>> lines(3, vector<double>(4));
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
                case 'z':
                {
                    lines[i][2] = 1;
                    ch++;
                    break;
                }
                default:
                {
                    outfile << "ERROR";
                    exit(true);
                }
            }
        }
        if (isdigit(line[ch])) 
        {
            num *= k;
                k *= 10;
                num += (int)line[ch]-48;
        }
        else if((ch > 0) and isdigit(line[ch - 1]))
        {
            switch (line[ch])
            {
                case'x':
                {
                    lines[i][0] = num*j;
                    if (num == 0) lines[i][0] = 1;
                    num = 0;
                    k = 1;
                    break;
                }
                case'y':
                {
                    lines[i][1] = num*j;
                    if (num == 0) lines[i][1] = 1;
                    num = 0;
                    k = 1;
                    break;
                }
                case'z':
                {
                    lines[i][2] = num*j;
                    if (num == 0) lines[i][2] = 1;
                    num = 0;
                    k = 1;
                    break;
                }
                default:
                {
                    if(eq)lines[i][3] += num;
                    else lines[i][3] -= num;
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
                case'z':
                {
                    lines[i][2] = j;
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
    lines[i][3] += num;
    outfile << lines[0][0] << " " << lines[0][1] << " " << lines[0][2] <<" "<<lines[0][3] <<"\n" << lines[1][0] << " " << lines[1][1] << " " << lines[1][2] << " " << lines[1][3] << "\n" << lines[2][0] << " " << lines[2][1] << " " << lines[2][2] << " " << lines[2][3] << "\n";
    // Приведение матрицы к ступенчатому виду
    rowEchelonForm(lines);

    // Вывод ступенчатой матрицы (для проверки)
    outfile << "Ступенчатая матрица:" << endl;
    printMatrix(lines);

    // Нахождение точки пересечения прямых
    findIntersectionPoint(lines);


    return 0;
}
