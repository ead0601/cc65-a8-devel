#include <stdio.h>
#include <atari.h>

unsigned char tempo = 1;

int note_count = 28;
unsigned char duration[28] = {1,1,1,2,2,2,3,6,
                              3,2,2,2,1,1,1,
                             1,1,2,2,2,3,6,
                             3,2,2,2,1,1};

unsigned char volume[28] = {24,25,26,27,28,29,30,31,
                             30,29,28,27,26,25,24,
                             23,22,21,20,19,18,17,
                             18,19,20,21,22,23};


int main (void)
{
 int i,j;
 unsigned char vol, dur;

// Init control regs
POKEY_WRITE.audctl = 0x0;
POKEY_WRITE.skctl = 0x3;

// Kill interrupts
ANTIC.nmien = 0x0;        // kill VBIs
POKEY_WRITE.irqen = 0x0;  // kill irqs
ANTIC.dmactl = 0x0;       // kill dma

while (1) {

    // Play Notes
    for(i=0;i<28;i++){

        vol = volume[i];
        dur = duration[i];

        POKEY_WRITE.audc1 = vol;
        //POKEY_WRITE.audc2 = vol;
        //POKEY_WRITE.audc3 = vol;
        //POKEY_WRITE.audc4 = vol;


        // Wait for tempo
        for (j=0;j<tempo;j++) {
            ;
        }

        // Wait for duration
        for (j=0;j<dur;j++) {
            ;
        }

        if (tempo > 1000) tempo = 1;
        else tempo=tempo+1;

    }
}

 return 0;
}
