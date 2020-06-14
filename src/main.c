#include <stdio.h>

//funciones de cálculo
extern double obtenerPromedio();
extern double obtenerMinimo();
extern double obtenerMaximo();
extern void generarArchivo(int tipoArchivo):

void main() {
    int tipoArchivo = 0;
    printf("Digite el tipo del archivo que desea generar ");
    scanf("%lf", &tipoArchivo);
    printf("El tipo de archivo digitado es: %i\n", tipoArchivo);
    generarArchivo(tipoArchivo);
    printf("Archivo generado exitosamente");
}

