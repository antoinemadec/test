#include <iostream>
#include <string>
#include <utility>  // for swap

using namespace std;

struct Student
{
    std::string name;
    int grade;
};


void sortStudents(Student *s, int length)
{
    // look at each element
    for (int startIndex=0; startIndex<length; startIndex++)
    {
        int largestIndex = startIndex;
        // look for largest element in the rest of the array
        for (int i=startIndex; i<length; i++)
        {
            if (s[i].grade > s[largestIndex].grade)
            {
                largestIndex = i;
            }

        }
        swap(s[startIndex], s[largestIndex]);
    }
}


int main()
{
    // how many students ?
    int studentNb(0);
    do
    {
        cout << "How many student is there ? ";
        cin >> studentNb;
    } while (studentNb <= 0);
    Student *students = new Student[studentNb];

    // enter student info
    for (int i=0; i<studentNb; i++)
    {
        cout << "Name: ";
        cin >> students[i].name;
        cout << "Score: ";
        cin >> students[i].grade;
    }

    // display student info
    sortStudents(students, studentNb);
    for (int i=0; i<studentNb; i++)
    {
        cout << students[i].name << " got " << students[i].grade << "\n";
    }

    delete[] students;
    return 0;
}
