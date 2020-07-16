#include <stdio.h>

extern double mayor (double a, double b);
extern double menor (double a, double b);
extern double promedio (double a, double b);

int main() {
    double a, b, c, d;

    printf("un numero: ");
    scanf("%lf", &a);
    printf("un numero: ");
    scanf("%lf", &b);
    printf("El mayor de %lf y %lf es: %lf\n", a, b, mayor(a, b));

    printf("un numero: ");
    scanf("%lf", &c);
    printf("un numero: ");
    scanf("%lf", &d);
    printf("El menor de %lf y %lf es: %lf\n", c, d, menor(c,d));
     
    printf("El promedio de %lf y %lf es: %lf\n", 100.0, 10.0, promedio(100.0, 10.0));
    return 0;
}