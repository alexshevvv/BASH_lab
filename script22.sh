#!/bin/bash

#проверяем наличия аргумента
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

#задаём имя входного файла
input_file="$1"

#создаём промежуточный файл с уникальными словами
uniq_words_file="words.txt"
cat "$input_file" | tr -s ' ' '\n' | sort -u > words

#создаём файл со статистикой появления уникальных слов
stat_file="stat.txt"
cat "$input_file" | tr -s ' ' '\n' | sort | uniq -c | awk '{print $2":"$1}' > stat

#удаление промежуточных файлов при завершении
trap 'rm -f "$uniq_words_file" "$stat_file"' EXIT

echo "Execution completed successfully. Results are saved in $uniq_words_file and $stat_file."
exit 0
