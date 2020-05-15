#include <lib.h>
#include <unistd.h>

int procnum(){

	message m;
	return(_syscall(PM_PROC_NR,PROCNUM,&m));
}

int fatherpid(int childpid ){
	message m;
	m.m1_i1 = childpid;
	return(_syscall(PM_PROC_NR,FATHERPID,&m));

}
