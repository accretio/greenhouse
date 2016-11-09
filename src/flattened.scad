// Let's try to do a flat structure.

/*

  Let's put numbers on the beams

  1   2
  6         3
  5   4

*/

BeamLength=100;
BeamDepth=10;
BeamWidth=10;
BeamLip=10;

module base_beam() {
     translate([0, BeamLength/2 - BeamLip/2, 0]) {
          cube([BeamDepth, BeamLength, BeamWidth], center=true);
     }
}



module beam6() {
     difference() {
          rotate([180, 0, 0]) {
               difference() {
                    base_beam();
                    translate([-BeamDepth/8, 0, 0]) {
                         cube([BeamDepth/4, BeamLip, BeamWidth], center=true);
                    }
               }
          }
       
     }
}

module beam3() {
     difference() {
          rotate([0, 180, 0]) {
               difference() {
                    base_beam();
                  /*  translate([0, 0, -BeamWidth/4]) {
                         cube([BeamDepth, BeamLip, BeamWidth/2], center=true);
                    } 
                    translate([-BeamDepth/8, 0, 0]) {
                         cube([BeamDepth/4, BeamLip, BeamWidth], center=true);
                    } */ 
                 /*   cube([BeamDepth, BeamLip, BeamWidth], center=true);
                 */
/*   translate([0, 0, -BeamWidth/2]) {
                         cube([BeamDepth, BeamLip, BeamWidth/2], center=true);
                    } 
                    translate([0, 0, BeamWidth/2]) {
                         cube([BeamDepth, BeamLip, BeamWidth/2], center=true);
                    } */
              
               }
          
               //   beam4();
               // beam2();
               // beam1();
          }
         //  beam2();
     }
}





module beam1_mask() {
     rotate([135, 0, 0]) {
          translate([0, -BeamLip/2, -BeamWidth/2]) {
               cube([BeamWidth/2, BeamLip*2, 2* BeamWidth], center=true);
          }
          translate([0, 0, -BeamWidth]) {
               cube([BeamWidth, BeamLip, BeamWidth], center=true);
          } 
          difference() {
               base_beam();
               translate([0, 0, BeamWidth/8]) {
                    cube([BeamDepth, BeamLip, 3*BeamWidth/4], center=true);
               }
          }
    
}
}


module beam4() {
     difference() {
          rotate([-45, 0, 0]) {
               base_beam(); 
          }
          translate([BeamWidth/2 - BeamDepth/4, -BeamWidth, - BeamLip/2]) {
               cube([BeamDepth/4, BeamWidth*4, BeamWidth*2]);
          }
          translate([- BeamWidth/2, -BeamWidth , - BeamLip/2]) {
               cube([BeamDepth/2, BeamWidth*4, BeamWidth*2]);
          }
        /*  beam2();
          beam1(); */
     }
} 


module beam5() {
     difference() {
          rotate([-135, 0, 0]) {
               base_beam();
          }
          translate([BeamWidth/2 - BeamDepth/2, -2*BeamWidth , - BeamLip/2]) {
               cube([BeamDepth/2, BeamWidth*4, BeamWidth*2]);
          }
          translate([- BeamWidth/2, -2*BeamWidth , - BeamLip/2]) {
               cube([BeamDepth/4, BeamWidth*4, BeamWidth*2]);
          }
        /*  beam2();
          beam1(); */
     }
  
     
}


module beam2() {
     difference() {
          rotate([45, 0, 0]) {
               cube([BeamDepth/4, BeamLip, BeamWidth/3], center=true);
               difference() {
                    base_beam();
                    cube([BeamDepth, BeamLip, BeamWidth], center=true); 
               }
          };
         
     }
     
}


module beam1() {
     difference() {
          rotate([135, 0, 0]) {
        
               difference() {
                    base_beam();
                    //   cube([BeamDepth, BeamLip, BeamWidth/2], center=true);
                    /* translate([0, 0, 2 * BeamWidth/6]) {
                       cube([BeamDepth, BeamLip, BeamWidth/3], center=true);
                       }
                       translate([0, 0, -2 * BeamWidth/6]) {
                       cube([BeamDepth, BeamLip, BeamWidth/3], center=true);
                       } */
                    translate([0, 0, BeamWidth/4]) {
                         cube([BeamDepth, BeamLip, BeamWidth/2], center=true);
                    }
               }
          }
          beam2();
        //  beam3();
     }
     
     
}


translate([0, -20, 20]) {
     beam1();
}

translate([0, 20, 20]) {
     beam2();
}

translate([0, 20, 0]) {
     beam3();     
}


// these two would be pretty solid.

translate([0, 0, 0]) {
     beam4();
}

translate([0, 0, 0]) {
     beam5();
} 

translate([0, 0, 0]) {
     beam6();
}
