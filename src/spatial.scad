include <data.scad>
include <local.scad>

ScaleFactor=0.5;
BeamDiameter=20;
BeamLip=10;


PrepareForSTL=false;
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

// little helper

module head_in_beam_referential(p1, p2, p3) {
     in_beam_referential(p1, p2, p3) {
          translate([BeamDiameter/2, 0, 0]) {
               rotate([0, 90, 0]){
                    cylinder(BeamDiameter, BeamDiameter/2, BeamDiameter/2);
               }
          }
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
module red_mortaise() {
     translate([BeamDiameter/4, BeamDiameter/8, 0]) {
          cube([BeamDiameter/2, BeamDiameter/6, 6* BeamDiameter/8], center=true);
     };
}

module green_mortaise() {
     translate([BeamDiameter/4,  - BeamDiameter/8, 0]) { 
          cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter/8 * 6], center=true);
     }
}

module green_mortaise_mask() {
  in_beam_referential(p1, p4, p2) {
      translate([BeamDiameter/4,  - BeamDiameter/8, BeamDiameter/8]) { 
          cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter], center=true);
     }     
  }
}

module red_mortaise_mask() {
     in_beam_referential(p1, p3, p7) {
          translate([BeamDiameter/4, BeamDiameter/8, -BeamDiameter/8]) {
               cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter], center=true);
          };
     }
}

module blue_mortaise() {
     translate([BeamDiameter/4, BeamDiameter/6, 0]) {
     //    cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter/3], center=true);
     }
}

module pink_mortaise() {
     translate([BeamDiameter/4, BeamDiameter/3, 0]) {
       //   cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter/2], center=true);
     }
   /*     translate([BeamDiameter/4,- BeamDiameter/3, 0]) {
          cube([BeamDiameter/2, BeamDiameter/6, BeamDiameter/3], center=true);
     } */
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
          translate([BeamDiameter/4 + BeamDiameter/2, -BeamDiameter/2, 0]) {
               cube([BeamDiameter/2, BeamDiameter, BeamDiameter], center=true);
          }
     }
}

module orange_mortaise() {
     translate([BeamDiameter/3, BeamDiameter/4, -BeamDiameter/8]) {
         cube([BeamDiameter, BeamDiameter/3, BeamDiameter/8], center=true);
     }
       translate([BeamDiameter/4,  0, BeamDiameter/3]) {
         cube([BeamDiameter/2, BeamDiameter/3, BeamDiameter/8], center=true);
     }
       translate([BeamDiameter/4,  0, -BeamDiameter/3]) {
         cube([BeamDiameter/2, BeamDiameter/3, BeamDiameter/8], center=true);
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
                    // green_mortaise();
               };
               
               difference() {
                    in_beam_referential(p1, p4, p2) {
                         green_mortaise();
                    }
                    orange_split_plane(); 
               }
          }
          in_beam_referential(p1, p5, p6) {
               
               orange_mortaise();
          }
         /* intersection() {
               pink_mask();
               head_in_beam_referential(p1, p6, p4);
          } */
          in_beam_referential(p1, p3, p7) {
               blue_mortaise();
          }
          
     }
     
          

      
}



module red_beam() {
     difference() {
          union() {
               beam(p1, p3, p7, "red") {
                    translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    };
               // red_mortaise();
               }; 
               
               difference() {
                    in_beam_referential(p1, p3, p7) {
                         red_mortaise();
                    }
                    orange_split_plane(); 
              }
          }
          in_beam_referential(p1, p5, p6) {
               
              orange_mortaise();
          }
          /* intersection() {
               blue_mask();
               head_in_beam_referential(p1, p7, p5);
          } */
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
               /*   translate([-BeamDiameter/1, 0, 0]) {
                    cube([BeamDiameter, BeamDiameter, BeamDiameter], center=true);
                    }; */
          };


          
          head_in_beam_referential(p1, p4, p2);
        
          head_in_beam_referential(p1, p3, p7);
          head_in_beam_referential(p1, p7, p5) ;
         // head_in_beam_referential(p1, p6, p4) ;
   
         red_mortaise_mask();
         green_mortaise_mask();
         
          orange_split_plane();

         in_beam_referential(p1, p5, p6) {
               orange_mortaise();
          }

         // pink_beam();
         
           //    orange_beam();
          in_beam_referential(p1, p7, p5) {
               blue_mortaise();
          }
/*
          in_beam_referential(p1, p7, p5) {
               blue_mortaise();
          } */

  
     
        //  black_lip_splitter();
        
          //   red_beam();
       
          /*   
               head_in_beam_referential(p1, p4, p2);
               head_in_beam_referential(p1, p3, p7);

               // the head of the orange is a bit more compelx

               in_beam_referential(p1, p5, p6) {
               //     orange_mortaise();
               }

               in_beam_referential(p1, p4, p2) {
               green_mortaise();
               }

               in_beam_referential(p1, p7, p5) {
               //  blue_mortaise();
               }

               in_beam_referential(p1, p3, p7) {
               red_mortaise();
               }

               
            
               // this is the splitter
               black_lip_splitter();
          */
          
          /*  difference() {
              in_beam_referential(p1, p5, p6) {
              translate([0, 0, 0]) {
              rotate([0, 90, 0]){
              cylinder(BeamDiameter, BeamDiameter/2, BeamDiameter/2);
              }
              }
              }

              black_lip_mask(0);
               
              } */


          //   head_in_beam_referential(p1, p7, p5);
          // head_in_beam_referential(p1, p6, p4);
          /*  head_in_beam_referential(p1, p3, p7);
              head_in_beam_referential(p1, p6, p4);
              head_in_beam_referential(p1, p7, p5); */
 
          
        
     }
     
}

module blue_beam() {
     
      
     difference() {
          beam(p1, p7, p5, "blue") {
               // adding the mortaise
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
              blue_mortaise();
          };

          red_beam();
       //   orange_beam();

     }

   
     
}

module pink_beam() {
     difference() {
          beam(p1, p6, p4, "pink") {
               // this one has a pin on the inside, slighly torn inside
               translate([-BeamDiameter/2, 0, 0]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               };
          };
          green_beam();
        
        //  orange_beam();
     }

    
}

SplitPlaneAngle=-15;

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
               union() {
                   }; 
               translate([20, 0, 0]) {
                    cylinder(10*BeamDiameter,BeamDiameter/2,BeamDiameter/2,$fn=3);
               }
             
               
          };
          


          orange_splitter();
          
        /*  head_in_beam_referential(p1, p7, p5) ;
          head_in_beam_referential(p1, p6, p4) ;
          */   
     }

     // this is a bit dirty. we may want to rewrite all this if rendering gets too slow.
     difference() {
          in_beam_referential(p1, p5, p6) {
               orange_mortaise();
          }
          orange_split_plane();
     }
     
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
green_beam();
}

translate([0, 0, 0]){
     prepare_for_stl(p1, p3, p7) {
     red_beam();
     }
}

prepare_for_stl(p1, p7, p5) {
    blue_beam();
}


prepare_for_stl(p1, p2, p3) {
    black_beam();
    
}

prepare_for_stl(p1, p6, p4) {
pink_beam();
} 

translate([0, 0, 0]) {
prepare_for_stl(p1, p5, p6) {
 //  orange_beam();
}

}

