%{
#include <stdio.h>

int 	lineCount=0;
int		wordCount=0;
int 	numStrings = 5;
char	**lineContents = NULL;

void addWordToLine();
void endOfLine();
void comment();

%}

Whitespace  [ \t]*
Letter	    [a-zA-Z]
Digit 	    [0-9]
Operator	[\+\-\*/%><=!]
Punctuation [:;,\.\[\]\(\)\{\}]
Exponent    [Ee][+-]?{Digit}+

Char 		\'{Letter}\'
String	    \"([^'\n]|\'\')+\"
Identifier  [_a-zA-Z][_a-zA-Z0-9]*

Sci 		{Digit}+Exponent
Double		{Digit}+[\.]{Digit}+
Integer		{Digit}+


%%

\n 				{endOfLine();}

void			{printf("#key: %s\n",yytext);  addWordToLine();}
int				{printf("#key: %s\n",yytext);  addWordToLine();}
double   		{printf("#key: %s\n",yytext);  addWordToLine();}
bool   			{printf("#key: %s\n",yytext);  addWordToLine();}
char   			{printf("#key: %s\n",yytext);  addWordToLine();}
null   			{printf("#key: %s\n",yytext);  addWordToLine();}
for   			{printf("#key: %s\n",yytext);  addWordToLine();}
while   		{printf("#key: %s\n",yytext);  addWordToLine();}
do   			{printf("#key: %s\n",yytext);  addWordToLine();}
if   			{printf("#key: %s\n",yytext);  addWordToLine();}
else   			{printf("#key: %s\n",yytext);  addWordToLine();}
switch 			{printf("#key: %s\n",yytext);  addWordToLine();}
return   		{printf("#key: %s\n",yytext);  addWordToLine();}
break   		{printf("#key: %s\n",yytext);  addWordToLine();}
continue 		{printf("#key: %s\n",yytext);  addWordToLine();}
const   		{printf("#key: %s\n",yytext);  addWordToLine();}
true   			{printf("#key: %s\n",yytext);  addWordToLine();}
false   		{printf("#key: %s\n",yytext);  addWordToLine();}
struct  		{printf("#key: %s\n",yytext);  addWordToLine();}
case   			{printf("#key: %s\n",yytext);  addWordToLine();}
default 		{printf("#key: %s\n",yytext);  addWordToLine();}

fclose 			{printf("#key: %s\n",yytext);  addWordToLine();}
clearerr 		{printf("#key: %s\n",yytext);  addWordToLine();}
feof 			{printf("#key: %s\n",yytext);  addWordToLine();}
ferror 			{printf("#key: %s\n",yytext);  addWordToLine();}
fflush 			{printf("#key: %s\n",yytext);  addWordToLine();}
fgetpos 		{printf("#key: %s\n",yytext);  addWordToLine();}
fopen 			{printf("#key: %s\n",yytext);  addWordToLine();}
fread 			{printf("#key: %s\n",yytext);  addWordToLine();}
freopen 		{printf("#key: %s\n",yytext);  addWordToLine();}
fseek 			{printf("#key: %s\n",yytext);  addWordToLine();}
fsetpos 		{printf("#key: %s\n",yytext);  addWordToLine();}
ftell 			{printf("#key: %s\n",yytext);  addWordToLine();}
fwrite 			{printf("#key: %s\n",yytext);  addWordToLine();}
remove 			{printf("#key: %s\n",yytext);  addWordToLine();}
rename 			{printf("#key: %s\n",yytext);  addWordToLine();}
rewind			{printf("#key: %s\n",yytext);  addWordToLine();}
setbuf 			{printf("#key: %s\n",yytext);  addWordToLine();}
setvbuf 		{printf("#key: %s\n",yytext);  addWordToLine();}
tmpfile 		{printf("#key: %s\n",yytext);  addWordToLine();}
tmpnam 			{printf("#key: %s\n",yytext);  addWordToLine();}
fprintf 		{printf("#key: %s\n",yytext);  addWordToLine();}
printf 			{printf("#key: %s\n",yytext);  addWordToLine();}
sprintf 		{printf("#key: %s\n",yytext);  addWordToLine();}
vfprintf 		{printf("#key: %s\n",yytext);  addWordToLine();}
vprintf 		{printf("#key: %s\n",yytext);  addWordToLine();}
vsprintf 		{printf("#key: %s\n",yytext);  addWordToLine();}
fscanf 			{printf("#key: %s\n",yytext);  addWordToLine();}
scanf 			{printf("#key: %s\n",yytext);  addWordToLine();}
sscanf 			{printf("#key: %s\n",yytext);  addWordToLine();}
fgetc 			{printf("#key: %s\n",yytext);  addWordToLine();}
fgets			{printf("#key: %s\n",yytext);  addWordToLine();}
fputc 			{printf("#key: %s\n",yytext);  addWordToLine();}
fputs 			{printf("#key: %s\n",yytext);  addWordToLine();}
getc 			{printf("#key: %s\n",yytext);  addWordToLine();}
getchar 		{printf("#key: %s\n",yytext);  addWordToLine();}
gets 			{printf("#key: %s\n",yytext);  addWordToLine();}
putc 			{printf("#key: %s\n",yytext);  addWordToLine();}
putchar 		{printf("#key: %s\n",yytext);  addWordToLine();}
puts 			{printf("#key: %s\n",yytext);  addWordToLine();}
ungetc 			{printf("#key: %s\n",yytext);  addWordToLine();}
perror			{printf("#key: %s\n",yytext);  addWordToLine();}

"++"			{printf("#op: %s\n",yytext);  addWordToLine();}
"--"			{printf("#op: %s\n",yytext);  addWordToLine();}
"<="			{printf("#op: %s\n",yytext);  addWordToLine();}
">="			{printf("#op: %s\n",yytext);  addWordToLine();}
"=="			{printf("#op: %s\n",yytext);  addWordToLine();}
"!="			{printf("#op: %s\n",yytext);  addWordToLine();}
"&&"			{printf("#op: %s\n",yytext);  addWordToLine();}
"||"			{printf("#op: %s\n",yytext);  addWordToLine();}

{Whitespace}	/*do nothing*/
{Operator}		{printf("#op: %s\n",yytext);  addWordToLine();}
{Punctuation}	{printf("#punc: %s\n",yytext);  addWordToLine();}
{Sci}			{printf("#sci: %s\n",yytext);  addWordToLine();}
{Double}		{printf("#double: %s\n",yytext);  addWordToLine();}
{Integer}		{printf("#integer: %s\n",yytext);  addWordToLine();}
{Char}			{printf("#char: %s\n",yytext);  addWordToLine();}
{Identifier}	{printf("#identifier: %s\n",yytext);  addWordToLine();}
{String}		{printf("#string: %s\n",yytext);  addWordToLine();}

%%
int main(int argc, char*argv[]){
  ++argv;
  --argc;	/*skip over program name*/

  if (0<argc){
  	yyin = fopen(argv[0], "r");
  } else {
  	yyin=stdin;
  }

  lineContents = (char**)malloc(sizeof(char*)*numStrings);  
  yylex();
  return 0;
} 

//TODO: check realocation scheme
void addWordToLine(){
	if (wordCount>=numStrings-1){
		numStrings*=2;
		lineContents=realloc(lineContents,numStrings*sizeof(lineContents));
	}
	lineContents[wordCount] = (char*) malloc(sizeof(char) * yyleng + 1);
	strcpy(lineContents[wordCount],yytext);
	wordCount++;
}

void endOfLine(){
	//print line
	lineCount++;
	printf("%d:", lineCount);
	int j;
	for(j=0;j<wordCount;j++)
		printf("%s",lineContents[j]);
	printf("\n");

	//free lineContents
	int i;
	for(i=0;i<wordCount;i++)
		free(lineContents[i]);
	free(lineContents);

	//reallocate, reset vars
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
	numStrings=5;
	wordCount=0;
}

//TODO: comments
void comments(){

}

int yywrap(){
	return 1; /*eof*/
}
