#/bin/bash

OPENSCAD=/Volumes/OpenSCAD/OpenSCAD.app/Contents/MacOS/OpenSCAD


for i in `seq 0 54`;
do
    echo $i
    ${OPENSCAD} -D start=$i -D end=$i -o stl/splitted_beams_$i.stl src/dome.scad
done    
