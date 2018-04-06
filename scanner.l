%{
#include <stdio.h>

int 	lineCount=0;
int	wordCount=0;
int 	numStrings = 5;
char	**lineContents = NULL;
FILE*	f;

void addWordToLine();
void endOfLine();
void comment();
int yywrap();
void yyerror();
void freeLineContents();

%}

%x NUMBERCHECK PRAGMA ERROR SINGLECOMMENT MULTICOMMENT

Whitespace  [ \t]*
Letter	    [a-zA-Z]
Digit 	    [0-9]
Operator    [\+\-\*/%><=!]
Punctuation [:;,\.\[\]\(\)\{\}]
Exponent    [Ee][+-]?{Digit}+

Integer	    {Digit}+
Double	    {Integer}?[\.]{Integer}
Scidouble   {Double}{Exponent}
Sciint	    {Integer}{Exponent}

Char        \'[ -~]\'
String	    \"[ -~]+\"
Identifier  [_a-zA-Z][_a-zA-Z0-9]*
Pragma	    [#]

%%

{Pragma}			{addWordToLine(); BEGIN(PRAGMA);}
<PRAGMA>"pragma source on"	{addWordToLine();}
<PRAGMA>"pragma source off"	{freeLineContents();
  				lineContents = (char**)malloc(sizeof(char*)*numStrings);} 
<PRAGMA>"pragma token on"	{addWordToLine();} 
<PRAGMA>"pragma token off"	{addWordToLine();}
<PRAGMA>.			{yyerror(); addWordToLine(); BEGIN(ERROR);}
<PRAGMA>\n			{endOfLine(); BEGIN(INITIAL);}

<NUMBERCHECK>{Double}|{Id}|{Exponent}
					/*copies the last number, sets error message, replaces number into 
					lineCount array, adds offending bit to lineContents array, and 
					starts the ERROR condition*/
					{char *stringtext = (char*)malloc(sizeof(lineContents[wordCount-1]));
					strcpy(stringtext,lineContents[wordCount-1]);
					yyerror(); 
					char *lineContents[wordCount]=(char*)malloc(sizeof(stringtext));
					strcpy(lineContents[wordCount],stringtext);
					free(stringtext);
					wordCount++;
					addWordToLine(); BEGIN(ERROR);}
<NUMBERCHECK>.		{unput(yytext); BEGIN(INITIAL);}

<ERROR>.			{addWordToLine();}
<ERROR>\n			{endOfLine(); BEGIN(INITIAL);}


"/*"				{addWordToLine(); BEGIN(MULTICOMMENT);}
<MULTICOMMENT>[^*\n \t]*	{addWordToLine();} /* eat anythong that's not a '*' */
<MULTICOMMENT>"*"+[^*/\n]*  	{addWordToLine();} /* eat '*' not followed by '/' */
<MULTICOMMENT>{Whitespace}	{addWordToLine();}
<MULTICOMMENT>\n		{endOfLine();}
<MULTICOMMENT>"*"+"/" 		{addWordToLine(); BEGIN(INITIAL);}

"//"				{addWordToLine(); BEGIN(SINGLECOMMENT);}  
<SINGLECOMMENT>.		{addWordToLine();}	
<SINGLECOMMENT>\n 		{endOfLine();BEGIN(INITIAL);}

void			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
int			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
double   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
bool   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
char   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
null   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
for   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
while   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
do   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
if   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
else   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
switch 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
return   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
break   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
continue 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
const   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
true   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
false   		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
struct  		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
case   			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
default 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}

fclose 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
clearerr 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
feof 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
ferror 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fflush 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fgetpos 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fopen 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fread 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
freopen 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fseek 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fsetpos 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
ftell 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fwrite 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
remove 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
rename 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
rewind			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
setbuf 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
setvbuf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
tmpfile 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
tmpnam 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
ffprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
sfprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
vffprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
vfprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
vsfprintf 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fscanf 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
scanf 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
sscanf 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fgetc 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fgets			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fputc 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
fputs 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
getc 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
getchar 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
gets 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
putc 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
putchar 		{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
puts 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
ungetc 			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
perror			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
printf			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}

"++"			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"--"			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"<="			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
">="			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"=="			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"!="			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"&&"			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
"||"			{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}

{Whitespace}		{addWordToLine();}
{Operator}		{fprintf(f,"#op:%s\n",yytext);  addWordToLine();}
{Punctuation}		{fprintf(f,"#punc:%s\n",yytext);  addWordToLine();}
{Scidouble}		{fprintf(f,"#sci:%s\n",yytext);  addWordToLine(); BEGIN(NUMBERCHECK);}
{Sciint}		{fprintf(f,"#sci:%s\n",yytext);  addWordToLine(); BEGIN(NUMBERCHECK);}
{Double}		{fprintf(f,"#double:%s\n",yytext);  addWordToLine(); BEGIN(NUMBERCHECK);}
{Integer}		{fprintf(f,"#integer:%s\n",yytext);  addWordToLine(); BEGIN(NUMBERCHECK);}
{Char}			{fprintf(f,"#char:%s\n",yytext);  addWordToLine();}
{Identifier}		{fprintf(f,"#id:%s\n",yytext);  addWordToLine();}
{String}		{char *stringtext= (char*)malloc(sizeof(char)*(yyleng-1));
			strncpy(stringtext,&yytext[1],yyleng-2);
			fprintf(f,"#string:%s\n",stringtext);
			addWordToLine();
			free(stringtext);}
\n 			{endOfLine();}
.			{yyerror();BEGIN(ERROR);}

%%

/*-----------------------
main() set yyin() as the argument passed on command line and
outputs to file "tokens", calls lexer, closes and  cleans up 
------------------------*/
int main(int argc, char*argv[]){
  ++argv;
  --argc;	/*skip over program name*/

  if (0<argc){
  	yyin = fopen(argv[0], "r");
  } else {
  	yyin=stdin;
  }
  
  f = fopen("tokens","w");

  lineContents = (char**)malloc(sizeof(char*)*numStrings);  
  yylex();
  fclose(f);
  freeLineContents();
  return 0;
} 

/*-----------------------
addWordToLine() Adds word to line, dynamically allocates more space if 
needed
------------------------*/
void addWordToLine(){
	if (wordCount>=numStrings-1){
		numStrings*=2;
		lineContents=realloc(lineContents,numStrings*sizeof(lineContents));
	}
	lineContents[wordCount] = (char*) malloc(sizeof(char) * yyleng + 1);
	strcpy(lineContents[wordCount],yytext);
	wordCount++;
}

/*-----------------------
endOfLine() Flushes a synctactically correct line to the file
------------------------*/
void endOfLine(){
	//print line
	lineCount++;

	fprintf(f,"%d:", lineCount);
	int j;
	for(j=0;j<wordCount;j++)
		fprintf(f,"%s",lineContents[j]);
	fprintf(f,"\n");

	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
}


int yywrap(){
	return 1; /*eof*/
}

/*-----------------------
yyerror()  
------------------------*/
void yyerror(char *message){
	fprintf(f, "Error at line ");
	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
}

/*-----------------------
addWordToLine() Clean up dynamically allocated array lineContents() 
------------------------*/
void freeLineContents(){

	int i;
	for(i=0;i<wordCount;i++)
		free(lineContents[i]);
	free(lineContents);
	numStrings=5;
	wordCount=0;
}
