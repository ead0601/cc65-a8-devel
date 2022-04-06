#include <atari.h>
#include <string.h>
//#include <atari_screen_charmap.h>

#define ScreenMemory        ((unsigned char *) 0x3000)
#define DisplayListMemory   ((unsigned char *) 0x5000) 

void DisplayList =
{
    DL_BLK8,
	DL_BLK8,
	DL_BLK4,
	DL_LMS(DL_CHR40x8x4),
	ScreenMemory,
    DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
	DL_CHR40x8x4,
    DL_JVB,
    DisplayListMemory
};

int main (void)
{
int  i;
char j;
int  k;

memcpy((void*) DisplayListMemory,&DisplayList,sizeof(DisplayList)); 

OS.sdlst = 	(void*)DisplayListMemory; 

j=0; 

while (1) {

  for (i=0;i<(40*24);i++) {
    ScreenMemory[i] = j;
    //j++;
  }  
  j++;

  //DELAY
  for (k=0;k<10000;k++) {
      ;
  }

}

 return 0;
}
