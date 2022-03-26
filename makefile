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

CL = $(CC65_HOME)/bin/cl65

EMU = $(A8_EMULATOR)
APLAY = /usr/bin/aplay

C_FLAGS = -g -r -DPOKEY -m ./obj/map.txt -l ./obj/listing.txt -T -Cl -Osir --cpu 6502 -t atari

C_SRC = $(shell ls src/*.c 2>/dev/null)
S_SRC = $(shell ls src/*.s 2>/dev/null)

OBJDIR  = ./obj

# Make obj directory
#
$(OBJDIR):
	mkdir $@ 2>/dev/null || true

# Build Target
#
TARGET = main.c

# -I $(CC65_HOME)/include -L $(CC65_HOME)/lib 
build : clean $(OBJDIR) $(C_SRC) $(S_SRC)
	$(CL) $(C_FLAGS) -C ./atari.cfg -o ./obj/main.xex $(C_SRC) $(S_SRC) atari.lib

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

# Clean
#
clean : $(OBJDIR)
	$(RM) -f obj/*.*

# Remove builtin rules
#
.SUFFIXES:

.SECONDARY:
