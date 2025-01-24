#!/bin/bash

# Esborrem el contingut del fitxer de sortida si existeix
> Jocs/Jocs_Error/sortida.out

for i in {1..10}
do
    echo "Test $i:" > Jocs/Jocs_Error/temp.out
    python3 scheme.py Jocs/Jocs_Error/err$i.scm 2>> Jocs/Jocs_Error/temp.out
    echo "" >> Jocs/Jocs_Error/temp.out
    cat Jocs/Jocs_Error/temp.out >> Jocs/Jocs_Error/sortida.out
done

# Esborrem el fitxer temporal
rm Jocs/Jocs_Error/temp.out
