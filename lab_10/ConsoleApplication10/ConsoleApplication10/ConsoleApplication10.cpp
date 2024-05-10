#include <algorithm>
#include <array>
#include <iostream>
using namespace std;

int* unpArr = new int[27]{ 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 4, 5, 5, 5, 8, 8, 8, 8 ,8 ,8 ,8, 12, 17, 17, 17, 17,17 };
int* pArr;
void Pack()
{
	int x;
	pArr = new int[18]{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	for (int i = 0; i <= 26; i++)
	{
		x = unpArr[i];
		pArr[x]++;
	}
	delete[] unpArr;
	return;
}

void Unpack()
{
	unpArr = new int[1000];
	int count = 0;
	int i; int x;
	for (i = 0; i <= 17; i++)
	{
		for (x = 0; x < pArr[i]; x++)
		{
			unpArr[count + x] = i;
		}
		count += x;
	}
	delete[] pArr;
	return;
}

int main()
{
	cout << "start: ";
	for (int i = 0; i <= 26; i++) cout << unpArr[i] << " ";
	Pack();
	cout << "\npacked: ";
	for (int i = 0; i <= 17; i++) cout << pArr[i] << " ";
	Unpack();
	cout << "\nunpacked: ";
	for (int i = 0; i <= 26; i++) cout << unpArr[i] << " ";
}

