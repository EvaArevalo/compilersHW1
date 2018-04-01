# makefile
# creates "scanner" from "scanner.l" and "test.c"

CC=gcc
LEX=flex

scanner: scanner.o test.o
		$(CC) -o $@ $(LDFLAGS) $^

test.o: test.c
		$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $^

lex.yy.o: lex.yy.c
		$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $^

lex.yy.c: scanner.l
		$(LEX) $(LFLAGS) -o $@ $^

clean:
		$(RM) *.o scan.c