include <data.scad>
include <local.scad>
include <wireframe.scad>
use <bottom_6joints.scad>
use <bottom_5joints.scad>
include <bottom_2joints.scad>


module create_beam6_color(points, beam, color, prepareForStl, pos, label) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];
     p4p = points[beam[3]];
     p5p = points[beam[4]];
     p6p = points[beam[5]];
     p7p = points[beam[6]];
     
     if (color == 0) {
          prepare_for_stl_(p1p, p2p, p3p, prepareForStl, pos) {
               black_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          }
     } else if (color == 1) {
          prepare_for_stl_(p1p, p3p, p7p, prepareForStl, pos) {
               red_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          }
     } else if (color == 2) {
          prepare_for_stl_(p1p, p4p, p2p, prepareForStl, pos) {
               green_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          } 
     } else if (color == 3) {
          prepare_for_stl_(p1p, p5p, p6p, prepareForStl, pos) {
              orange_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          }
     } else if (color == 4) {
          prepare_for_stl_(p1p, p6p, p4p, prepareForStl, pos) {
               pink_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          }
     } else if (color == 5) {
          prepare_for_stl_(p1p, p7p, p5p, prepareForStl, pos) {
               blue_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p, label=label);
               children();
          }
     } else {
          echo("unknown color");
     }
     
}

module create_beam5_color(points, beam, color, prepareForStl, pos, label) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];
     p4p = points[beam[3]];
     p5p = points[beam[4]];
     p6p = points[beam[5]];
    
     if (color == 0) {
          prepare_for_stl_(p1p, p2p, p4p, prepareForStl, pos) {
               purple_beam(p1p, p2p, p3p, p4p, p5p, p6p, label=label);
               children();
          }
     } else if (color == 1) {
          prepare_for_stl_(p1p, p3p, p2p, prepareForStl, pos) {
               silver_beam(p1p, p2p, p3p, p4p, p5p, p6p, label=label);
               children();
          }
     } else if (color == 2) {
          prepare_for_stl_(p1p, p4p, p6p, prepareForStl, pos) {
               olive_beam(p1p, p2p, p3p, p4p, p5p, p6p, label=label);
               children();
          }
     } else if (color == 3) {
          prepare_for_stl_(p1p, p5p, p3p, prepareForStl, pos) {
               tomato_beam(p1p, p2p, p3p, p4p, p5p, p6p, label=label);
               children();
          }
     } else if (color == 4) {
          prepare_for_stl_(p1p, p6p, p5p, prepareForStl, pos) {
               cyan_beam(p1p, p2p, p3p, p4p, p5p, p6p, label=label);
               children();
          }
     } else {
          echo("unknown color");
     }
     
}

module create_beam4_color(points, beam, color, prepareForStl, pos, label) {

     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];

     if (color == -4) {
          prepare_for_stl_(p1p, p2p, p3p, prepareForStl, pos) {
               beam1(p1p, p2p, p3p, label=label);
               children();
          }
     } else if (color == -3 ) {
          prepare_for_stl_(p1p, p3p, p2p, prepareForStl, pos) {
               beam2(p1p, p2p, p3p, label=label);
               children();
          }
     }  else {
          echo("unknown color");
     }
      
}


module assemble_beam(points, beam, c, prepareForStl, pos, label) {
     if (len(beam) == 7) {
          create_beam6_color(points, beam, c, prepareForStl, pos, label=label) {
               children();
          }
     } else if (len(beam) == 6) {
          create_beam5_color(points, beam, c, prepareForStl, pos, label=label) {
               children();
          }
     } else if (len(beam) == 3) {
          create_beam4_color(points, beam, c, prepareForStl, pos, label=label) {
               children();
          }
     } else {
          echo(str("MISSING BEAM ", len(beam))) ;
     }
}


CutterHeight=20;

module tenon(tolerance) {
     cube([BeamDiameter/3*2-2*tolerance, 2-2*tolerance, 2*CutterHeight - 10*tolerance], center=true);
     translate([0, BeamDiameter/6-tolerance, 0]) {
          cube([2-2*tolerance, BeamDiameter/3-2*tolerance, 2*CutterHeight - 10*tolerance], center=true);
     }
     cylinder(CutterHeight-5*tolerance, BeamDiameter/4-tolerance, BeamDiameter/4-tolerance);
}

//tenon(0.0);

module cutter(hasTenon) {
     translate([0, 0, 0]) {
          difference() {
               translate([0, 0, -5*BeamDiameter]) {
                    cube([ 2*BeamDiameter, 2*BeamDiameter, 10*BeamDiameter], center=true);
               }
               if (hasTenon == false) {
               tenon(0.0);
               }
          }
          if (hasTenon) {
               tenon(0.0);
          }
     }
     
}
     
//cutter(true);

//tenon(0.1);

module create_beams(points, beams) {

     //  for(b = [0 : (len(beams) - 1)]) {
     for(b = [start : end]) {
          beam = beams[b];
          echo(beam);
          point1 = beam[0];
          points1 = beam[1];
          color1 = beam[2];
          point2 = beam[3];
          points2 = beam[4];
          color2 = beam[5];
          pos = beam[6];
          
          
          label = str(point1, " - ",   point2);


          difference() {
               translate([0, 0, 55]) {
                    assemble_beam(points, points1, color1, true, 0, label) {
                         assemble_beam(points, points2, color2); 
                    }
               }
              cutter(true); 
          } 
          
          translate([2+BeamDiameter, 0, 0]) {
               rotate([180, 0, 0]) {
                    intersection() {
                         translate([0, 0, 55]) {
                              assemble_beam(points, points1, color1, true, 0, label) {
                                   assemble_beam(points, points2, color2); 
                              }
                         }
                         cutter(false); 
                    }
               }
          } 
              
     }
          
     
         
          
}

     
 
