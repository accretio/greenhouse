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


module beam3() {
     difference() {
          base_beam();
          translate([-BeamLip/2, -BeamLip/2, 0]) {
               cube([BeamDepth, BeamLip, BeamWidth/2]);
          }
        /*  beam4();
          beam5(); */
     }
}



module beam6() {
     difference() {
          rotate([180, 0, 0]) {
               base_beam();
          }
          beam3();
          beam4();
          beam5();
          
          
     }
}


module beam4() {
     difference() {
          rotate([-45, 0, 0]) {
               difference() {
                    base_beam(); 
                    translate([BeamWidth/2 - BeamDepth/4, -BeamLip/2, -BeamWidth/2]) {
                         cube([BeamDepth/4, BeamLip, BeamWidth]);
                    };
                    translate([-BeamWidth/2 , -BeamLip/2, -BeamWidth/2]) {
                         cube([BeamDepth/2, BeamLip, BeamWidth]);
                    };
               
               }
          }
          translate([BeamWidth/2 - BeamDepth/4, 0 , - BeamLip/2]) {
               cube([BeamDepth/4, BeamWidth*2, BeamWidth]);
          }
          translate([- BeamWidth/2, 0 , - BeamLip/2]) {
               cube([BeamDepth/2, BeamWidth*2, BeamWidth]);
          }
          beam5();
     }
}


module beam5() {
   difference() {
          rotate([-135, 0, 0]) {
               difference() {
                    base_beam(); 
                    translate([0, -BeamLip/2, -BeamWidth/2]) {
                         cube([BeamDepth/2, BeamLip, BeamWidth]);
                    };
                    translate([-BeamWidth/2 , -BeamLip/2, -BeamWidth/2]) {
                         cube([BeamDepth/4, BeamLip, BeamWidth]);
                    };
               
               }
          }
          translate([BeamWidth/2 - BeamDepth/2, -2*BeamWidth , - BeamLip/2]) {
               cube([BeamDepth/2, BeamWidth*2, BeamWidth]);
          }
          translate([- BeamWidth/2, -2*BeamWidth , - BeamLip/2]) {
               cube([BeamDepth/4, BeamWidth*2, BeamWidth]);
          }
         
     }
     
}




translate([0, 10, 0]) {
     beam3();
}

translate([0, -10, 0]) {
     beam6();
}

translate([0, 10, -20]) {
     beam4();
}

translate([0, -10, -20]) {
     beam5();
}


