TARGET=rtos
CC=arm-none-eabi-gcc
OBJCPY=arm-none-eabi-objcopy
CFLAGS=-Wall -Wextra -mfloat-abi=softfp -mthumb -mcpu=cortex-m4 -g -nostartfiles
LDSCRIPT=linker/k64f.ld
SRCS=\
startup/startup.c \
rtos/list.c \
rtos/event_groups.c \
rtos/croutine.c \
rtos/timers.c \
rtos/stream_buffer.c \
rtos/portable/MemMang/heap_1.c \
rtos/portable/GCC/ARM_CM4F/port.c \
rtos/tasks.c \
rtos/queue.c \
app/main.c \

INCLUDES=\
-Irtos/include \
-Irtos/config \
-Irtos/portable/GCC/ARM_CM4F \
-Iinclude \

all:
	$(CC) $(INCLUDES) $(SRCS) $(CFLAGS) -T $(LDSCRIPT) -o $(TARGET).elf
	$(OBJCPY) rtos.elf rtos.bin -O binary

clean:
	rm $(TARGET).elf $(TARGET).bin
