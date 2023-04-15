#
# Author: Ice.Marek
# 2023 IceNET Technology
#
TARGET 		= rtos
GCC  		= arm-none-eabi-gcc
OBJCOPY    	= arm-none-eabi-objcopy
OBJDUMP		= arm-none-eabi-objdump

CFLAGS=-Wall -Wextra -mfloat-abi=softfp -mthumb -mcpu=cortex-m4 -g -nostartfiles

LDSCRIPT=linker/k64f.ld

ASM_SOURCES = $(shell find . -name "*.s")
GCC_SOURCES = $(shell find . -name "*.c")

INCLUDES=\
-Iinclude\
-IFreeRTOS/include\
-IFreeRTOS/config\
-IFreeRTOS/portable/GCC/ARM_CM4F\

GCC_OBJECTS = $(GCC_SOURCES:.c=.o)

all: elf hex bin size

elf: $(TARGET)

$(TARGET): $(GCC_OBJECTS)
	$(GCC) $(CFLAGS) -T $(LDSCRIPT) $(ASM_SOURCES) $^ -o $@ 

%.o: %.c
	$(GCC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

hex: $(TARGET)
	$(OBJCOPY) $(TARGET) -O ihex $(TARGET).hex

bin: $(TARGET)
	$(OBJCOPY) $(TARGET) -O binary $(TARGET).bin

size:
	arm-none-eabi-size $(TARGET)

clean:
	rm -f $(GCC_OBJECTS) $(TARGET) $(TARGET).hex $(TARGET).bin $(TARGET).map

.PHONY: all elf hex bin size clean
