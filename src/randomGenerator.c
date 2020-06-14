#include <stdio.h>
#include <stdlib.h>

double random(int minimo, int maximo){
    srand((unsigned) time(&t));
    double valor = (rand() % ((maximo-minimo+1)+minimo)/10;
    return valor;
}


