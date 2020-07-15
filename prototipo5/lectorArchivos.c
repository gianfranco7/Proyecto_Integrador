#include <stdio.h>

extern void abrir(char * nombre, int offset);
extern void lector(int * hora, int * minuto, int * segundo, float * lectura);

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
	//correr el metodo especial para abrir el archivo
	abrir("SensorPulso.txt", 20);
	int hora, minuto, segundo = 0;
	double lectura = 0;
	int horas[300];
	int minutos[300];
	int segundos[300];
	double lecturas[300];
	for(int i = 0; i< 300; i++){
		lector(&hora, &minuto, &segundo, &lectura);
		horas[i] = hora;
		minutos[i] = minuto;
		segundos[i] = segundo;
		lecturas[i] = lectura;
		imprimir para efectos de pruebas
		printf("Hora: %d Minuto: %d Segundo %d Lectura: %f\n", hora, minuto, segundo, lectura);
	}
	return 0;
}
