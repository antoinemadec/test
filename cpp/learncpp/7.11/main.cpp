#include <iostream>

void countDown(int cnt)
{
    std::cout << "push " << cnt << "\n";
    if (cnt == 0)
        return;
    countDown(cnt-1);
    std::cout << "pop " << cnt << "\n";
}

int main()
{

    countDown(7);
}
