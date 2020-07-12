#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern double obtenerPromedio();
extern double obtenerMinimo();
extern double obtenerMaximo();
extern void generadorArchivos(int tipoArchivo);

double generadorRandoms(int choice){
    int minimo=0;
    int maximo=0;
    int num;
    double alea;
    switch(choice){
        case 1:
            minimo=100;
            maximo=2000;
            break;

        case 2:
            minimo=150;
            maximo=400;
            break;

        case 3:
            minimo=12;
            maximo=20;
            break;

        case 4:
            minimo=700;
            maximo=100;
            break;
        case 5:
            maximo=950;
            minimo=1000;
            break;
    }
    srand(time(0));
    num = (rand() % (maximo - minimo + 1)) + minimo;
    alea = num/10;
    return alea;
}

void main() {
    //Generacion de datos
    int tipoArchivo = 0;
    printf("Digite el tipo del archivo que desea generar ");
    scanf("%d", &tipoArchivo);
    printf("El tipo de archivo digitado es: %d\n", tipoArchivo);
    generadorArchivos(tipoArchivo);
    printf("Archivo generado exitosamente");
}
