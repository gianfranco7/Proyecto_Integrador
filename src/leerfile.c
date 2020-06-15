import <string.h>

char leerFile(string ruta){
    FILE *archivo;
    char caracter;

    archivo = fopen(ruta, 'rt');
    char infoSensor[5];

    if(archivo == NULL){
        printf("Error a la hora de abrir el archivo");
    }
    else{
        int casilla = 0;
        while (caracter != EOF){
            caracter = fgetc(fichero);
            if(caracter != '\0' ){
                strcat(infoSensor[0], caracter);
            }
            else
            {
                casilla++;
            }                
        }
    }
    fclose(archivo);
    return infoSensor;
}

int convertidorCI(char valor){
    int cont = 0;
    int lon = strlen(valor);
    for (int i = 0; i < lon; i++){
        int n = valor[lon - (i+1)] - '0';
        cont = cont + powInt(n,i);
    }
    return cont;
}

int powInt(int x, int y){
    for(int i = 0; i < y; i++){
        x *= 10;
    }
    return x;
}

