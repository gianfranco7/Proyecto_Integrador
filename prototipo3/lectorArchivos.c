#include <stdio.h>

int main(){
	//leer linea 1
	FILE* ptr = fopen("sensorPulso.txt","r");
	char nombreSensor[50];				
	fgets(nombreSensor, 50, ptr);
	printf("%s", nombreSensor);

	//lee linea 2 
	char unidades[50];
    	fgets(unidades, 50, ptr);
	printf("%s", unidades);
	fclose(ptr);

	float lecturas[300];
	for(int i = 0; i < 300; i++){
		fscanf(ptr, "%f", lecturas);
		printf("%f ", lecturas[i]);
	}
	printf("\n");

	return 0;
}
