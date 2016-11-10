// Let's try to do a flat structure.

/*

  Let's put numbers on the beams

  1   2
  6         3
  5   4

*/

BeamLength=100;
BeamDepth=20;
BeamWidth=20;
BeamLip=20;

module base_beam() {
     translate([0, BeamLength/2 - BeamLip/2, 0]) {
          cube([BeamDepth, BeamLength, BeamWidth], center=true);
     }
}


module beam1_lip() {


     rotate([120, 0, 0]) {
          translate([BeamWidth/4, BeamWidth/8, 0]) {
               cube([BeamWidth/4, BeamWidth, BeamWidth/2], center=true);
          }
          translate([-BeamWidth/4, BeamWidth/8, 0]) {
               cube([BeamWidth/4, BeamWidth, BeamWidth/2], center=true);
          }
     }
     
}

module beam1() {
     difference() {
          rotate([120, 0, 0]) {
        
               difference() {
                    base_beam();
                  
               }

               
               
          }
          translate([0, BeamWidth/2, 0]) {
               cube([BeamWidth, BeamWidth, 2*BeamWidth], center=true);
          }
          translate([0, 0, -BeamWidth/2]) {
               cube([2*BeamWidth, 2*BeamWidth, BeamWidth], center=true);
          }
          beam2_lip();
     }

     beam1_lip();
     
}


module beam2() {
       
     difference() {
          rotate([60, 0, 0]) {
               
               difference() {
                    base_beam();
                   
               }
               translate([0, 0, 0]) {
                    cube([BeamWidth/4, BeamWidth, BeamWidth], center=true);
               }
          };
          translate([0, BeamWidth/2 + BeamWidth/8, -BeamWidth/2]) {
               cube([BeamWidth, 4*BeamWidth, 2*BeamWidth], center=true);
          }
          translate([0, -BeamWidth/2, BeamWidth/2]) {
               cube([BeamWidth, BeamWidth, BeamWidth], center=true);
          }
     }

     beam2_lip();
}


module beam2_lip() {
     rotate([60, 0, 0]) {
          translate([0, BeamWidth/2 + BeamWidth/8, 0]) {
               cube([BeamWidth/4, 2*BeamWidth, BeamWidth/2], center=true);
          }
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
          beam1_lip();
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
          beam2_lip();
          beam1_lip();
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
          translate([0, 0, BeamWidth/2]) {
               cube([BeamWidth, BeamWidth, BeamWidth], center=true); 
          }
          beam2_lip();
          beam1_lip();
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
          translate([0, 0, BeamWidth/2]) {
               cube([BeamWidth, BeamWidth, BeamWidth], center=true); 
          }
          beam2_lip();
          
          beam1_lip();
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
 
translate([0, -20, 20]) {
     beam1();
}

translate([0, 20, 20 ]) {
     beam2();
}

translate([0, -20, 0]) {
     beam6();
}
translate([0, 20, 0]) {
     beam3();     
}


translate([0, 20, -20]) {
     beam4();
}

translate([0, -20, -20]) {
     beam5();
} 

