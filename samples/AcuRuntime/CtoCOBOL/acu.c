#include <stdio.h>
#include <sub.h>
#include <acusetjmp.h>

int
main(int argc, char * argv[]) {
  char * initv[3];
  struct a_cobol_info cblinfo;
  initv[0] = argv[0];
  initv[1] = "-c";
  initv[2] = "myconfig";
  acu_initv(3, initv);
  memset( & cblinfo, 0, sizeof(cblinfo));
  cblinfo.a_cobol_info_size = sizeof(cblinfo);
  cblinfo.pgm_name = "MYCBLPGM";
  acu_cobol( & cblinfo);
  acu_shutdown(1);
  return 0;
}