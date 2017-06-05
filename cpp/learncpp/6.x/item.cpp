#include <iostream>

enum Item {
    HEALTH_POTION,
    TORCH,
    ARROW,
    MAX_ITEM
};

int countTotalItems(int *itemNumber)
{
    int i, sum(0);
    for (i=0; i<MAX_ITEM; i++)
    {
        sum += itemNumber[i];
    }
    return sum;
}

int main()
{
    int itemNb[MAX_ITEM] = {2, 5, 10};
    std::cout << "Total items are: " << countTotalItems(itemNb) << "\n";
    return 0;
}
