module wire(p1, p2, diameter, color) {
     axle = p2-p1;
     length = norm(axle); 
       
     b = acos(axle[2]/length); // inclination angle
     c = atan2(axle[1], axle[0]);     // azimuthal angle
 
     translate(p1) {
          rotate([0, b, c]) {
               color(color) {
                    translate([0, 0, length/2]) {
               cylinder(length, diameter/2, diameter/2, length, center=true);
                    }
               }
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
