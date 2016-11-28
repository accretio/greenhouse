#include <stdio.h>
#include <stdlib.h>

//include <GL/gl.h>
//  include <GL/glu.h>
//  include <GL/glut.h>
#include "matrix.h"

#include "geodesic.c"


#define MAX_NUMBER_OF_POINTS 100
#define MAX_JOINT_CARDINALITY 6

#define X 0
#define Y 1
#define Z 2

#define BLACK 0
#define RED 1
#define GREEN 2
#define ORANGE 3
#define PINK 4
#define BLUE 5

struct beam_t {
  int point;
  int position; // we are going to number f
  int color;
  
  // some helpers
  flo_t in_black_referential[3];  
};
  
struct joint_t {
  int center;
  struct beam_t beams[MAX_JOINT_CARDINALITY];
};
  
void printIfMissing(int *wit, int rowSize, unsigned short p1, unsigned short p2, int comma) {
  if (!wit[p1 * rowSize + p2] && !wit[p2 * rowSize + p1]) {
    if (comma) {
      printf(",\n");
    }
    printf("[%hi, %hi]", p1, p2);
    wit[p1 * rowSize + p2] = 1;
    wit[p2 * rowSize + p1] = 1;
  }
}




int rawPoints() {
  printf("exporting data\n");

  geodesicDome dome = icosahedronDome(2, 5/9);  // 3v 5/9 dome

  printf("polyhedron( points = [\n");

  for (int i=0; i < dome.sphere.numPoints * 3; i= i + 3) {
    flo_t px = dome.sphere.points[i];
    flo_t py = dome.sphere.points[i+1];
    flo_t pz = dome.sphere.points[i+2];
    if (i > 0)
      printf(",\n");
    printf("[%f, %f, %f]", 100*px, 100*py, 100*pz); 
  }
      
  printf("], triangles = [\n");
  for (int i=0; i < dome.sphere.numFaces * 3 / 2; i= i + 3) {
    unsigned short px = dome.sphere.faces[i];
    unsigned short py = dome.sphere.faces[i+1];
    unsigned short pz = dome.sphere.faces[i+2];
    if (i > 0)
      printf(",\n");
    printf("[%hi, %hi, %hi]", px, py, pz);
          
                  
  }

  printf("], beams = [\n");

  int *wit = (int *)malloc(dome.sphere.numPoints * dome.sphere.numPoints * sizeof(int));
  for (int i=0; i < dome.sphere.numPoints * dome.sphere.numPoints; i++) {
    wit[i]=0;
  }
      
  for (int i=0; i < dome.sphere.numFaces * 3 / 2; i= i + 3) {
    unsigned short px = dome.sphere.faces[i];
    unsigned short py = dome.sphere.faces[i+1];
    unsigned short pz = dome.sphere.faces[i+2];
            
    printIfMissing(wit, dome.sphere.numPoints, px, py, i != 0);
    printIfMissing(wit, dome.sphere.numPoints, px, pz, 1);
    printIfMissing(wit, dome.sphere.numPoints, py, pz, 1);
  }
      
  printf("])\n") ;
  return 0;
}



#define BEAM_ID(p1, p2) =  min(p1 * MAX_NUMBER_OF_POINTS + p2, p2 * MAX_NUMBER_OF_POINTS + p1)

int add_point_to_joint(struct joint_t *joint, int p) {
  int j = 0 ;
  while (joint->beams[j].point) {
    if (joint->beams[j].point == p) {
      return 0; 
    }
    j++;
  }
  joint->beams[j].point = p;
  return 0;
}

int joint_cardinality(struct joint_t *joint) {
  int j = 0; 
  while (joint->beams[j].point && j < MAX_JOINT_CARDINALITY) { j++; }
  return j;
}


static int
compare_beams(const void *p1, const void *p2)
{
 
  struct beam_t *beam1 = (struct beam_t *)p1;
  struct beam_t *beam2 = (struct beam_t *)p2;
  
  // the comparison function is not really trivial to write
  //
  //
  // we want the beam with the lowest point to be the 0 (black)
  // we want the beam with the highest point to be the top (orange)
  //

  return (beam1->color - beam2->color);
}


#define POINT(__id__) &(points[3*__id__])

#define BEAM_POINT_X(__id__) points[3*(joint->beams[__id__].point)]
#define BEAM_POINT_Y(__id__) points[3*(joint->beams[__id__].point) + 1]
#define BEAM_POINT_Z(__id__) points[3*(joint->beams[__id__].point) + 2]

#define POINT_X(__id__) points[3*(__id__)]
#define POINT_Y(__id__) points[3*(__id__) + 1]
#define POINT_Z(__id__) points[3*(__id__) + 2]

int sort_joint(flo_t *points, struct joint_t *joint) {
  int c;

  c = joint_cardinality(joint);
 
  /*  void qsort(void *base, size_t nmemb, size_t size,
      int (*compar)(const void *, const void *));

      void qsort_r(void *base, size_t nmemb, size_t size,
      int (*compar)(const void *, const void *, void *),
      void *arg);
  */
  // qsort_r(joint->beams, c, sizeof(struct beam_t), points, compare_beams);
  // return 0;

  switch(c) {
  case 0:
    // silently ignore this joint
    break; 
  case 6:
    printf("sorting joint with cardinality 6\n");
    
    // we want the beam with the lowest point to be the 0 (black)
    // we want the beam with the highest point to be the top (orange)

    int lowest_beam = 0;
   
    for (int i=1; i < c; i++) {
      if (BEAM_POINT_Z(i) < BEAM_POINT_Z(lowest_beam)) {
        lowest_beam = i;
      }
    }
    printf("lowest: %d\n", lowest_beam);

    // here we have the black beam. now we need to move all the other points into the new referential

    printf("joint center is %d\n", joint->center);
    flo_t zn[3] = { POINT_X(joint->center), 
                    POINT_Y(joint->center),
                    POINT_Z(joint->center) } ;

    printf("got zn\n");
    // would need to be normalized, but doesn't matter for now
    flo_t xn[3] = {
      BEAM_POINT_X(lowest_beam) - POINT_X(joint->center),
      BEAM_POINT_Y(lowest_beam) - POINT_Y(joint->center),
      BEAM_POINT_Z(lowest_beam) - POINT_Z(joint->center),
    } ; 

    /* flo_t xn[3] = { 1.0, 0.0, 0.0 } ;
       flo_t yn[3] = { 0.0, 1.0, 0.0 } ;
    */
    flo_t yn[3];

    cross(zn, xn, yn);

    printf("zn is %f %f %f\n", zn[0], zn[1], zn[2]);
    flo_t *m[3] = { xn, yn, zn };
    Transpose(m, 3);
    flo_t *co[3];
    for(int i=0; i < 3; i++) {
      co[i] = (flo_t *)malloc(sizeof(flo_t)*3);
    }
    
    CoFactor(m, 3, co);
    Transpose(co, 3);
    float det = Determinant(m, 3);
    for(int i=0; i < 3; i++) {
      for (int j=0; j < 3; j++) {
        co[i][j] = co[i][j] / det;
        printf("(%d, %d) = %f\n", i, j, co[i][j]); 
      }
    }

    for (int i=0; i < c; i++) {
      if (/* i != lowest_beam */ 1)  {
        
        // cf. http://stackoverflow.com/questions/29754538/rotate-object-from-one-coordinate-system-to-another
       
        flo_t point_in_black_referential[3] = { 1.0, 0.0, 0.0 };

        printf("joint center is %f %f %f\n", (POINT(joint->center))[0],
               (POINT(joint->center))[1],
               (POINT(joint->center))[2]);
             
        printf("let's move the center in the black referential\n");
        mult(co, (POINT(joint->center)), point_in_black_referential);

        printf("in black referential: %f %f %f\n",
               point_in_black_referential[0],
               point_in_black_referential[1],
               point_in_black_referential[2]);

        // and the point itself
        mult(co, POINT(joint->beams[i].point), &(joint->beams[i].in_black_referential));

        // then we need to add the 0.
        // add(POINT(joint->center), point_in_black_referential, point_in_black_referential);
        if (i == lowest_beam) {
          printf("LOWEST BEAM ");
        }
        
        printf("in black referential beam end: %f %f %f\n",
               (joint->beams[i].in_black_referential)[0],
               (joint->beams[i].in_black_referential)[1],
               (joint->beams[i].in_black_referential)[2]) ;
         

      }

    }

    // now each joint has the coordinates in the black beam referential. we can sort the beams & put colors on them

    int green = 0;
    flo_t max_x = -INFINITY; 
    for (int i = 0; i < c; i++) {
      if (i != lowest_beam) {
        flo_t *in_black_referential = joint->beams[i].in_black_referential;
        if (in_black_referential[1] < 0 && in_black_referential[X] > max_x) {
          green = i;
          max_x = in_black_referential[X];
        }
      }
    }

    int red = 0;
    max_x = -INFINITY;
    for (int i = 0; i < c; i++) {
      if (i != lowest_beam) {
        flo_t *in_black_referential = joint->beams[i].in_black_referential;
        if (in_black_referential[1] > 0 && in_black_referential[0] > max_x) {
          red = i;
          max_x = in_black_referential[X];
        }
      }
    }

    
    

    // now the pink beam is the one on the side of negative Y that has the bigger x

    max_x = -INFINITY;
    int pink = 0 ;
    for (int i = 0; i < c; i++) {
      if (i != lowest_beam && i != green && i != red) {
        flo_t *in_black_referential = joint->beams[i].in_black_referential;
        if (in_black_referential[1] < 0 && in_black_referential[X] > max_x) {
          pink = i;
          max_x = in_black_referential[X];
        }
      }
    }


    // the blue beam is the one on the side of positive Y that has the bigger x
    max_x = -INFINITY;
    int blue = 0 ;
    for (int i = 0; i < c; i++) {
      if (i != lowest_beam && i != green && i != red && i != pink) {
        flo_t *in_black_referential = joint->beams[i].in_black_referential;
        if (in_black_referential[1] > 0 && in_black_referential[X] > max_x) {
          blue = i;
          max_x = in_black_referential[X];
        }
      }
    }

    // the orange is the last one

    int orange = 0 ;
    for (int i = 0; i < c; i++) {
      if (i != lowest_beam && i != green && i != red && i != pink && i != blue) {
        orange = i;
      }
    }

    printf("center: %d, black: %d, green: %d, pink: %d, orange: %d, blue: %d, red: %d\n", joint->center, lowest_beam, green, pink, orange, blue, red); 




    // now we use that information to tag the beams

    joint->beams[lowest_beam].color = BLACK;
    joint->beams[green].color = GREEN;
    joint->beams[pink].color = PINK;
    joint->beams[orange].color = ORANGE;
    joint->beams[blue].color = BLUE;
    joint->beams[red].color = RED;
        
    break;
    
  default:
    printf("skipping joint, cardinality is %d\n", c);
    break;
  }

  return 0;
}


// export the data to scad


int export_joint(flo_t *points, struct joint_t *joint) {
  int c;


  c = joint_cardinality(joint);

  switch(c) {
  case 6:

    // we need to sort them by color
    
    qsort(joint->beams, c, sizeof(struct beam_t), compare_beams);

    // the we print the points.

    printf("[%d, %d, %d, %d, %d, %d, %d]",
           joint->center,
           joint->beams[0].point,
           joint->beams[1].point,
           joint->beams[2].point,
           joint->beams[3].point,
           joint->beams[4].point,
           joint->beams[5].point);         
    
    break;
    
  default:
    break;
  }
  
      
  return 0;
}

int main() {

  geodesicDome dome = icosahedronDome(2, 5/9);  // 3v 5/9 dome

  struct joint_t joints[MAX_NUMBER_OF_POINTS];

  // initializing the map
  for (int i = 0; i < MAX_NUMBER_OF_POINTS; ++i) {
    for (int j = 0; j < MAX_JOINT_CARDINALITY; ++j) {
      joints[i].center = i;
      joints[i].beams[j].point = 0;
      joints[i].beams[j].position = 0;
    }
  }
  
  // we are interested in the joints
  // so the id for the beam is min(p1 * 1000 + p2, p2 * 1000 + p1)
  
  for (int i=0; i < dome.sphere.numFaces * 3 / 2; i = i + 3) {
    unsigned short px = dome.sphere.faces[i];
    unsigned short py = dome.sphere.faces[i+1];
    unsigned short pz = dome.sphere.faces[i+2];

    add_point_to_joint(&joints[px], py);
    add_point_to_joint(&joints[px], pz);
    
    add_point_to_joint(&joints[py], px);
    add_point_to_joint(&joints[py], pz);

    add_point_to_joint(&joints[pz], px);
    add_point_to_joint(&joints[pz], py);
  }
  
  for (int i=0; i < dome.sphere.numPoints; ++i) {
    struct joint_t joint = joints[i];
    printf("joint from point %d: %d %d %d %d %d %d - %d\n",
           i,
           joint.beams[0].point,
           joint.beams[1].point,
           joint.beams[2].point,
           joint.beams[3].point,
           joint.beams[4].point,
           joint.beams[5].point,
           joint_cardinality(&joint)); 
  }

  // at this point we need to order the points for each joints
  
  for (int i=0; i < dome.sphere.numPoints; ++i) {
    struct joint_t joint = joints[i];
    sort_joint(dome.sphere.points, &joint);
  }


  // here we have all the beams of all the joints (for now, all the 6 beams joints) tagged with the appropriate colors


  printf("\n\nbeams = [\n"); 
  
  for (int i=0; i < dome.sphere.numPoints; ++i) {
    struct joint_t joint = joints[i];
    export_joint(dome.sphere.points, &joint);
    if (i < dome.sphere.numPoints - 1) {
      printf(",\n");
    }
  }

  printf("];\n\n");
  
  return 0; 
}
