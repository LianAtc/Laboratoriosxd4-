
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void genRamdon(int LEN, int MAX, float *v);
void cPromedio(int LEN, float *v, float *cprom);
extern void asmPromedio(int LEN, float *v, float *asmprom);
//  Calling conv 64 bits -> rdi       rsi       rdx

int main(){
    
    srand(time(NULL));
    
    /*Para medir los tiempos*/
    clock_t start, stop;
    
    float *v;
    float asmprom, cprom;
    int LEN = 4096*2, MAX = 100;
    
    v = (float *)malloc(LEN*sizeof(float));
    
    genRamdon(LEN, MAX, v);
    start = clock();
    asmPromedio(LEN, v, &asmprom);
    stop = clock();
    printf("El promedio en ASM es: %.4f\n", asmprom);
    printf("El tiempo de asmPromedio es: %.4f us\n", 1e6*(float)(stop-start)/CLOCKS_PER_SEC);
    // SALE EN MILLON DE SEGUNDOS, por eso tienes que convertir a segundos
    // CLOCKS_PER_SEC <- 1 millon
    
    start = clock();
    cPromedio(LEN, v, &cprom);
    stop = clock();
    printf("El promedio en C es: %.4f\n", cprom);
    printf("El tiempo de cPromedio es: %.4f us\n", 1e6*(float)(stop-start)/CLOCKS_PER_SEC);
    
    return 0;
}


void genRamdon(int LEN, int MAX, float *v){
    /*Funcion para generar numeros aleatorios*/
    for(int i = 0; i < LEN; i++){
        v[i] = rand() % MAX;
    }
}

void cPromedio(int LEN, float *v, float *cprom){
    float sum = 0.0;
    for (int i = 0; i < LEN; i++){
        sum += v[i];
    }
    (*cprom) = sum/(float)LEN;
}
