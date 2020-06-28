#include <stdio.h> 
#include <stdlib.h> 
#include <time.h> 
double generadorRandoms(int minimo, int maximo){ 
        int num = (rand() % (maximo - minimo + 1)) + minimo;
        double rand = num/10;
        return rand;	
} 
    
int main(){
    int max, min;	
    printf("Max");
    scanf("%d", &max);
    printf("Min");
    scanf("%d", &min); 
    srand(time(0));
    printf("%lf ", generadorRandoms(min,max));
    return 0;
}
