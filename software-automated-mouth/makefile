# Summary of what makefile does
#
# In-case you wanted to do it manually :
#
#cc65 -O --cpu 6502 -t atari ./src/main.c -o ./obj/main.s
#ca65 -t atari ./obj/main.s -o ./obj/main.o
#ld65 -C ./atari.cfg -o ./obj/main.xex ./obj/main.o atari.lib
#atari800 -run ./obj/main.xex
#

CWD = $(shell pwd)

RM = /usr/bin/rm
CC = $(CC65_HOME)/bin/cc65
CA = $(CC65_HOME)/bin/ca65
LD = $(CC65_HOME)/bin/ld65
EMU = $(A8_EMULATOR)

C_FLAGS = -O --cpu 6502 -t atari
S_FLAGS = -t atari

C_SRC = $(shell ls src/*.c 2>/dev/null)
S_SRC = $(shell ls src/*.s 2>/dev/null)

C_OBJS  = $(addprefix obj/, $(notdir $(C_SRC:.c=.o)))
S_OBJS  = $(addprefix obj/, $(notdir $(S_SRC:.s=.o)))

# Build Target
#
TARGET = main.c

build : $(C_OBJS) $(S_OBJS)
	$(LD) -C ./atari.cfg -o ./obj/main.xex $(C_OBJS) $(S_OBJS) atari.lib

run :
	$(A8_EMULATOR) -run obj/main.xex

all : clean build run

# Display variables
#
vars : 
	@ echo Display Variables:
	@ echo
	@ echo C_SRC  = $(C_SRC)
	@ echo S_SRC  = $(S_SRC)
	@ echo C_OBJS = $(C_OBJS)
	@ echo S_OBJS = $(S_OBJS)

# Build files
#
obj/%.s : src/%.c
	$(CC) $(C_FLAGS) -o $@ $<

obj/%.o : obj/%.s
	$(CA) $(S_FLAGS) -o $@ $<

# Clean
#
clean :
	$(RM) -f obj/*.*


# Remove builtin rules
#
.SUFFIXES:
