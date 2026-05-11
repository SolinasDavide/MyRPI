# Makefile for hello.c

CC = gcc
CFLAGS = -Wall -std=c99
TARGET = hello
SRC = hello.c
OBJ = hello.o

# Default target
all: $(TARGET)

# Build executable
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

# Compile source to object file
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

# Run the program
run: $(TARGET)
	./$(TARGET)

# Clean build artifacts
clean:
	rm -f $(OBJ) $(TARGET)

# Phony targets (not actual files)
.PHONY: all run clean
