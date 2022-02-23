# cc65-a8-devel

This is a simple makefile driven enviroment to build applications for the atari 800. There is a setup-tools.sh script that will help pull in the correct cc65 repository and required emulator. The hello-world is a simple test program within the cc65 enviroment.

Please see https://cc65.github.io/doc/intro.html for more details on atari.cfg and the build process.

Directory structure:

<br />
...[repo dir]<br />
.......[tools dir]<br />
.......[cc65-a8-devel]<br />
............[hello-world]<br />
................make clean<br />
................make build<br />
................make run<br />
................make all<br />
............[software-automated-mouth]<br />
............[civone] . . <br />
............[other-repos]<br />
<br />

The goal is to have serveral projects that can be built,and possibly with a library of optimized atari 8bit libraries that can be reused.

Each program has a main.c, and will reuse the same makefile that builds all .c and .s files and links them together. The make options are:

make clean
make build
make run
make all
make vars

Ping me on discord if you have any questions, dotmatrix#5268

