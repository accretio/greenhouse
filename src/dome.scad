// simple geodesic dome

include <data.scad>;

Radius=180; 
ScaleFactor=1;

module dome() { 
     polyhedron(points2, triangles2);
}

//dome();
//base();

Lip=10;

module element(length) {
          cylinder(length, r=5, $fn=20);
          translate([0, 0, -Lip/2]) {
               cylinder(Lip/2, r=5, $fn=20);
          }
          translate([0, 0, length]) {
               difference() {
                    cylinder(Lip/2, r=5, $fn=20);
                    cube(5, 5, Lip/2);
               }
          }
          element(length/2);

     
}


element(length=50); 


module beam(p1, p2) {

     // This is the transformation from the center cylinder to the side cylinder.
     // we could use this transformation as the actual construction technique?
     axle = p2-p1;
     length = norm(axle) ;
       
     b = acos(axle[2]/length); // inclination angle
     c = atan2(axle[1], axle[0]);     // azimuthal angle

     translate(p1) {
          rotate([0, b, c]) {
               element(length);
          }
     } 
     
}


module create_beams(points, beams) {
     for(b=beams) {
          p1 = ScaleFactor * points[b[0]]; 
          p2 = ScaleFactor * points[b[1]]; 
        
          beam(p1, p2);
      
     }
}

module create_joins(points) {
     for(p=points) {
          translate(p) {
               sphere(r=10);
          }
     }
}

