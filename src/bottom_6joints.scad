include <data.scad>
include <local.scad>
include <utils.scad>


/*

  p6  p5  p7
      p1  
  p4  p2  p3

*/

module red_tenon2(tolerance=0) {
     translate([0,  0, 0]) {
          cube([BeamDiameter, BeamDiameter/4-(2*tolerance), BeamDiameter/2 - (2*tolerance) ], center=true);
     }
     /* translate([0,  -BeamDiameter/4, 0]) {
          cube([BeamDiameter, BeamDiameter/4-(2*tolerance), BeamDiameter/2 - (2*tolerance) ], center=true);
     } */
}

module black_beam2(p1, p2, p3, p4, p5, p6, p7) {
     difference() {
          beam(p1, p2, p3, "black", label="BL") {
                translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                };
          };
          in_beam_referential(p1, p3, p7) {
               red_tenon2();
          };
          head_in_beam_referential(p1, p3, p7) {};
     }
     
}


module red_beam2(p1, p2, p3, p4, p5, p6, p7) {
     difference() {
          beam(p1, p3, p7, "red", label="R") {
                translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                };
                red_tenon2();
          };
         // black_beam2(p1, p2, p3, p4, p5, p6, p7);
     }
     
}
