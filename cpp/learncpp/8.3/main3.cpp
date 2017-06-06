#include <iostream>
#include <assert.h>
#include <stdio.h>

class Stack
{
    int m_array[10];
    int m_length;

public:
    void reset()
    {
        m_length = 0;
        for (int i=0; i<10; i++)
          m_array[i] = 0;
    }

    int push(int e)
    {
        if (m_length == 10)
            return 0;
        else
        {
            m_array[m_length] = e;
            m_length++;
            return 1;
        }
    }

    int pop()
    {
        assert(m_length != 0);
        m_length--;
        return m_array[m_length];
    }

    void print()
    {
        printf("( ");
        for (int i=0; i<m_length; i++)
            printf("%0d ", m_array[i]);
        printf(" )\n");
    }
};

int main()
{
    Stack stack;
    stack.reset();

    stack.print();

    stack.push(5);
    stack.push(3);
    stack.push(8);
    stack.print();

    stack.pop();
    stack.print();

    stack.pop();
    stack.pop();

    stack.print();

    return 0;
}
