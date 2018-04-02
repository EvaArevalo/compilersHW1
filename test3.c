//This test case is only for homework explanation
int main () {
        double a = 6.0;
        int i;
        int b[2];
        for (i = 0; i < 2; i++) {
                b[i] = i;
        }
        printf("b[1]=%d\n", b[1]);
        if (b[0] > 1){
                a = a * 1.23e-1;
		a = b[1] * 134e+10;
		a = b[0] * .32e55;
		a = a * 1.23E4;
		b[0] = b[0] * 1.23E-1;
		a = b[1] * 147E+4;
        }
        return 0;
 
}
