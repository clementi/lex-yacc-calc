#if !defined(__SYMTAB_H__)
#define __SYMTAB_H__

#define NSYMS 20

struct symtab {
    char *name;
    double value;
} symtab[NSYMS];

struct symtab *symlook(char * s);

#endif
