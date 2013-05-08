main(argc,argv)
int argc; char *argv[];
{
	int i,n,res=0;
	int *x,*y;
	
	n=atoi(argv[1]);
	x= malloc(n);
	y= malloc(n);
	for (i=0; i<n;i++)
		res+= x[i]*y[n-i-1];
	printf("res=%d\n",res);
}
