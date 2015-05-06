# vim: noet :

CFLAGS=-O2

BIN=./bin
OBJ=./obj
INC=./inc
SRC=./src

CC=gcc

EXENAME=calc

LEX=lex
LIBLEX=-ll

YACC=yacc
LIBYACC=-ly

LIBMATH=-lm

all: $(BIN)/$(EXENAME)

dev: CFLAGS=-g -Wall -Wextra
dev: all

$(BIN)/$(EXENAME): $(OBJ)/y.tab.o $(OBJ)/lex.yy.o $(OBJ)/symtab.o
	@mkdir -p $(BIN)
	$(CC) $(CFLAGS) $(OBJ)/y.tab.o $(OBJ)/lex.yy.o $(OBJ)/symtab.o -o $(BIN)/$(EXENAME) $(LIBLEX) $(LIBYACC) $(LIBMATH)

$(OBJ)/y.tab.o: $(SRC)/y.tab.c $(INC)/y.tab.h
	@mkdir -p $(OBJ)
	$(CC) $(CFLAGS) -c $(SRC)/y.tab.c -I$(INC) -o $(OBJ)/y.tab.o

$(OBJ)/lex.yy.o: $(SRC)/lex.yy.c
	@mkdir -p $(OBJ)
	$(CC) $(CFLAGS) -c $(SRC)/lex.yy.c -I$(INC) -o $(OBJ)/lex.yy.o

# Also $(INC)/y.tab.h
$(SRC)/y.tab.c: $(SRC)/calc.y
	@mkdir -p $(SRC) $(INC)
	$(YACC) --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

$(SRC)/lex.yy.c: $(SRC)/calc.l
	@mkdir -p $(SRC)
	$(LEX) -o $(SRC)/lex.yy.c $(SRC)/calc.l 

$(OBJ)/symtab.o: $(SRC)/symtab.c $(INC)/symtab.h
	@mkdir -p $(OBJ)
	$(CC) $(CFLAGS) -c $(SRC)/symtab.c -I$(INC) -o $(OBJ)/symtab.o

run: all
	$(BIN)/$(EXENAME)

clean:
	rm -f $(OBJ)/*.o
	rm -f $(BIN)/*
	rm -f $(INC)/y.tab.h
	rm -f $(SRC)/y.tab.c
	rm -f $(SRC)/lex.yy.c
