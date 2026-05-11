# --- SEZIONE VARIABILI ---

CC = gcc                           # Definisce il compilatore da usare (GNU C Compiler)
CFLAGS = -Wall -std=c99 -D_GNU_SOURCE
#CFLAGS = -Wall -std=c99            # Opzioni: mostra tutti gli avvisi (-Wall) e usa lo standard C99
TARGET = hello                     # Definisce il nome dell'eseguibile finale che otterrai
SRC = hello.c                      # Indica il file sorgente che contiene il tuo codice
OBJ = hello.o                      # Indica il file "oggetto" (codice macchina intermedio)

# --- REGOLE DI COMPILAZIONE ---
# Obiettivo predefinito: viene eseguito quando digiti solo 'make'
all: $(TARGET)                     # Dice a Make che per completare 'all' deve creare 'hello'

# Fase di Linking: crea l'eseguibile finale assemblando i file oggetto
$(TARGET): $(OBJ)                  # Per produrre 'hello' (target) serve 'hello.o' (dipendenza)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ) 
                                   # Comando: unisce gli oggetti nell'eseguibile finale (-o)

# Fase di Compilazione: trasforma il codice sorgente (.c) in codice oggetto (.o)
$(OBJ): $(SRC)                     # Per produrre 'hello.o' serve il file 'hello.c'
	$(CC) $(CFLAGS) -c $(SRC)      # Il flag -c compila senza linkare (crea solo il file .o)

# --- COMANDI DI UTILITY ---

# Esegue il programma dopo averlo compilato
run: $(TARGET)                     # Controlla che 'hello' sia aggiornato prima di avviarlo
	./$(TARGET)                    # Lancia l'eseguibile nella cartella corrente

# Pulisce la cartella dai file creati per ricominciare da zero
clean:
	rm -f $(OBJ) $(TARGET)         # Rimuove l'oggetto (.o) e l'eseguibile (hello)

# Istruzione speciale per evitare conflitti con file reali
.PHONY: all run clean              # Specifica che questi non sono file, ma solo nomi di comandi