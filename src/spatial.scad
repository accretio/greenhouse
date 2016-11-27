include <data.scad>
include <local.scad>

ScaleFactor=0.5;
BeamDiameter=20;
BeamLip=10;


PrepareForSTL=true;
STLSpacing=5;
Tolerance=0.2;

// old beam stuff, needed for the wireframe

module element(length, diameter, c) {
     color(c) {
          translate([0, 0, length/2]) {
               cylinder(length, diameter/2, diameter/2, length, center=true);
          }
     }
}

module wire(p1, p2, diameter, color) {
     axle = p2-p1;
     length = norm(axle); 
       
     b = acos(axle[2]/length); // inclination angle
     c = atan2(axle[1], axle[0]);     // azimuthal angle
 
     translate(p1) {
          rotate([0, b, c]) {
               element(length, diameter, color);
          }
     }
}

module create_wire(points, triangles) {
     for(triangle=triangles) {
          p1 = points[triangle[0]]; 
          p2 = points[triangle[1]]; 
          p3 = points[triangle[2]];
          wire(p1, p2, 1);
          wire(p2, p3, 1);
          wire(p3, p1, 1);
     }
}


TextHeight=5;

module beam(p1, p2, p3, color, label) {
     ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
     in_cs(ref_38_31) {
          color(color) {
             
               intersection() {
                    union() {
                         difference() {
                              translate([-BeamLip, 0, 0]) {
                                   rotate([0, 90, 0]){
                                        cylinder(ScaleFactor * norm((p2-p1)) + BeamLip, BeamDiameter/2, BeamDiameter/2);
                                   }
                              }
                              children(0);
                              if (PrepareForSTL) {
                                   translate([ScaleFactor * norm((p2-p1)) - TextHeight, 0, 0]) {
                                        rotate([0, 90, 0]) {
                                             linear_extrude(TextHeight) {
                                                  text(label, halign="center", valign="center", size=6);
                                             }
                                        }
                                   }
                              }
                         };
                         children(1) ;
                    }
                    translate([-BeamLip, 0, 0]) {
                         rotate([0, 90, 0]){
                              cylinder(ScaleFactor * norm((p2-p1)) + BeamLip, BeamDiameter/2, BeamDiameter/2);
                         }
                    } ;
               }
          }
     }
}

// helpers to change coordinate systems

module prepare_for_stl(p1, p2, p3, pos) {
     if (PrepareForSTL) {
          translate([ (STLSpacing + BeamDiameter) * (pos % 2), (STLSpacing + BeamDiameter) * (-1 + round((pos + 1) / 2)), 0]) {
               rotate([0, 90, 0]) {
                    ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
                    back_to_absolute(ref_38_31) {
                         children(); 
                    }
               }
          }
     } else {
          children();
     }
}
 
module in_beam_referential(p1, p2, p3, color) {
     ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
     in_cs(ref_38_31) {
          color(color) {
               children();
          }
     }
}

module in_beam_referential_inside_beam(p1, p2, p3, color) {
     ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
     in_cs(ref_38_31) {
          color(color) {

               intersection() {
                    children();
                    translate([-BeamLip, 0, 0]) {
                         rotate([0, 90, 0]){
                              cylinder(ScaleFactor * norm((p2-p1)) + BeamLip, BeamDiameter/2, BeamDiameter/2);
                         }
                    } ;
               }
          }
     }
}

// little helper

module head_in_beam_referential(p1, p2, p3) {
     in_beam_referential(p1, p2, p3) {
          translate([BeamDiameter/2, 0, 0]) {
               rotate([0, 90, 0]){
                    cylinder(BeamDiameter, BeamDiameter/2, BeamDiameter/2);
               }
          }
          children();
     }
}

/*

  p6  p5  p7
  p1  
  p4  p2  p3

*/

p1 = points2[38]; 
p2 = points2[1]; 
p3 = points2[39]; 
p4 = points2[31]; 
p5 = points2[11]; 
p6 = points2[33];
p7 = points2[36];

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


module green_beam() {
     difference() {
          union() {
               beam(p1, p4, p2, "green", label="G") {
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


module red_beam() {
     difference() {
          union() {
               beam(p1, p3, p7, "red", label="R") {
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

          orange_split_plane();

     }

     
}

 
module black_beam() {
     
     difference() {
          beam(p1, p2, p3, "black", label="BL") {
          }; 
          
          orange_split_plane();


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

module blue_beam() {
     difference() {
          beam(p1, p7, p5, "blue", label="B") {
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
               
          };
          red_beam();
         orange_beam(Tolerance);
     }
     difference() {
          in_beam_referential_inside_beam(p1, p7, p5) {
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               }; 
          }
          orange_splitter();
          orange_vertical_splitter2();
          orange_beam(Tolerance);
     }
     difference() {
          in_beam_referential_inside_beam(p1, p7, p5) {
               blue_tenon(Tolerance);
          }
          orange_split_plane();
          orange_beam(Tolerance);
     }

   
     
}

module orange_vertical_splitter() {
     in_beam_referential(p1, p5, p6) {
          translate([0, 0, BeamDiameter]) {
               cube([2*BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
}


module orange_vertical_splitter2() {
     in_beam_referential(p1, p5, p6) {
          translate([0, 0, -BeamDiameter]) {
               cube([2*BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
}


module pink_beam() {
     difference() {
          union() {
               difference() {
                    beam(p1, p6, p4, "pink", label="P") {
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
                    orange_splitter();
               }
               in_beam_referential(p1, p6, p4) {
                    pink_tenon(Tolerance);
               }
        
          }
          orange_beam(Tolerance);
          orange_vertical_splitter();
     }
    
}

SplitPlaneAngle=0; // has to be 0 or we won't be able to slide the orange beam
SplitPlanePosition=-BeamDiameter/3;
module orange_split_plane() {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([SplitPlanePosition + BeamDiameter, 0, 0]) {
                    cube([BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
               };
          }
     }
}

module orange_splitter() {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([SplitPlanePosition, 0, 0]) {
                    cube([BeamDiameter, 1.5*BeamDiameter, 1.5*BeamDiameter], center=true);
               };
          }
     }
}



module orange_beam(tolerance=0) {
     difference() {
          beam(p1, p5, p6, "orange", label="O") {
          };
          in_beam_referential(p1, p5, p6) {
               orange_mortise(tolerance);
          };
          orange_splitter();
     }
     in_beam_referential_inside_beam(p1, p5, p6) {
          orange_tenon(-tolerance);
          
     } 
     
}



// stuff needed to 3d print the model - it is much easier if they are back in a normal referential

//create_wire(points2, triangles2); 


/*

prepare_for_stl(p1, p4, p2, 0) {
     green_beam();
}


prepare_for_stl(p1, p3, p7, 1) {
     red_beam();
     
}



prepare_for_stl(p1, p7, p5, 2) { 
     blue_beam();
}


prepare_for_stl(p1, p6, p4, 3) {
     pink_beam();
    
} */


prepare_for_stl(p1, p5, p6, 4) {
 //    orange_beam();
}


prepare_for_stl(p1, p2, p3, 5) {
     black_beam();    
}

