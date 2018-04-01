# makefile
# creates "scanner" from "scanner.l" and "test.c"

CC=gcc
LEX=flex

scanner: lex.yy.c
		$(CC) -o $@ $(LDFLAGS) $^

#lex.yy.o: lex.yy.c
#		$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $^

lex.yy.c: scanner.l
		$(LEX) $(LFLAGS) -o $@ $^

clean:
		$(RM) *.o scan.c