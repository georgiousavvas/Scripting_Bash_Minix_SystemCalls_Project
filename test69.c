#include <stdio.h>
#include <sys/types.h>
#include <mycalls.h>
#include <sys/stat.h>
#include <stdlib.h>

int main(int argc , char *argv[]){
	int numofproc = 0;
	numofproc = procnum();
	printf("%d\n" , numofproc); 
}
