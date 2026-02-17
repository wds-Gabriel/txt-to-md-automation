#!/bin/bash

# Defina o caminho absoluto da sua pasta principal
TARGET_DIR="/home/gab/Cérebro"

# -r: recursivo (monitora subpastas)
# -e: monitora criação, fechamento de escrita e movimentação
inotifywait -m -r -e close_write -e moved_to "$TARGET_DIR" --format '%w%f' | while read FULLPATH
do
    # Verifica se o arquivo termina com .txt
    if [[ "$FULLPATH" == *.txt ]]; then
        # Define o novo nome trocando .txt por .md
        NEWNAME="${FULLPATH%.txt}.md"
        
        # Copia o conteúdo para o novo arquivo .md
        cp "$FULLPATH" "$NEWNAME"
        
        # Se a cópia foi bem sucedida, remove o .txt
        if [ $? -eq 0 ]; then
            rm "$FULLPATH"
            echo "Sucesso: $FULLPATH convertido e removido."
        fi
    fi
done
