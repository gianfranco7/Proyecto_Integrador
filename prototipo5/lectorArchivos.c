#include <stdio.h>

extern void lectorPulso();
extern char bufferHora;
extern char bufferMin;
extern char bufferSeg;
extern char bufferLect;
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
/*
 	int horas[300];
	int minutos[300];
	int segundos[300];
	float lecturas[300];
	for(int i = 0; i < 300; i++){
		fscanf(ptr, "%x%x%x%a", horas, minutos, segundos, lecturas);
		printf("Hora: %i ", horas[i]);
		printf("Minuto: %i ", minutos[i]);
		printf("Segundo: %i ", segundos[i]);
		printf("Lecturas: %lf ", lecturas[i]);
		printf("\n");
	}
	printf("\n");
*/
	int horas[300];
	int minutos[300];
	int segundos[300];
	double lecturas[30];
	for(int i = 0; i< 300; i++){
		horas[i] = bufferHora;
		minutos[i] = bufferMin;
		segundos[i] = bufferSeg;
		lecturas[i] = bufferLect;
	}

	/*
        int hora =0;
	lector(&hora, &min, &seg, &lect);
	*/

	return 0;
}
