#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char const *getIp() {
    setenv("LANG","C",1);
    FILE * fp = popen("hostname -I", "r");
    if (fp) {
        char *p=NULL, *e; size_t n;
        while ((getline(&p, &n, fp) > 0) && p) {
            char *pos;
            if ((pos=strchr(p, '\n')) != NULL)
                *pos = '\0';
            return p;
        }
    }
    pclose(fp);
    return NULL;
}


int main() {
    printf("%s\n", getIp());
}
