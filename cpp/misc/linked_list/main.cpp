#include <bits/stdc++.h>
using namespace std;

class Node
{
    public:
        int data;
        char name;
        Node *next;

        Node(char name, int data=0) {
            this->name = name;
            this->data = data;
        }
};

void printList(Node *node) {
    while (node != NULL) {
        printf("%c data=%0d\n", node->name, node->data);
        node = node->next;
    }
}

void reverseList(Node *node) {
    Node *p, *c, *n;
    p = node;
    c = node->next;
    node->next = NULL;
    while (c != NULL) {
        n = c->next;
        c->next = p;
        p = c;
        c = n;
    }
}

int main() {
    Node *a, *b, *c, *d;
    a = new Node('a', 0);
    b = new Node('b', 1);
    c = new Node('c', 2);
    d = new Node('d', 3);
    a->next = b;
    b->next = c;
    c->next = d;
    d->next = NULL;
    printList(a);
    reverseList(a);
    printList(d);
}
