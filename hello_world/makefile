

#cc65 -O --cpu 6502 -t atari ./src/hello.c -o ./obj/hello.s
#ca65 -t atari ./obj/hello.s -o ./obj/hello.o
##ld65 -C ./atari.cfg -o ./obj/hello.xex ./obj/atari.o ./obj/hello.o atari.lib
#ld65 -C ./atari.cfg -o ./obj/hello.xex ./obj/hello.o atari.lib
#atari800 -run ./obj/hello.xex

CWD = $(shell pwd)

RM = /usr/bin/rm
CC = $(CC65_HOME)/bin/cc65
CA = $(CC65_HOME)/bin/ca65
LD = $(CC65_HOME)/bin/ld65
EMU = $(A8_EMULATOR)

C_FLAGS = -O --cpu 6502
S_FLAGS = -t atari

C_SRC = $(shell ls src/*.c 2>/dev/null)
S_SRC = $(shell ls src/*.s 2>/dev/null)

C_OBJS  = $(addprefix obj/, $(notdir $(C_SRC:.c=.o)))
S_OBJS  = $(addprefix obj/, $(notdir $(S_SRC:.s=.o)))


# Build Target
#
TARGET = hello

$(TARGET) : $(C_OBJS) $(S_OBJS)
	$(LD) -C ./atari.cfg -o ./obj/hello.xex $(C_OBJS) $(S_OBJS) atari.lib


# Display variables
#
vars : 
	@ echo variables
	@ echo $(C_SRC)
	@ echo $(S_SRC)
	@ echo $(C_OBJS)

# Build files
#
obj/%.s : src/%.c 
	$(CC) $(C_FLAGS) $< -o $@ 

obj/%.o : src/%.s 
	$(CA) $(S_FLAGS) $< -o $@


# Clean
#
clean :
	$(RM) -f obj/*.*

