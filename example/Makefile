# Makefile для компиляции Pascal-приложения

# Имя компилятора Pascal (зависит от вашего компилятора)
PASCAL_COMPILER = fpc

# Имя выходного исполняемого файла: Всегда app.exe для понятности
OUTPUT_FILE = app.exe

# Список исходных файлов (.pas)
SOURCE_FILES = example.pas # exercise2.pas exercise3.pas exercise4.pas exercise5.pas

# Опции компилятора (если необходимо)
COMPILER_OPTIONS =

all: $(OUTPUT_FILE)

$(OUTPUT_FILE): $(SOURCE_FILES)
	$(PASCAL_COMPILER) $(COMPILER_OPTIONS) -o$(OUTPUT_FILE) $(SOURCE_FILES)

clean:
	rm -f $(OUTPUT_FILE)

.PHONY: all clean
