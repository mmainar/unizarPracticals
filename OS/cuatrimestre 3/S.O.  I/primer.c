/*primer.c*/

main() {
	int id, fd[2];
	
	
	id=fork();
	pipe(fd);
	switch( id ) {
		case -1: exit(1);
		case 0:  /*hijo*/
			close(0);
			dup(fd[0]);
			close(fd[0]);
			close(fd[1]);
			execp("segun","segun",0);
			exit(1);
	        case 1: /*padre*/
			close(1);
			dup(fd[1]);
			close(fd[0]);
			close(fd[1]);
			execp("segun","segun",0);
			exit(1);
	}
	exit(0);
}