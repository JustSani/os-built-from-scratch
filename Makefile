CC := arm-none-eabi-gcc
# All generated files go here; `make clean` just deletes this directory.
BUILD_DIR := build
# Final linked image. .axf is ARM's name for an ELF carrying debug info.
BIN := $(BUILD_DIR)/scratch-os.axf



SOURCES := boot/startup.c src/main.c
OBJECTS := $(SOURCES:%.c=$(BUILD_DIR)/%.o)

CFLAGS := -mthumb -mcpu=cortex-m3
CFLAGS += -Wall -Wextra
CFLAGS += -O0 -g3

LDFLAGS := -T scripts/mps2_m3.ld
LDFLAGS += -Xlinker -Map=$(BUILD_DIR)/output.map
LDFLAGS += -nostdlib -lgcc


.PHONY: all clean run size disasm
all: $(BIN)

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN): $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTS) -o $(BIN)

run: $(BIN)
	qemu-system-arm -machine mps2-an385 -monitor null -semihosting \
	    --semihosting-config enable=on,target=native \
	    -kernel $(BIN) -serial stdio -nographic
size:
	arm-none-eabi-size $(BIN)

disasm:
	arm-none-eabi-objdump -d $(BIN)


clean:
	rm -rf $(BUILD_DIR)



