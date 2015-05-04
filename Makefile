# vim: noet :

BIN=./bin
OBJ=./obj
INC=./inc
SRC=./src

EXENAME=calc

$(BIN)/$(EXENAME): $(OBJ)/y.tab.o $(OBJ)/lex.yy.o
	cc $(OBJ)/y.tab.o $(OBJ)/lex.yy.o -o $(BIN)/$(EXENAME) -ll -ly

$(OBJ)/y.tab.o: $(SRC)/y.tab.c $(INC)/y.tab.h
	cc -c $(SRC)/y.tab.c -I$(INC) -o $(OBJ)/y.tab.o

$(OBJ)/lex.yy.o: $(SRC)/lex.yy.c
	cc -c $(SRC)/lex.yy.c -I$(INC) -o $(OBJ)/lex.yy.o

$(SRC)/y.tab.c: $(SRC)/calc.y
	yacc --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

$(INC)/y.tab.h: $(SRC)/calc.y
	yacc --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

$(SRC)/lex.yy.c: $(SRC)/calc.l
	lex -o $(SRC)/lex.yy.c $(SRC)/calc.l 

generate: $(SRC)/calc.l $(SRC)/calc.y
	lex -o $(SRC)/lex.yy.c $(SRC)/calc.l 
	yacc --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

run: $(BIN)/$(EXENAME)
	$(BIN)/$(EXENAME)

clean:
	rm -f $(OBJ)/*.o
	rm -f $(BIN)/*
	rm -f $(INC)/y.tab.h
	rm -f $(SRC)/y.tab.c
	rm -f $(SRC)/lex.yy.c
