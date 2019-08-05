TARGET=rtos
CC=arm-none-eabi-gcc
OBJCPY=arm-none-eabi-objcopy
CFLAGS=-Wall -Wextra -mfloat-abi=softfp -mthumb -mcpu=cortex-m4 -g -nostartfiles
LDSCRIPT=linker/k64f.ld
SRCS=\
    startup/startup.s \
    startup/startup.c \
    rtos/portable/GCC/ARM_CM4F/port.c \
    rtos/portable/MemMang/heap_1.c \
    rtos/event_groups.c \
    rtos/list.c \
    rtos/queue.c \
    rtos/tasks.c \
    rtos/timers.c \
    rtos/croutine.c \
    rtos/stream_buffer.c \
    app/main.c \

INCLUDES=\
    -Iinclude \
    -Irtos/include \
    -Irtos/config \
    -Irtos/portable/GCC/ARM_CM4F \

all:
	$(CC) $(INCLUDES) $(SRCS) $(CFLAGS) -T $(LDSCRIPT) -o $(TARGET).elf
	$(OBJCPY) rtos.elf rtos.bin -O binary

clean:
	rm $(TARGET).elf $(TARGET).bin
