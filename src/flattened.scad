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



module beam1() {
     difference() {
          rotate([120, 0, 0]) {
        
               difference() {
                    base_beam();
                  
               }
          }
       
     }
     
     
}


module beam2() {
     difference() {
          rotate([60, 0, 0]) {
               
               difference() {
                    base_beam();
                    cube([BeamWidth, BeamWidth, BeamWidth], center=true);
               }
               translate([-BeamWidth/8, 0, -BeamWidth/2 + BeamWidth/8]) {
                    cube([BeamWidth/4, BeamWidth, BeamWidth/4], center=true);
               }
          };
         
     }
     
}

module beam6() {
     difference() {
        rotate([180, 0, 0]) {
               difference() {
                    base_beam();
                    translate([0, -BeamWidth/2, 0]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth], center=true);
                    }
                     translate([-BeamWidth/2, 0, 0]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
                    translate([BeamWidth/2, 0,  BeamWidth/3]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
                     translate([BeamWidth/2, 0,  -BeamWidth/3]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
                   
               }
          } 
          holder_mask();
     }
}

module beam3() {
     difference() {
          rotate([0, 0, 0]) {
               difference() {
                    base_beam();
                    translate([0, -BeamWidth/2, 0]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth], center=true);
                    }
                    // the teeth
                    translate([BeamWidth/2, 0, 0]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
                    translate([-BeamWidth/2, 0,  BeamWidth/3]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
                     translate([-BeamWidth/2, 0,  -BeamWidth/3]) {
                         cube([BeamWidth/2, BeamWidth, BeamWidth/3], center=true);
                    }
               }
          }
          holder_mask();
         
     }
}




module beam4() {
    difference() {
          rotate([-60, 0, 0]) {
               difference() {
                    base_beam();
                  
               }
          }
          rotate([-120, 0, 0]) {
               translate([BeamWidth/2, BeamWidth, -1.5*BeamWidth]) {
                    cube([BeamWidth, 4*BeamWidth, 4*BeamWidth], center=true);
               }
          }
          holder();
    
     }
    
} 


module beam5() {
   
     difference() {
          rotate([-120, 0, 0]) {
               difference() {
                    base_beam();
                    
               }
          }
          rotate([-60, 0, 0]) {
               translate([-BeamWidth/2, BeamWidth, 1.5*BeamWidth]) {
                    cube([BeamWidth, 4*BeamWidth, 4*BeamWidth], center=true);
               }
          } 
           holder();
       
          //  beam1(); */
     }
    
}


module holder_mask() {
    
     difference() {
          
          cube([2*BeamWidth, 2*BeamWidth, 2*BeamWidth], center=true);
          holder();
          rotate([120, 0, 0]) {
               translate([0, -BeamWidth/2,-BeamWidth]) {
                    cube([BeamWidth/2, 1.5*BeamWidth, BeamWidth], center=true);
               }
          }
          
          rotate([60, 0, 0]) {
               translate([0, -BeamWidth/2, BeamWidth]) {
                    cube([BeamWidth/2, 1.5* BeamWidth, BeamWidth], center=true);
               }
          }    
     }
     
}



module holder() {
     translate([0, 0, BeamWidth/1]) {
          difference() {
               cube([BeamWidth*2, BeamWidth*2, 2*BeamWidth], center=true);
               cube([BeamWidth/2, BeamWidth/2, 2*BeamWidth], center=true);
          }
     }
      translate([0, 0, BeamWidth/2]) {
          difference() {
               cube([BeamWidth*2, BeamWidth*2, 2*BeamWidth], center=true);
               cube([BeamWidth/2, 2*BeamWidth, 2*BeamWidth], center=true);
          }
     }
}
 
translate([0, -20, 40]) {
     beam1();
}

translate([0, 0, 4]) {
     beam2();
}



translate([0, 0, 0]) {
     beam6();
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

