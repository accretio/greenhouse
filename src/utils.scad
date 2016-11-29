ScaleFactor=0.5;
BeamDiameter=10;
BeamLip=10;


PrepareForSTL=true;
STLSpacing=5;
Tolerance=0.2;


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
                              // TODO: redo the text
                            /*  if (PrepareForSTL) {
                                   translate([ScaleFactor * norm((p2-p1)) - TextHeight, 0, 0]) {
                                        rotate([0, 90, 0]) {
                                             linear_extrude(TextHeight) {
                                                  text(label, halign="center", valign="center", size=6);
                                             }
                                        }
                                   }
                              }*/
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
