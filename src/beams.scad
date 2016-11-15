// let's tinker with the beams

// standard bricks: 92 x 57 x 203

include <data.scad>;

Radius=2000; 
BrickDepth = 92;
BrickLength=203;
BrickHeight=57;

BaseNumberOfLayers=6; 
BaseDoorLevel=2;
module brick() {
    
    cube([92, BrickLength, BrickHeight]);
}

 alpha = asin(BrickLength / (Radius)) ; 
    
module ring(yOffset, zOffset) {
     numberOfBricks = 360 / alpha; 
    
     for (i =[0:(numberOfBricks)]) {
         // let's position the brick at the right place
         rotate([0, 0, i*alpha]) {
             translate([Radius, yOffset, zOffset]) {
                brick();
            }
        }
     }
}

module base() {
        for (i=[0:(BaseNumberOfLayers - 1)]) {
        zOffset = i * BrickHeight; 
        if (i % 2 == 1) { 
            ring(- BrickLength / 2, zOffset);
        } else {
            ring(0, zOffset);
        }
       
    }; 
     
}

    

module dome() {
 // translate([0, 0, BrickHeight * BaseNumberOfLayers]) {
  //rotate([0, 90, 0])
    polyhedron((Radius + BrickDepth /2) / 100 * points2, triangles2);
 // }
}

//dome();
//base();

function distance (p1, p2) =  
  ([ p1[0] - p2[0], p1[1] - p2[1], p1[2] - p2[2] ]); 



BeamWidth= 100; 
ScaleFactor=10;

module element(length) {
    translate([0, 0, length/2]) {
        cube([10, 10, length], center=true);
    }
}
module beam(p1, p2) {
    axle = p2-p1;
    length = norm(axle);
       
    b = acos(axle[2]/length); // inclination angle
    c = atan2(axle[1], axle[0]);     // azimuthal angle

    translate(p1) {
        rotate([0, b, c]) {
           element(length);
        }
    }
}


module create_beams(points, triangles) {
    for(triangle=triangles) {
        p1 = ScaleFactor * points[triangle[0]]; 
        p2 = ScaleFactor * points[triangle[1]]; 
        p3 = ScaleFactor * points[triangle[2]]; 
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
        beam(p1, p2);
        beam(p2, p3);
        beam(p1, p3);
        // il y a un peu de géometrie à faire .. 
        
        
       // polygon([p1, p2, p3], paths = [[ 0, 1 , 2 ,0 ]]);
        echo("----");
    }
}

create_beams(points2, triangles2);





///
