include <data.scad>
include <local.scad>

ScaleFactor=0.5;
BeamDiameter=20;
BeamLip=10;


PrepareForSTL=true;
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



module beam(p1, p2, p3, color) {
     ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
     if (showAxes)
          show_cs(ref_38_31);
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

module prepare_for_stl(p1, p2, p3) {
     if (PrepareForSTL) {
          rotate([0, 90, 0]) {
               ref_38_31 = new_cs(origin=p1,axes=[(p2-p1), cross((p2-p1), (p3-p1))]);
               back_to_absolute(ref_38_31) {
                    children(); 
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
module red_tenon() {
     rotate([30, 0, 0]) {
          translate([BeamDiameter/4,  BeamDiameter/6, -BeamDiameter/4]) {
               cube([BeamDiameter/2, BeamDiameter/4, BeamDiameter/2 ], center=true);
          }
     };
}

module red_tenon_mask() {
     rotate([30, 0, 0]) {
          translate([BeamDiameter/4, BeamDiameter/6,  -BeamDiameter/4 - 5 ]) {
               cube([BeamDiameter/2, BeamDiameter/4 , BeamDiameter/2 + 10], center=true);
          }
     };
}

module green_tenon() {
     rotate([-90, 0, 0]) {
          translate([BeamDiameter/4,  0,  -BeamDiameter/4]) {
               cube([BeamDiameter/2, BeamDiameter/2, BeamDiameter/4], center=true);
          }
     }
}


module green_tenon_mask() {
     rotate([-90, 0, 0]) {
          translate([BeamDiameter/4,  -BeamDiameter/2,  -BeamDiameter/4 ]) {
               cube([BeamDiameter/2, BeamDiameter/2 + BeamDiameter, BeamDiameter/4 ], center=true);
          }
     }
}


module blue_tenon() {
     translate([BeamDiameter/4, 0, 0]) {
          cube([BeamDiameter/2, BeamDiameter/3, BeamDiameter], center=true);
     }
}

module pink_tenon() {
     translate([BeamDiameter/4, BeamDiameter/6, -BeamDiameter/8]) {
          cube([BeamDiameter/2, BeamDiameter/4, BeamDiameter/2], center=true);
     }
}

//pink_mask();
module pink_mask() {
     in_beam_referential(p1, p4, p2) {
          translate([BeamDiameter/4 + BeamDiameter/3, - BeamDiameter/8  - BeamDiameter/2 - BeamDiameter/6, BeamDiameter/2]) {
               //  cube([BeamDiameter/2, BeamDiameter/6 + BeamDiameter, BeamDiameter], center=true);
          }
     }
}



module blue_mask() {
     in_beam_referential(p1, p7, p5) {
          translate([BeamDiameter/4 + BeamDiameter/2, 0, BeamDiameter/4]) {
               cube([BeamDiameter/2, BeamDiameter, BeamDiameter], center=true);
          }
     }
}

module orange_tenon() {
     translate([BeamDiameter/3, -BeamDiameter/6, -BeamDiameter/4]) {
          cube([BeamDiameter, BeamDiameter/8, BeamDiameter/8], center=true);
     }
      translate([BeamDiameter/2, BeamDiameter/8, BeamDiameter/3]) {
          cube([2*BeamDiameter, BeamDiameter/8, BeamDiameter/8], center=true);
     }
        translate([BeamDiameter/2, BeamDiameter/8, -BeamDiameter/4]) {
          cube([2*BeamDiameter, BeamDiameter/8, BeamDiameter/8], center=true);
     }
        
        translate([BeamDiameter/2,  BeamDiameter/2, 0]) {
             cube([2*BeamDiameter, BeamDiameter/8, BeamDiameter/4], center=true);
        }
        
}

module orange_mortise() {
     translate([BeamDiameter/2, 0, -BeamDiameter/3]) {
          cube([BeamDiameter/2, BeamDiameter/4, BeamDiameter/2], center=true);
     }
      translate([BeamDiameter/2, 0, BeamDiameter/3]) {
          cube([BeamDiameter/2, BeamDiameter/4, BeamDiameter], center=true);
     }
      translate([BeamDiameter/4, 0, 0]) {
          cube([BeamDiameter/4, BeamDiameter/4, BeamDiameter], center=true);
     }
}


module green_beam() {
     //  green_mask();
     difference() {
          union() {
               beam(p1, p4, p2, "green", showAxes=false) {
                    translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
                    green_tenon();
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

 in_beam_referential(p1, p5, p6) {
         //   orange_mortise();
          }; 


module red_beam() {
     difference() {
          union() {
               beam(p1, p3, p7, "red") {
                    translate([-BeamDiameter/2, 0, 0]) {
                         cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
                    red_tenon();
               }; 
               
              
          }
          head_in_beam_referential(p1, p7, p5) {}
          in_beam_referential(p1, p5, p6) {
               orange_tenon();
          }

          orange_split_plane();

     }

     
}


module black_lip_mask(extra) {
     in_beam_referential(p1, p2, p3) {
          translate([BeamDiameter/2, BeamDiameter/2 - BeamDiameter/6, 0]) {
               cube([2*BeamDiameter, BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
    
}

module black_lip_splitter() {

     in_beam_referential(p1, p2, p3) {
          translate([-BeamDiameter/2,-BeamDiameter/2 - BeamDiameter/6, 0]) {
               cube([BeamDiameter, BeamDiameter, 2*BeamDiameter], center=true);
          }
     }

     in_beam_referential(p1, p2, p3) {
          translate([-BeamDiameter, 0, 0]) {
               cube([BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
          }
     }
}

 
module black_beam() {
     
     difference() {
          beam(p1, p2, p3, "black", lip=BeamDiameter) {
          }; 
          
          orange_split_plane();
          
          in_beam_referential(p1, p6, p4) {
               pink_tenon();
          }; 
          
          in_beam_referential(p1, p4, p2) {
               green_tenon_mask();
          }; 
          
          in_beam_referential(p1, p3, p7) {
               red_tenon_mask();
          }; 

          in_beam_referential(p1, p5, p6) {
              orange_tenon();
          };

          head_in_beam_referential(p1, p4, p2) {};
          head_in_beam_referential(p1, p3, p7) {};
       

          
        
     }
     
}

module blue_beam() {
     
      
     difference() {
          beam(p1, p7, p5, "blue") {
               // adding the tenon
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          
          };

         
          orange_beam();
          
          
          
     }
     difference() {
          in_beam_referential_inside_beam(p1, p7, p5) {
               // adding the tenon
               blue_tenon();
          }
          orange_splitter();
          orange_beam();
     }

   
     
}

module pink_beam() {
     difference() {
          beam(p1, p6, p4, "pink") {
               // this one has a pin on the inside, slighly torn inside
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          //   pink_tenon();
          };
          green_beam();
          orange_beam();
     }
     difference() {
          in_beam_referential(p1, p6, p4) {
               pink_tenon();
          }
          orange_split_plane();
          in_beam_referential(p1, p4, p2){
               green_tenon();
          }
          in_beam_referential(p1, p5, p6) {
               orange_tenon();
          }
     }
   
     
    
}

SplitPlaneAngle=0; // has to be 0 or we won't be able to slide the orange beam

module orange_split_plane() {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([-BeamDiameter/3 + BeamDiameter, 0, 0]) {
                    cube([BeamDiameter, 2*BeamDiameter, 2*BeamDiameter], center=true);
               };
          }
     }
}

module orange_splitter() {
     in_beam_referential(p1, p5, p6, "red") {
          rotate([0, 0, SplitPlaneAngle]) {
               translate([-BeamDiameter/3, 0, 0]) {
                    cube([BeamDiameter, 1.5*BeamDiameter, 1.5*BeamDiameter], center=true);
               };
          }
     }
}



module orange_beam() {
     difference() {
          beam(p1, p5, p6, "orange") {
          };
          in_beam_referential(p1, p5, p6) {
               orange_mortise();
               
          }

        orange_splitter();
          
          /*  head_in_beam_referential(p1, p7, p5) ;
              head_in_beam_referential(p1, p6, p4) ;
          */   
     }
      in_beam_referential(p1, p5, p6) {
               orange_tenon();
               
          }

     // this is a bit dirty. we may want to rewrite all this if rendering gets too slow.
   /*  difference() {
          in_beam_referential(p1, p5, p6) {
               orange_tenon();
          }
          orange_split_plane();
     } */
     
}


/*
  green_beam();
  black_beam();
  red_beam();

  create_wire(points2, triangles2); 
*/


// stuff needed to 3d print the model - it is much easier if they are back in a normal referential

//create_wire(points2, triangles2); 




prepare_for_stl(p1, p4, p2) {
 // green_beam();
}

translate([0, 0, 0]){
     prepare_for_stl(p1, p3, p7) {
    //  red_beam();
      
     }
}

prepare_for_stl(p1, p7, p5) {
   
  // blue_beam();
}


prepare_for_stl(p1, p2, p3) {
black_beam();
    
}

prepare_for_stl(p1, p6, p4) {
// pink_beam();
} 

translate([0, 0, 0]) {
     prepare_for_stl(p1, p5, p6) {
       //orange_beam();
     }

}

