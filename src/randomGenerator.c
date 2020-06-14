#include <stdio.h>
#include <stdlib.h>

double random(int minimo, int maximo){
    srand((unsigned) time(&t));
    double valor = (rand() % ((maximo-minimo+1)+minimo)/10;
    return valor;
}

void leerFile(string ruta){
    FILE *archivo;
    char caracter;

    archivo = fopen(ruta, "r");

    if(archivo == NULL){
        printf("Error a la hora de abrir el archivo");
    }
    else{
        printf("\nEl contenido del archivo de prueba es \n\n");
        while((caracter = fgets(archivo)) != EOF){
            /* 
            sensor()
            hora()
            min()
            seg()
            lectura()
            */
        }
    }
    fclose
}
