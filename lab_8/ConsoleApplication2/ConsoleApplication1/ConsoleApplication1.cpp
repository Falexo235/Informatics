
#include <stdio.h>
#include <iostream>
using namespace std;

int main()
{
    int *x, *y, *z, d;
    x = new int;
    y = new int;
    z = new int;
    cout << "3 number, please" << endl;
    cin >> *x >> *y >> *z;
    if (*x > *y)
    {
        d = *x; *x = *y; *y = d;
    }
    if (*x > *z)
    {
        d = *z; *z = *x; *x = d;
    }
    if (*y > *z)
    {
        d = *y; *y = *z; *z = d;
    }
    cout << "x=" << *x << " y=" << *y << " z=" << *z << " difference =" << *z - *x << endl;
}
