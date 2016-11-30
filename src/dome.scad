include <data.scad>
include <local.scad>
include <wireframe.scad>
use <spatial.scad>
use <bottom_6joints.scad>
use <bottom_5joints.scad>
include <bottom_2joints.scad>



beams5 = [
     [1, 38, 39, 31, 32, 30],
     [2, 35, 28, 37, 27, 29],
     [4, 33, 31, 14, 18, 13],
     [7, 34, 14, 28, 12, 15],
     [10, 36, 37, 39, 40, 41],
    // [11, 34, 35, 33, 36, 38],
     ];


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

beams2 = [
     [12, 14, 7],
     [13, 14, 4],
     [15, 7, 28],
     [18, 4, 31],
     [27, 28, 2],
     [29, 2, 37],
     [30, 31, 1],
     [32, 1, 39],
     [40, 10, 37],
     [41, 10, 39],
     ];

module create_beams6(points, beams) {
     for(beam=beams) {
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
          
     }
     
}


//create_wire(points2, triangles2);
//create_beams6(points2, beams6);
//create_beams5(points2, beams5);

 

difference() {

    create_beams2(points2, beams2);
     translate([500, 0, 0]) {
         cube([1000, 1000, 1000], center=true);
     } 
      
    }
     


 
 
  
 
