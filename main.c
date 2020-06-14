#include <stdio.h>

//funciones de cálculo
extern double obtenerPromedio();
extern double obtenerMinimo();
extern double obtenerMaximo();


void main() {
    double radio, altura = 0;
    printf("Digite el radio del cono ");
    scanf("%lf", &radio);
    printf("Los valores que ud digito son: %lf y %lf\n", radio, altura);
    printf("El resultado del volumen de un cono con base circular de radio %lf y altura %lf  es: %lf\n", radio, altura, volumen_cono(radio,altura)); 
}
