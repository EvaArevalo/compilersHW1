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

%x PRAGMA ERROR SINGLECOMMENT MULTICOMMENT

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
Pragma	    [#][^\n]

%%

{Pragma}			{addWordToLine(); BEGIN(PRAGMA);}
<PRAGMA>"source on"		{addWordToLine();}
<PRAGMA>"source off"		{freeLineContents();} 
<PRAGMA>"token on"		{addWordToLine();} 
<PRAGMA>"token off"		{addWordToLine();}
<PRAGMA>.			{yyerror();addWordToLine();}
<PRAGMA>\n			{endOfLine(); BEGIN(INITIAL);}

"/*"				{addWordToLine(); BEGIN(MULTICOMMENT);}
<MULTICOMMENT>[^*\n \t]*	{addWordToLine();} /* eat anythong that's not a '*' */
<MULTICOMMENT>"*"+[^*/\n]*  	{addWordToLine();} /* eat '*' not followed by '/' */
<MULTICOMMENT>{Whitespace}	{addWordToLine();}
<MULTICOMMENT>\n		{endOfLine();}
<MULTICOMMENT>"*"+"/" 		{BEGIN(INITIAL);}

"//"				{addWordToLine(); BEGIN(SINGLECOMMENT);}  
<SINGLECOMMENT>[^\n]		{addWordToLine();}	
//<SINGLECOMMENT>[^\n \tab]	{addWordToLine();}
//<SINGLECOMMENT>{Whitespace} {addWordToLine();}
<SINGLECOMMENT>\n 		{endOfLine();BEGIN(INITIAL);}

void			{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
int				{fprintf(f,"#key:%s\n",yytext);  addWordToLine();}
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
{Scidouble}		{fprintf(f,"#sci:%s\n",yytext);  addWordToLine();}
{Sciint}		{fprintf(f,"#sci:%s\n",yytext);  addWordToLine();}
{Double}		{fprintf(f,"#double:%s\n",yytext);  addWordToLine();}
{Integer}		{fprintf(f,"#integer:%s\n",yytext);  addWordToLine();}
{Char}			{fprintf(f,"#char:%s\n",yytext);  addWordToLine();}
{Identifier}		{fprintf(f,"#id:%s\n",yytext);  addWordToLine();}
{String}		{char *stringtext= (char*)malloc(sizeof(char)*yyleng-2);
			strncpy(stringtext,&yytext[1],yyleng-2);
			fprintf(f,"#string:%s\n",stringtext);
{Pragmason}		{addWordToLine();}
{Pragmasoff}		{addWordToLine();}
{Pragmaton}		{addWordToLine();}
{Pragmatoff}		{addWordToLine();}

\n 				{endOfLine();}
.				{yyerror();addWordToLine();}

%%
int main(int argc, char*argv[]){
  ++argv;
  --argc;	/*skip over program name*/

  if (0<argc){
  	yyin = fopen(argv[0], "r");
  } else {
  	yyin=stdin;
  }
  
  f = fopen("tokens.out","w");

  lineContents = (char**)malloc(sizeof(char*)*numStrings);  
  yylex();
  fclose(f);
  freeLineContents();
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

	fprintf(f,"%d:", lineCount);
	int j;
	for(j=0;j<wordCount;j++)
		fprintf(f,"%s",lineContents[j]);
	fprintf(f,"\n");

	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
}

//TODO: comments
void comments(){

}

int yywrap(){
	return 1; /*eof*/
}

void yyerror(char *message){
	fprintf(f, "Error at line %d: ",lineCount);
	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
}

void freeLineContents(){

	int i;
	for(i=0;i<wordCount;i++)
		free(lineContents[i]);
	free(lineContents);
	numStrings=5;
	wordCount=0;
}
