/* billy.c
 * Curso Unix
 * Mata procesos.
 * Sobre una idea de Kernighan & Pike (The Unix Programming Environment)
 * Uso: billy [proc_name]
 *       Si no se especifica argumento, recorre los procesos de usuario.
 * BUGS: problemas de compatibilidad con BSD
 * Propuestas de trabajo: implementar popen().
 */

#include<stdio.h>
#include<signal.h>

char *progname;
char ps[20];


main(argc, argv)
int argc;
char *argv[];
{
       FILE *fin, *popen();
       char buf[BUFSIZ];
       int pid;

       strcpy( ps, "ps -u ");
       strcat( ps, getenv( "LOGNAME" ));

       progname = argv[0];
       if( (fin = popen( ps, "r" )) == NULL ){
               fprintf( stderr, "%s: can't run %s\n", progname, ps);
               exit( 1 );
       }
       fgets( buf, sizeof buf, fin );

       fprintf( stderr, "%s", buf );
       while( fgets( buf, sizeof buf, fin) != NULL )
               if( argc == 1 || strindex( buf, argv[1] ) >= 0 ) {
                       buf[strlen(buf)-1] = '\0';
                       sscanf( buf, "%d", &pid );
                       if( (pid != getpid())
                          && (pid != getppid())
                          && strindex( buf, progname) == -1
                          && strindex( buf, "sh" ) == -1
                          && strindex( buf, "ps" ) == -1){
                               fprintf( stderr, "%s? ", buf );
                               if( getanswer() )
                                       kill( pid, SIGKILL );
                       }
               }
       exit( 0 );
}

int strindex( s, t )
char *s, *t;
{
       int i, n;

       n = strlen( t );

       for( i = 0; s[i] != '\0'; i++ )
               if( strncmp( s+i, t, n) == 0 )
                       return i;
       return -1;
}


int getanswer()
{
       char ch;
       fflush( stdin );
       while( ch = getchar() ){
               switch( ch ){
               case  'y':
                       ;
               case 'Y':
                       ;
               case 's':
                       ;
               case 'S' :
                       ;
                       return 1;
               case 'n':
                       ;
               case 'N':
                       return 0;
               default:
                       fprintf(stderr, "\n\tAnswer (y)es or (n)ot: " );
               }
       }
}