include <data.scad>
include <local.scad>
include <wireframe.scad>
include <utils.scad>

/*
      p2
  p4      p3
      p1 
  p6      p5

*/

beam = [2, 35, 28, 37, 27, 29]; //[11, 34, 33, 35, 36, 38];

module purple_tenon(tolerance=0.0) {
     translate([0, 0, -BeamDiameter/4]) {
          cube([BeamDiameter, BeamDiameter/4, BeamDiameter/8], center=true);
     }
     translate([BeamDiameter/2, -BeamDiameter/8, BeamDiameter/4]) {
          cube([BeamDiameter, BeamDiameter/4, BeamDiameter/8], center=true);
     }
}

module tomato_tenon(tolerance=0.0) {
     rotate([0, 0, 0]) {
          translate([BeamDiameter/2 + tolerance, 0, -BeamDiameter/8]) {
         
               cube([BeamDiameter/2, BeamDiameter/2-(2*tolerance), BeamDiameter/4 -(2*tolerance) ], center=true);
          }
     }
}

module silver_tenon(tolerance=0.0) {
     rotate([-10, 0, 0]) {
          translate([BeamDiameter/2 + tolerance, BeamDiameter/8, 0]) {
               cube([BeamDiameter, BeamDiameter/2-(2*tolerance), BeamDiameter/4 -(2*tolerance) ], center=true);
          }
     }
     translate([BeamDiameter/2 + tolerance, -BeamDiameter/8, BeamDiameter/3]) {
          cube([BeamDiameter, BeamDiameter/8-(2*tolerance), BeamDiameter/8 -(2*tolerance) ], center=true);
     }
}

module olive_tenon(tolerance=0.0) {
     rotate([20, 0, 0]) {
          translate([BeamDiameter/8 + tolerance, 0, -BeamDiameter/4]) {
               cube([BeamDiameter/3, BeamDiameter/2-(2*tolerance), BeamDiameter/4 -(2*tolerance) ], center=true);
          }
     }
}

module purple_beam(p1, p2, p3, p4, p5, p6) {
     difference() {
          beam(p1, p2, p4, "purple", label="R") {
               union() {
                    translate([-BeamDiameter/4 * 3, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
                    translate([-BeamDiameter/4, -BeamDiameter/8, BeamDiameter/2 - BeamDiameter/16]) {
                         cube([2*BeamDiameter, BeamDiameter/4, BeamDiameter/4], center=true); 
                    }
                    translate([-BeamDiameter/4, 0, -BeamDiameter/2 + BeamDiameter/16]) {
                         cube([2*BeamDiameter, BeamDiameter/4, BeamDiameter/4], center=true); 
                    } 
               }
          };
          
     }
     
     in_beam_referential(p1, p2, p4) {
          purple_tenon();
     }
     
}



module cyan_beam(p1, p2, p3, p4, p5, p6) {
    
     difference() {
          beam(p1, p6, p5, "cyan", label="R") {
               translate([-BeamDiameter - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          } ;
          
          olive_beam(p1, p2, p3, p4, p5, p6);
          
          in_beam_referential(p1, p5, p3) {
               tomato_tenon();
          }
          
          purple_beam(p1, p2, p3, p4, p5, p6);
          silver_beam(p1, p2, p3, p4, p5, p6);
          in_beam_referential(p1, p3, p2){
               silver_tenon();
          }
                    
     }
}

module tomato_beam(p1, p2, p3, p4, p5, p6) {
     difference() {
          union() {
               difference() {
                    beam(p1, p5, p3, "tomato", label="R") {
                         translate([- BeamDiameter/4 * 3, 0, 0]) {
                              cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                         };
                    }
                    beam(p1, p6, p5, "cyan", label="R") {
                         
                    } ;
               }
               in_beam_referential(p1, p5, p3) {
                    tomato_tenon();
               }
          }
          in_beam_referential(p1, p3, p2){
               silver_tenon();
          }
          beam(p1, p3, p2, "silver", label="R") {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          }
     }
}


module silver_beam(p1, p2, p3, p4, p5, p6) {
     difference() {
          beam(p1, p3, p2, "silver", label="R") {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               silver_tenon();
          }
          purple_beam(p1, p2, p3, p4, p5, p6); 
     }
}



module olive_beam(p1, p2, p3, p4, p5, p6) {
     difference() {
          beam(p1, p4, p6, "olive", label="R") {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               olive_tenon();
               
          }
          purple_beam(p1, p2, p3, p4, p5, p6); 
     }
}


module beam5(points) {
     p1p = points[beam[0]];
     p2p = points[beam[1]];
     p3p = points[beam[2]];
     p4p = points[beam[3]];
     p5p = points[beam[4]];
     p6p = points[beam[5]];

     
    prepare_for_stl(p1p, p6p, p5p, 0) {
      //    cyan_beam(p1p, p2p, p3p, p4p, p5p, p6p);
     } 
    /* prepare_for_stl(p1p, p5p, p3p, 1) {
          tomato_beam(p1p, p2p, p3p, p4p, p5p, p6p);
     }*/
     prepare_for_stl(p1p, p4p, p6p, 2) {
      //    olive_beam(p1p, p2p, p3p, p4p, p5p, p6p);
     }
    prepare_for_stl(p1p, p3p, p2p, 3) {
         // silver_beam(p1p, p2p, p3p, p4p, p5p, p6p);
     } 
      prepare_for_stl(p1p, p2p, p4p, 4) {
          purple_beam(p1p, p2p, p3p, p4p, p5p, p6p);
     }
     
     
}


//create_wire(points2, triangles2);
beam5(points2);
