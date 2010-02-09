#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/reboot.h>

#include "webs.h"
#include "wive_asp.h"

#ifdef MIPS
	WIVE_CONFIG_PATH = "/dev/mtd2";
#else
	WIVE_CONFIG_PATH = "/home/zdjur/test.bin";
#endif

int executeCommand(int eid, webs_t wp, int argc, char_t **argv)
{
    FILE *fp;
    char path[1035];
    fprintf(stderr,"Executing : %s\n",argv[0]);
    fp = popen(argv[0], "r");
    if (fp == NULL) {
	websWrite(wp, "Failed to run command\n" );
        return 0;
    }
    while (fgets(path, sizeof(path)-1, fp) != NULL) {
          websWrite(wp, path);
    }
    pclose(fp);
    return 1;
}

void formCommands(webs_t wp, char_t *path, char_t *query)
{
	char_t *strRequest;

	strRequest = websGetVar(wp, T("command"), T(""));
	fprintf(stderr, "Command '%s'",strRequest);

	if (strcmp(strRequest, "reboot") == 0){
		fprintf(stderr, "Rebooting ....");
		websDone(wp, 200);
#ifdef MIPS
		reboot( RB_AUTOBOOT );
#endif	
		return;
	}
	websWrite(wp, "Unknown command\n");
	websDone(wp, 500);
}

void formSaveConfig(webs_t wp, char_t *path, char_t *query)
{
	char_t *strRequest;
	int len = 1024;
	int r = 0;
	CONFIG_DATA_T type = 0;
	char *buf = NULL;
	FILE*fp;

	buf = malloc(len);
	if ( buf == NULL ) {
		websWrite(wp, "Allocate buffer failed!\n" );
		return;
	}

	strRequest = websGetVar(wp, T("save-boot"), T(""));
	if (strRequest[0])
		type |= BOOT_SETTING;

	strRequest = websGetVar(wp, T("save-current"), T(""));
	if (strRequest[0])
		type |= CURRENT_SETTING;

	if (type) {
		websWrite(wp, "HTTP/1.0 200 OK\n");
		websWrite(wp, "Content-Type: application/octet-stream;\n");
		websWrite(wp, "Content-Disposition: attachment;filename=\"config.dat\" \n");
		websWrite(wp, "Pragma: no-cache\n");
		websWrite(wp, "Cache-Control: no-cache\n");
		websWrite(wp, "\n");

		if (type & BOOT_SETTING) {
			fp = fopen ( WIVE_CONFIG_PATH,"r" ) ;
			if( fp == NULL ){
				return;
			}
			int total = 0;
			while (!feof(fp)){
				r = fread(buf, len, 1, fp);
				total+=r*len;
				websWriteDataNonBlock(wp, buf, r*len);
			}
			fclose(fp);	
			fprintf(stderr, "%s Total %d bytes.\n",strRequest, total);
		}
		websDone(wp, 200);
		free(buf);
		return;
	}
}

