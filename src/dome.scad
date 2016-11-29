include <data.scad>
include <local.scad>
include <wireframe.scad>
use <spatial.scad>
use <bottom_6joints.scad>

beams6 = [
     [14, 12, 13, 7, 33, 34, 4],
     [28, 27, 15, 2, 34, 35, 7],
     [31, 18, 30, 4, 38, 33, 1],
     [33, 4, 31, 14, 11, 34, 38],
     [34, 7, 14, 28, 11, 35, 33],
     [35, 2, 28, 37, 11, 36, 34],
     [36, 10, 37, 39, 11, 38, 35],
     [37, 40, 29, 10, 35, 36, 2],
     [38, 1, 39, 31, 11, 33, 36],
     [39, 41, 10, 32, 38, 1, 36]
     ];

beams5 = [
     [11, 34, 33, 35, 36, 38]
     ];

create_wire(points2, triangles2);
 

module create_beams6(points, beams) {
     beam = beams[0];
     //for(beam=beams) {
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          p4p = points[beam[3]];
          p5p = points[beam[4]];
          p6p = points[beam[5]];
          p7p = points[beam[6]];

         green_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
         red_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
            
          blue_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p); 
          pink_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          orange_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p); 
          
          black_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          
    // }
     
}


create_beams6(points2, beams6);




//


