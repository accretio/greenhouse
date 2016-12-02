include <data.scad>
include <local.scad>
include <wireframe.scad>
use <bottom_6joints.scad>
use <bottom_5joints.scad>
include <bottom_2joints.scad>


module create_beam6_color(points, beam, color, prepareForStl, pos) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];
     p4p = points[beam[3]];
     p5p = points[beam[4]];
     p6p = points[beam[5]];
     p7p = points[beam[6]];
     
     if (color == 0) {
          prepare_for_stl_(p1p, p2p, p3p, prepareForStl, pos) {
               black_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else if (color == 1) {
          prepare_for_stl_(p1p, p3p, p7p, prepareForStl, pos) {
               red_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else if (color == 2) {
          prepare_for_stl_(p1p, p4p, p2p, prepareForStl, pos) {
               green_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else if (color == 3) {
          prepare_for_stl_(p1p, p5p, p6p, prepareForStl, pos) {
               orange_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else if (color == 4) {
          prepare_for_stl_(p1p, p6p, p4p, prepareForStl, pos) {
               pink_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else if (color == 5) {
          prepare_for_stl_(p1p, p7p, p5p, prepareForStl, pos) {
               blue_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
               children();
          }
     } else {
          echo("unknown color");
     }
     
}

module create_beam5_color(points, beam, color, prepareForStl, pos) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];
     p4p = points[beam[3]];
     p5p = points[beam[4]];
     p6p = points[beam[5]];
    
     if (color == 0) {
          prepare_for_stl_(p1p, p2p, p4p, prepareForStl, pos) {
               purple_beam(p1p, p2p, p3p, p4p, p5p, p6p);
               children();
          }
     } else if (color == 1) {
          prepare_for_stl_(p1p, p3p, p2p, prepareForStl, pos) {
               silver_beam(p1p, p2p, p3p, p4p, p5p, p6p);
               children();
          }
     } else if (color == 2) {
          prepare_for_stl_(p1p, p4p, p6p, prepareForStl, pos) {
               olive_beam(p1p, p2p, p3p, p4p, p5p, p6p);
               children();
          }
     } else if (color == 3) {
          prepare_for_stl_(p1p, p5p, p3p, prepareForStl, pos) {
               tomato_beam(p1p, p2p, p3p, p4p, p5p, p6p);
               children();
          }
     } else if (color == 4) {
          prepare_for_stl_(p1p, p6p, p5p, prepareForStl, pos) {
               cyan_beam(p1p, p2p, p3p, p4p, p5p, p6p);
               children();
          }
     } else {
          echo("unknown color");
     }
     
}

module create_beam4_color(points, beam, color, prepareForStl, pos) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];

     if (color == -4) {
          prepare_for_stl_(p1p, p2p, p3p, prepareForStl, pos) {
               beam1(p1p, p2p, p3p);
               children();
          }
     } else if (color == -3 ) {
          prepare_for_stl_(p1p, p3p, p2p, prepareForStl, pos) {
               beam2(p1p, p2p, p3p);
               children();
          }
     }  else {
          echo("unknown color");
     }
      
}


module assemble_beam(points, beam, c, prepareForStl, pos) {
     if (len(beam) == 7) {
          create_beam6_color(points, beam, c, prepareForStl, pos) {
               children();
          }
     } else if (len(beam) == 6) {
          create_beam5_color(points, beam, c, prepareForStl, pos) {
               children();
          }
     } else if (len(beam) == 3) {
          create_beam4_color(points, beam, c, prepareForStl, pos) {
               children();
          }
     } else {
          echo("MISSING BEAM");
     }
}
module create_beams(points, beams) {
     
     for (beam=beams) {

          points1 = beam[1];
          color1 = beam[2];
          points2 = beam[4];
          color2 = beam[5];
          pos = beam[6];

          echo("beam");
          echo(points1);
          echo(color1);
          echo(points2);
          echo(color2);
          assemble_beam(points, points1, color1, true, pos) {
         
               assemble_beam(points, points2, color2); 
          }

         
        
          
     
         
          
     }
     
}
 
