#!/bin/bash

base_dir="Jocs/Jocs_Read"

for i in {1..6}; do
    input_file="$base_dir/joc${i}Read.scm"
    input_redirect="$base_dir/joc${i}Read.inp"
    output_file="$base_dir/joc${i}Read.out"

    python3 scheme.py "$input_file" < "$input_redirect" > "$output_file"
    
    echo "Processed joc${i}Read: Input -> $input_redirect | Output -> $output_file"
done

