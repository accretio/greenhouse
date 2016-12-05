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

module purple_tenon(tolerance=0.0) {
     translate([0, 0, -BeamDiameter/4]) {
          cube([BeamDiameter+ 2*tolerance, BeamDiameter/4 + 2*tolerance, BeamDiameter/8 + 2*tolerance], center=true);
     }
     translate([BeamDiameter/3, 0, BeamDiameter/4]) {
          cube([BeamDiameter + 2*tolerance, BeamDiameter/4 + 2*tolerance, BeamDiameter/8 + 2*tolerance], center=true);
     }
}

module tomato_tenon(tolerance=0.0) {
     rotate([0, 0, 0]) {
          translate([BeamDiameter/2, 0, 0]) {
               cube([BeamDiameter/2 + 2*tolerance, BeamDiameter/2 + 2*tolerance, BeamDiameter/4 + 2*tolerance], center=true);
          }
     }
}

module silver_tenon(tolerance=0.0) {
     rotate([-10, 0, 0]) {
          translate([BeamDiameter/2, BeamDiameter/8, 0]) {
               cube([BeamDiameter+2*tolerance, BeamDiameter/2+2*tolerance, BeamDiameter/4 + 2*tolerance ], center=true);
          }
     }
     translate([BeamDiameter/2, -BeamDiameter/8, BeamDiameter/3]) {
          cube([BeamDiameter + 2*tolerance, BeamDiameter/4 + 2*tolerance, BeamDiameter/8 + 2*tolerance], center=true);
     }
}

module olive_tenon(tolerance=0.0) {
     rotate([20, 0, 0]) {
          translate([BeamDiameter/4, 0, -BeamDiameter/4]) {
               cube([BeamDiameter/2 + 2*tolerance, BeamDiameter/2 + 2*tolerance, BeamDiameter/4 + 2*tolerance ], center=true);
          }
     }
}

module purple_head(p1, p2, p3, p4, p5, p6) {
     beam(p1, p2, p4, "purple", label) {
          translate([-BeamDiameter/4 * 3, 0, 0]) {
               cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
          };
          purple_tenon(Tolerance);
     }

}


module purple_beam(p1, p2, p3, p4, p5, p6, label="", tolerance=0.0, augment=0.0) {
    difference()
         {
              beam(p1, p2, p4, "purple", label) {
                   translate([-BeamDiameter/4 * 3, 0, 0]) {
                        cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                   };
                   
                   purple_tenon(augment);
              }
              
              

              in_beam_referential(p1, p2, p4) {
                   
                   translate([-BeamDiameter/4, -BeamDiameter/8, BeamDiameter/2 - BeamDiameter/16]) {
                        cube([2*BeamDiameter+2*tolerance, BeamDiameter/4+2*tolerance, BeamDiameter/4], center=true); 
               }
                   translate([-BeamDiameter/4, 0, -BeamDiameter/2 + BeamDiameter/16]) {
                        cube([2*BeamDiameter + 2*tolerance, BeamDiameter/4 + 2*tolerance, BeamDiameter/4], center=true); 
                   }
              }
         }
    if (augment > 0.0) {
         in_beam_referential(p1, p2, p4) {
              purple_tenon(augment);
         }
    }
     
}



module cyan_beam(p1, p2, p3, p4, p5, p6, label="") {
    
     difference() {
          beam(p1, p6, p5, "cyan", label) {
               translate([-BeamDiameter - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          } ;
          
          olive_head(p1, p2, p3, p4, p5, p6);
          silver_head(p1, p2, p3, p4, p5, p6);
          tomato_head(p1, p2, p3, p4, p5, p6);
          purple_head(p1, p2, p3, p4, p5, p6);
     }
}


module tomato_head(p1, p2, p3, p4, p5, p6) {
     beam(p1, p5, p3, "tomato", label) {
          translate([-BeamDiameter/2, 0, 0]) {
               cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
          };
          tomato_tenon(Tolerance);
     }

     
}

module tomato_beam(p1, p2, p3, p4, p5, p6, label="") {
     difference() {
          union() {
               beam(p1, p5, p3, "tomato", label) {
                    translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
               }
               in_beam_referential(p1, p5, p3) {
                    tomato_tenon();
               }
          }
          in_beam_referential(p1, p3, p2){
               silver_tenon(Tolerance);
          }
          beam(p1, p3, p2, "silver", label="") {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          } 
     }
}


module silver_head(p1, p2, p3, p4, p5, p6) {
     difference() {
          beam(p1, p3, p2, "silver", label) {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               silver_tenon(Tolerance);
          }
     }
}

module silver_beam(p1, p2, p3, p4, p5, p6, label="", tolerance=0.0) {
     difference() {
          beam(p1, p3, p2, "silver", label) {
               translate([-BeamDiameter/4 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               silver_tenon();
          }
          purple_beam(p1, p2, p3, p4, p5, p6, augment=Tolerance);
     }
}



module olive_head(p1, p2, p3, p4, p5, p6) {
     beam(p1, p4, p6, "olive", label) {
          translate([-BeamDiameter/8 - BeamDiameter/2, 0, 0]) {
               cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
          };
          olive_tenon(Tolerance);
     }
}

module olive_beam(p1, p2, p3, p4, p5, p6, label="") {
     difference() {
          beam(p1, p4, p6, "olive", label) {
               translate([-BeamDiameter/8 - BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               olive_tenon();
               
          }
          purple_beam(p1, p2, p3, p4, p5, p6, tolerance=-Tolerance, augment=Tolerance); 
     }
}


module create_beams5(points, beams) {
     
     for (beam=beams) {
          
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          p4p = points[beam[3]];
          p5p = points[beam[4]];
          p6p = points[beam[5]];
          
          
          prepare_for_stl(p1p, p6p, p5p, 0) {
              cyan_beam(p1p, p2p, p3p, p4p, p5p, p6p);
          }
          
          prepare_for_stl(p1p, p5p, p3p, 1) {
               tomato_beam(p1p, p2p, p3p, p4p, p5p, p6p);
          }
         
          
          prepare_for_stl(p1p, p4p, p6p, 2) {
                olive_beam(p1p, p2p, p3p, p4p, p5p, p6p);
          }
          
          prepare_for_stl(p1p, p3p, p2p, 3) {
               silver_beam(p1p, p2p, p3p, p4p, p5p, p6p);
          }
          
          prepare_for_stl(p1p, p2p, p4p, 4) {
              purple_beam(p1p, p2p, p3p, p4p, p5p, p6p, tolerance=Tolerance);
          } 
          
     }
     
}
