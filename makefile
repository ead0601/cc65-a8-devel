# Summary of what makefile does
#
# In-case you wanted to do it manually :
#
#cc65 -O --cpu 6502 -t atari ./src/main.c -o ./obj/main.s
#ca65 -t atari ./obj/main.s -o ./obj/main.o
#ld65 -C ./atari.cfg -o ./obj/main.xex ./obj/main.o atari.lib
#atari800 -run ./obj/main.xex
#

# Check for global flags
#
ifndef CC65_HOME
$(error CC65_HOME is not set)
endif

ifndef A8_EMULATOR
$(error A8_EMULATOR is not set)
endif

# Define variables
#
CWD = $(shell pwd)

RM = /usr/bin/rm
MD = /usr/bin/mkdir

GC = /usr/bin/gcc

CC = $(CC65_HOME)/bin/cc65
CA = $(CC65_HOME)/bin/ca65
LD = $(CC65_HOME)/bin/ld65

EMU = $(A8_EMULATOR)
APLAY = /usr/bin/aplay

C_FLAGS = -Cl -O --cpu 6502 -t atari
S_FLAGS = -t atari

C_SRC = $(shell ls src/*.c 2>/dev/null)
S_SRC = $(shell ls src/*.s 2>/dev/null)

C_OBJS  = $(addprefix obj/, $(notdir $(C_SRC:.c=.o)))
S_OBJS  = $(addprefix obj/, $(notdir $(S_SRC:.s=.o)))

OBJDIR  = ./obj

# Make obj directory
#
$(OBJDIR):
	mkdir $@ 2>/dev/null || true

# Build Target
#
TARGET = main.c

build : $(OBJDIR) $(C_OBJS) $(S_OBJS)
	$(LD) -m ./obj/map.txt -C ./atari.cfg -o ./obj/main.xex $(C_OBJS) $(S_OBJS) atari.lib

#$(LD) -m ./obj/map.txt -C ./atari.cfg -o ./obj/main.xex $(C_OBJS) $(S_OBJS) atari.lib

run :
	$(EMU) -run obj/main.xex

atari : clean build run

gcc : clean
	$(GC) -DGCC ./src/*.c -o ./obj/a.out
	./obj/a.out
	$(APLAY) ./out.wav

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
clean : $(OBJDIR)
	$(RM) -f obj/*.*


# Remove builtin rules
#
.SUFFIXES:

.SECONDARY:
