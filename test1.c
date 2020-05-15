#include <stdio.h>
#include <sys/types.h>
#include <mycalls.h>
#include <sys/stat.h>
#include <stdlib.h>

int main(int argc , char *argv[]){
	if(argc==2){
		int gpid = atoi(argv[1]);
		printf("given id is %d\n",gpid);
		int ans = fatherpid(gpid);
		int trialid;
			if(ans==0){
				printf("couldnt find process");
			}else{
				printf("father pid is : %d \n" ,ans);
				trialid = fork();
				ans = fatherpid(trialid);
				printf("new fatherpid is : %d" , ans);
				
			}
	}
	else{
		printf("wrong arguments\n");
	}
}
