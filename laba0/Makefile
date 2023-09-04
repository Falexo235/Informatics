# Makefile for compiling multiple Pascal programs


# Pascal compiler
PASCAL_COMPILER = fpc

# Source files (update with your file names)
SOURCE_FILES = exercise1.pas exercise2.pas exercise3.pas exercise4.pas exercise5.pas

# Output directory for executables
OUTPUT_DIR = bin

# Generate executable names from source file names
EXECUTABLES = $(patsubst %.pas,$(OUTPUT_DIR)/%.exe,$(SOURCE_FILES))

# Compilation flags (if needed)
COMPILER_OPTIONS =

# Default target: build all executables
all: | $(OUTPUT_DIR) $(EXECUTABLES)

# Rule to build each executable from its corresponding source file
$(OUTPUT_DIR)/%.exe: %.pas
	$(PASCAL_COMPILER) $(COMPILER_OPTIONS) -o$@ $<	
# mkdir /p $(OUTPUT_DIR)

$(OUTPUT_DIR):
	@mkdir $(OUTPUT_DIR)

# Clean rule: remove all executables and the output directory
clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean
