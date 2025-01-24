#!/bin/bash

input_files=(
    "Jocs/Jocs_Sords/joc1Sord.scm"
    "Jocs/Jocs_Sords/joc2Sord.scm"
    "Jocs/Jocs_Sords/joc3Sord.scm"
    "Jocs/Jocs_Sords/joc4Sord.scm"
    "Jocs/Jocs_Sords/joc5Sord.scm"
    "Jocs/Jocs_Sords/joc6Sord.scm"
)

for input_file in "${input_files[@]}"; do
    output_file="${input_file%.scm}.out"
    python3 scheme.py "$input_file" > "$output_file"
    echo "Processed $input_file -> $output_file"
done

