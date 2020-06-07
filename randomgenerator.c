#include <stdio.h>
#include <stdlib.h>

double random(int rango){
    srand((unsigned) time(&t));
    double valor = (rand() % rango)/10;
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