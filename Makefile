# vim: noet :

BIN=./bin
OBJ=./obj
INC=./inc
SRC=./src

EXENAME=calc

LEX=flex
LIBLEX=-lfl

YACC=yacc
LIBYACC=-ly

$(BIN)/$(EXENAME): $(OBJ)/y.tab.o $(OBJ)/lex.yy.o
	cc $(OBJ)/y.tab.o $(OBJ)/lex.yy.o -o $(BIN)/$(EXENAME) $(LIBLEX) $(LIBYACC)

$(OBJ)/y.tab.o: $(SRC)/y.tab.c $(INC)/y.tab.h
	cc -c $(SRC)/y.tab.c -I$(INC) -o $(OBJ)/y.tab.o

$(OBJ)/lex.yy.o: $(SRC)/lex.yy.c
	cc -c $(SRC)/lex.yy.c -I$(INC) -o $(OBJ)/lex.yy.o

$(SRC)/y.tab.c: $(SRC)/calc.y
	$(YACC) --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

$(INC)/y.tab.h: $(SRC)/calc.y
	$(YACC) --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

$(SRC)/lex.yy.c: $(SRC)/calc.l
	$(LEX) -o $(SRC)/lex.yy.c $(SRC)/calc.l 

generate: $(SRC)/calc.l $(SRC)/calc.y
	$(LEX) -o $(SRC)/lex.yy.c $(SRC)/calc.l 
	$(YACC) --defines=$(INC)/y.tab.h $(SRC)/calc.y -o $(SRC)/y.tab.c

run: $(BIN)/$(EXENAME)
	$(BIN)/$(EXENAME)

clean:
	rm -f $(OBJ)/*.o
	rm -f $(BIN)/*
	rm -f $(INC)/y.tab.h
	rm -f $(SRC)/y.tab.c
	rm -f $(SRC)/lex.yy.c
