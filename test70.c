#include <stdio.h>
#include <sys/types.h>
#include <mycalls.h>
#include <sys/stat.h>
#include <stdlib.h>

int main(int argc , char *argv[]){
	if(argc==2){
		int givenpid = atoi(argv[1]);
		int ans;
		ans = fatherpid(givenpid);
		if(ans == 0 ){
			printf("process doesnt exists , returned value : %d \n" , ans); 
		}else{
			printf("pid of process father , returned value : %d \n", ans);
		}
	}
}
