#include <stdio.h>
#include <stdlib.h>
#include <time.h>
double generadorRandoms(int minimo, int maximo){
    srand((unsigned) time(&tm));
    double valor = (rand() % ((maximo-minimo+1)+minimo)/10);
    return valor;
}

int main(){
        double prueba = generadorRandoms(90.4, 100.5);
	printf("%f", prueba);
	return 0;
}

