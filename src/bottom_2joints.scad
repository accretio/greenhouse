include <data.scad>
include <local.scad>
include <utils.scad>
 
module beam1(p1, p2, p3, tolerance, label="") {
    
     difference() {
          beam(p1, p2, p3, "olive", label) {};
          
          difference() {
               beam(p1, p3, p2, "red") {};
               in_beam_referential(p1, p3, p2) {
                    translate([0, 0, -BeamDiameter/2 - tolerance]) {
                         cube([2*BeamDiameter, BeamDiameter/4 - 2 * tolerance, BeamDiameter - 2* tolerance], center=true); 
               }
                    }
          }
          
          in_beam_referential(p1, p3, p2) {
               translate([0, 0, BeamDiameter/2]) {
                  cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               }
          }
          translate([500, 0, 0]) {
               cube([1000, 1000, 1000], center=true);
          }
     } 
} 



module beam2(p1, p2, p3, label="") {
    difference() {
          beam(p1, p3, p2, "olive", label) {
          };
       /*    beam1(p1, p2, p3, -Tolerance);

          in_beam_referential(p1, p3, p2) {
               translate([-BeamDiameter/2 + Tolerance, 0, -BeamDiameter/2]) {
                
                    cube([2*BeamDiameter, BeamDiameter/4 + 2*Tolerance, BeamDiameter/2], center=true);
                 
           }
          }
          translate([500, 0, 0]) {
               cube([1000, 1000, 1000], center=true);
          } */
    }  
}
 

module create_beams2(points, beams) {
     for (beam=beams) {
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          

       /* prepare_for_stl(p1p, p2p, p3p) {
                difference() {
                    beam1(p1p, p2p, p3p, Tolerance);
                    translate([500, 0, 0]) {
                         cube([1000, 1000, 1000], center=true);
                    } 
               } 
         } */
        
        prepare_for_stl(p1p, p3p, p2p) {
              difference() {
               beam2(p1p, p2p, p3p);
               translate([500, 0, 0]) {
                         cube([1000, 1000, 1000], center=true);
                    }
               } 
          }  
         
     }
} 
