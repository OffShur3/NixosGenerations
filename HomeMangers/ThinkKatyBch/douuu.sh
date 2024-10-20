#!/bin/bash

echo "Introduce el texto (Ctrl+D para finalizar):"

# Almacenar el input en un array
input=()

# Leer todas las líneas del input hasta Ctrl+D
while IFS= read -r line; do
    input+=("$line")
done

# Crear una variable para almacenar el texto formateado
output=""

# Concatenar 'pkgs.' a cada línea y agregarlo al output
for line in "${input[@]}"; do
    output+="pkgs.$line\n"
done

# Copiar el resultado al portapapeles usando xclip
echo -e "$output" | xclip -selection clipboard

# Confirmar al usuario que se copió al portapapeles
echo "Texto copiado al portapapeles."
