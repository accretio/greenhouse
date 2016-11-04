// let's tinker with the beams

// standard bricks: 92 x 57 x 203


Radius=2000; 
BrickLength=203;
BrickHeight=57;

BaseNumberOfLayers=6; 
BaseDoorLevel=2;
module brick() {
    
    cube([92, BrickLength, BrickHeight]);
}

module ring(yOffset, zOffset) {
     alpha = asin(BrickLength / (Radius)) ; 
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
    for (i=[1:BaseNumberOfLayers]) {
        zOffset = i * BrickHeight; 
        if (i % 2 == 1) { 
            ring(- BrickLength / 2, zOffset);
        } else {
            ring(0, zOffset);
        }
       
    }
}

base();