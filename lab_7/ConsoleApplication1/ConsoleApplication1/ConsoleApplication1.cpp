

#include <iostream>
#include <math.h>

int main()
{
    setlocale(LC_ALL, "Russian");
    double n, s, i, max, prev, cur;
    float f, x, step;
       
    std::cout << "Начальная точка: ";
    std::cin >> x;
    std::cout << "\n";
    step = (4 - x) / 10;
    for (i = 1; i <= 10; i++)
    {
        f = sin(x) / x;
        std::cout << f <<" ";
        x = x + step;
    }
        
    std::cout << "\nМаксимальное число: ";
    std::cin >> max;
    prev = 0;
    cur = 1;
    n = 1;
    s = 0;
    if (max < 2147483647)
    {
        while (cur <= max)
        {
            n++;
            s = s + cur;
            i = cur;
            cur = prev + cur;
            prev = i;
        }
        std::cout << "\ns = " << s << "; n = " << n;
    }
    else std::cout << "\nЧисло слишком велико";
}
