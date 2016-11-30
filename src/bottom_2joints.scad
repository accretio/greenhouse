include <data.scad>
include <local.scad>
include <utils.scad>
 
module beam1(p1, p2, p3) {
    
    
      
     difference() {
          beam(p1, p2, p3, "olive", label="R") {};
          
          difference() {
               beam(p1, p3, p2, "red") {};
               in_beam_referential(p1, p3, p2) {
                    cube([2*BeamDiameter, BeamDiameter/4, BeamDiameter], center=true);
               }
          }
          
          in_beam_referential(p1, p3, p2) {
               translate([0, 0, BeamDiameter/2]) {
                    cube([2*BeamDiameter, BeamDiameter, BeamDiameter], center=true);
               }
    }
          
     } 
}


module beam2(p1, p2, p3) {
    difference() {
          beam(p1, p3, p2, "olive", label="R") {
          };
          beam1(p1, p2, p3);
          in_beam_referential(p1, p3, p2) {
               translate([-BeamDiameter/2, 0, -BeamDiameter/2]) {
                
                     cube([2*BeamDiameter, BeamDiameter/4, BeamDiameter/2], center=true);
                
           }
          }
        
     } 
}
 

module create_beams2(points, beams) {
     for (beam=beams) {
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          
         
          beam1(p1p, p2p, p3p);
          beam2(p1p, p2p, p3p);
         
     }
} 
