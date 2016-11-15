include <data.scad>

ScaleFactor=1;

module element(length, diameter) {
    translate([0, 0, length/2]) {
        cube([diameter, diameter, length], center=true);
    }
}

module beam(p1, p2, diameter) {
    axle = p2-p1;
    length = norm(axle);
       
    b = acos(axle[2]/length); // inclination angle
    c = atan2(axle[1], axle[0]);     // azimuthal angle

    translate(p1) {
        rotate([0, b, c]) {
           element(length, diameter);
        }
    }
}


module create_wire(points, triangles) {
     for(triangle=triangles) {
          p1 = ScaleFactor * points[triangle[0]]; 
          p2 = ScaleFactor * points[triangle[1]]; 
          p3 = ScaleFactor * points[triangle[2]];
          beam(p1, p2, 1);
          beam(p2, p3, 1);
          beam(p3, p1, 1);
     }
}

module create_beams(points, segments) {
    for(segment=segments) {
        p1 = ScaleFactor * points[segment[0]]; 
        p2 = ScaleFactor * points[segment[1]]; 
       // d1 = distance(points[p1], points[p2]);
       // d2 = distance(points[p1], points[p3]);
       // d3 = distance(points[p3], points[p2]);
       /* echo(norm(d1));
        echo(norm(d2));
        echo(norm(d3)); */
        // p1 -- p2
       /* rotate() {
            translate(ScaleFactor * points[p1]) {
                cube([ BeamWidth, BeamWidth, ScaleFactor * norm(d1)]);
            };
        } */
      
        // p1 -- p2
        beam(p1, p2, 10);
        // il y a un peu de géometrie à faire .. 
        
        
       // polygon([p1, p2, p3], paths = [[ 0, 1 , 2 ,0 ]]);
        echo("----");
    }
}




segments2 = [
     [38, 11],
     [36, 38],
     [39, 38],
     [31, 38],
     [38, 1],
     [33, 38],
          
      
     ];


create_wire(points2, triangles2); 
create_beams(points2, segments2);


