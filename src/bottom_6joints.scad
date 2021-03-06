include <data.scad>
include <local.scad>
include <utils.scad>

/*

  p6  p5  p7
      p1  
  p4  p2  p3

*/ 

// let's print the joint beams
module red_tenon(tolerance=0) {
     rotate([30, 0, 0]) {
          translate([BeamDiameter/3,  BeamDiameter/6, 0]) {
               cube([BeamDiameter/3, BeamDiameter/4-(2*tolerance), BeamDiameter/2 - (2*tolerance) ], center=true);
          }
     };
}

module green_tenon(tolerance=0) {
     translate([BeamDiameter/2 - BeamDiameter/8 + tolerance, 0, -BeamDiameter/4]) {
          cube([BeamDiameter/4, BeamDiameter/2-(2*tolerance), BeamDiameter/4 -(2*tolerance) ], center=true);
     }
}

module blue_tenon(tolerance=0) {
     translate([BeamDiameter/3 + tolerance, -BeamDiameter/4, 0]) {
          cube([BeamDiameter/3, BeamDiameter/4-(2*tolerance), BeamDiameter-(2*tolerance)], center=true);
     }
}

module pink_tenon(tolerance=0) {
     translate([BeamDiameter/3 + tolerance, BeamDiameter/6, 0]) {
          cube([BeamDiameter/3, BeamDiameter/4-(2*tolerance), BeamDiameter/2-(2*tolerance)], center=true);
     }
}


module orange_tenon(tolerance=0) {
     translate([BeamDiameter/2 -tolerance, -BeamDiameter/8, -BeamDiameter/4]) {
          cube([2*BeamDiameter, BeamDiameter/8 -(2*tolerance), BeamDiameter/8 -(2*tolerance)], center=true);
     }
     translate([BeamDiameter/2 - tolerance, BeamDiameter/6, -BeamDiameter/6]) {
          cube([2*BeamDiameter, BeamDiameter/8 -(2*tolerance), BeamDiameter/8 -(2*tolerance) ], center=true);
     }
     translate([BeamDiameter/2 - tolerance, -BeamDiameter/8, BeamDiameter/4]) {
          cube([2*BeamDiameter, BeamDiameter/8 -(2*tolerance), BeamDiameter/8-(2*tolerance)], center=true);
     }
     translate([BeamDiameter/2 -  tolerance, -BeamDiameter/3, BeamDiameter/6]) {
         cube([2*BeamDiameter, BeamDiameter/8-(2*tolerance), BeamDiameter/8-(2*tolerance)], center=true);
     }
     translate([BeamDiameter/2 -  tolerance, BeamDiameter/4, BeamDiameter/8]) {
         cube([BeamDiameter, BeamDiameter/6-(2*tolerance), BeamDiameter/6-(2*tolerance)], center=true);
     }    
}

module orange_mortise(tolerance=0) {
   
     translate([BeamDiameter/2 - tolerance, 0, -BeamDiameter/3]) {
          cube([BeamDiameter/2, BeamDiameter/4 - 2*tolerance, BeamDiameter/2  - 2*tolerance], center=true);
     }
     translate([BeamDiameter/2 - tolerance, 0, BeamDiameter/3]) {
          cube([BeamDiameter/2, BeamDiameter/4 - 2*tolerance, BeamDiameter - 2*tolerance], center=true);
     }
     translate([BeamDiameter/4 - tolerance, 0, 0]) {
          cube([BeamDiameter/4, BeamDiameter/4 - 2*tolerance, BeamDiameter - 2*tolerance], center=true);
     }
     
}


module green_beam(p1, p2, p3, p4, p5, p6, p7, label="") {
     difference() {
          union() {
               beam(p1, p4, p2, "green", label) {
                    translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
                    green_tenon(Tolerance);
               };
          }
          orange_split_plane();
          head_in_beam_referential(p1, p6, p4) {
               pink_tenon();
          }
          in_beam_referential(p1, p5, p6) {
               orange_tenon();
          }
     }
        
}


module red_beam(p1, p2, p3, p4, p5, p6, p7, label="") {
     difference() {
          union() {
               beam(p1, p3, p7, "red", label) {
                    translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
                    red_tenon(Tolerance);
               }; 
               
              
          }
          head_in_beam_referential(p1, p7, p5) {}
          in_beam_referential(p1, p5, p6) {
               orange_tenon();
          }
          head_in_beam_referential(p1, p7, p5) {
               blue_tenon();
          }

          orange_split_plane(p1, p2, p3, p4, p5, p6, p7);

     }

     
}

 
module black_beam(p1, p2, p3, p4, p5, p6, p7, label="") {
     
     difference() {
          beam(p1, p2, p3, "black", label) {
          }; 
          
          orange_split_plane(p1, p2, p3, p4, p5, p6);


          in_beam_referential(p1, p6, p4) {
               pink_tenon();
          }; 

          in_beam_referential(p1, p4, p2) {
               green_tenon();
          };
           
          
          in_beam_referential(p1, p3, p7) {
               red_tenon();
          }; 

          in_beam_referential(p1, p5, p6) {
               orange_tenon(-Tolerance);
          };

          
          in_beam_referential(p1, p7, p5) {
               blue_tenon(); 
          }; 
          
          head_in_beam_referential(p1, p4, p2) {};
          head_in_beam_referential(p1, p3, p7) {};
              
     }
     
}

module blue_beam(p1, p2, p3, p4, p5, p6, p7, label="") {
     difference() {
          beam(p1, p7, p5, "blue", label) {
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               
          };
          red_beam();
         orange_beam(p1, p2, p3, p4, p5, p6, p7, Tolerance);
     }
     difference() {
          in_beam_referential_inside_beam(p1, p7, p5) {
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               }; 
          }
          orange_splitter(p1, p2, p3, p4, p5, p6, p7);
          orange_vertical_splitter2(p1, p2, p3, p4, p5, p6, p7);
          orange_beam(p1, p2, p3, p4, p5, p6, p7, Tolerance);
     }
     difference() {
          in_beam_referential_inside_beam(p1, p7, p5) {
               blue_tenon(p1, p2, p3, p4, p5, p6, p7, Tolerance);
          }
          orange_split_plane(p1, p2, p3, p4, p5, p6, p7);
          orange_beam(p1, p2, p3, p4, p5, p6, p7, Tolerance);
     }

   
     
}

module orange_vertical_splitter(p1, p2, p3, p4, p5, p6, p7) {
     in_beam_referential(p1, p5, p6) {
          translate([0, 0, BeamDiameter]) {
               cube([2*BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
}


module orange_vertical_splitter2(p1, p2, p3, p4, p5, p6, p7) {
     in_beam_referential(p1, p5, p6) {
          translate([0, 0, -BeamDiameter]) {
               cube([2*BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
}


module pink_beam(p1, p2, p3, p4, p5, p6, p7, label="") {
     difference() {
          union() {
               difference() {
                    beam(p1, p6, p4, "pink", label) {
                         // this one has a pin on the inside, slighly torn inside
                         translate([-BeamDiameter/2, 0, 0]) {
                              cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                         };
                    };
               }
               difference() {
                    in_beam_referential_inside_beam(p1, p6, p4) {
                         translate([-BeamDiameter/2, 0, 0]) {
                              cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                         }; 
                    }
                    orange_splitter(p1, p2, p3, p4, p5, p6, p7);
               }
               in_beam_referential(p1, p6, p4) {
                    pink_tenon(Tolerance);
               }
        
          }
          orange_beam(p1, p2, p3, p4, p5, p6, p7, Tolerance);
          orange_vertical_splitter(p1, p2, p3, p4, p5, p6, p7);
     }
    
}

SplitPlaneAngle=0; // has to be 0 or we won't be able to slide the orange beam
SplitPlanePosition=-BeamDiameter/3;

module orange_split_plane(p1, p2, p3, p4, p5, p6, p7) {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([SplitPlanePosition + BeamDiameter, 0, 0]) {
                    cube([BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
               };
          }
     }
}

module orange_splitter(p1, p2, p3, p4, p5, p6, p7) {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([SplitPlanePosition-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, 1.5*BeamDiameter, 1.5*BeamDiameter], center=true);
               };
          }
     }
}



module orange_beam(p1, p2, p3, p4, p5, p6, p7, tolerance=0, label="") {
     difference() {
          beam(p1, p5, p6, "orange", label) {
          };
          in_beam_referential(p1, p5, p6) {
               orange_mortise(tolerance);
          };
          orange_splitter(p1, p2, p3, p4, p5, p6, p7);
     }
     in_beam_referential_inside_beam(p1, p5, p6) {
          orange_tenon(-tolerance);
          
     } 

    
}



module create_beams6(points, beams) {
     
     for(beam=beams) {
          
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          p4p = points[beam[3]];
          p5p = points[beam[4]];
          p6p = points[beam[5]];
          p7p = points[beam[6]];

          prepare_for_stl(p1p, p4p, p2p, 0) {
              green_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }

          prepare_for_stl(p1p, p3p, p7p, 1) {
                red_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }

          prepare_for_stl(p1p, p7p, p5p, 2) {
               blue_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }

          prepare_for_stl(p1p, p6p, p4p, 3) {
              pink_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }

          prepare_for_stl(p1p, p5p, p6p, 4) {
               orange_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }

          prepare_for_stl(p1p, p2p, p3p, 5) {
               black_beam(p1p, p2p, p3p, p4p, p5p, p6p, p7p);
          }
          
     }
     
}
