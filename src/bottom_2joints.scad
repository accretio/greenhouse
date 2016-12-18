include <data.scad>
include <local.scad>
include <utils.scad>
 
module beam1(p1, p2, p3, tolerance, label="") {
      
     difference() { 
         beam(p1, p2, p3, "olive", label) {};
         in_mounting_referential(p1, p2) {
              beam1_tenon(tolerance);
         }
     } 
     
} 


module in_mounting_referential(origin, axe1) {
     ref_38_31 = new_cs(origin=origin,axes=[axe1, cross(axe1, [-1, 0, 0])]);
     in_cs(ref_38_31) { 
          rotate([0, 270, 0]) { 
               children();
          }
     }
     
}



module beam1_tenon(tolerance=0.0) {
      translate([-BeamDiameter/3 , 12,  -10]) {
          cube([BeamDiameter/3+2*tolerance, 2* BeamDiameter+2*tolerance, BeamDiameter + 2*tolerance], center=true); 
     }
     translate([-BeamDiameter, BeamDiameter/2 +8, 0]) {
          cube([5*BeamDiameter+2*tolerance, 2*BeamDiameter+2*tolerance, 2*BeamDiameter+2*tolerance], center=true); 
     }

}

module beam2(p1, p2, p3, label="") {
     
     difference() {
          intersection() {
               beam(p1, p3, p2, "olive", label) {
               };
               in_mounting_referential(p1, p2) {
                    beam1_tenon();
                    
               }
          }
          
         translate([500, 0, 0]) {
              cube([1000, 1000, 1000], center=true);
         }
         
       
          
      
    }  
}
 

module create_beams2(points, beams) {
     for (beam=beams) {
          p1p = points[beam[0]];
          p2p = points[beam[1]];
          p3p = points[beam[2]];
          

         /*prepare_for_stl(p1p, p2p, p3p, 0) {
               difference() {
                    beam1(p1p, p2p, p3p, tolerance=Tolerance);
                     translate([500, 0, 0]) {
                         cube([1000, 1000, 1000], center=true);
                    } 
               }  
          } */   

         
         prepare_for_stl(p1p, p3p, p2p, 1) {
               difference() {
                    beam2(p1p, p2p, p3p);
                    translate([500, 0, 0]) {
                         cube([1000, 1000, 1000], center=true);
                    }
               } 
          }      
          
     }
} 
