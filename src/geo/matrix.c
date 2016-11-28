#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
   Recursive definition of determinate using expansion by minors.
*/
float Determinant(float **a,int n)
{
   int i,j,j1,j2;
   float det = 0;
   float **m = NULL;

   if (n < 1) { /* Error */

   } else if (n == 1) { /* Shouldn't get used */
      det = a[0][0];
   } else if (n == 2) {
      det = a[0][0] * a[1][1] - a[1][0] * a[0][1];
   } else {
      det = 0;
      for (j1=0;j1<n;j1++) {
         m = malloc((n-1)*sizeof(float *));
         for (i=0;i<n-1;i++)
            m[i] = malloc((n-1)*sizeof(float));
         for (i=1;i<n;i++) {
            j2 = 0;
            for (j=0;j<n;j++) {
               if (j == j1)
                  continue;
               m[i-1][j2] = a[i][j];
               j2++;
            }
         }
         det += pow(-1.0,j1+2.0) * a[0][j1] * Determinant(m,n-1);
         for (i=0;i<n-1;i++)
            free(m[i]);
         free(m);
      }
   }
   return(det);
}

/*
   Find the cofactor matrix of a square matrix
*/
void CoFactor(float **a,int n,float **b)
{
   int i,j,ii,jj,i1,j1;
   float det;
   float **c;

   c = malloc((n-1)*sizeof(float *));
   for (i=0;i<n-1;i++)
     c[i] = malloc((n-1)*sizeof(float));

   for (j=0;j<n;j++) {
      for (i=0;i<n;i++) {

         /* Form the adjoint a_ij */
         i1 = 0;
         for (ii=0;ii<n;ii++) {
            if (ii == i)
               continue;
            j1 = 0;
            for (jj=0;jj<n;jj++) {
               if (jj == j)
                  continue;
               c[i1][j1] = a[ii][jj];
               j1++;
            }
            i1++;
         }

         /* Calculate the determinate */
         det = Determinant(c,n-1);

         /* Fill in the elements of the cofactor */
         b[i][j] = pow(-1.0,i+j+2.0) * det;
      }
   }
   for (i=0;i<n-1;i++)
      free(c[i]);
   free(c);
}

/*
   Transpose of a square matrix, do it in place
*/
void Transpose(float **a,int n)
{
   int i,j;
   float tmp;

   for (i=1;i<n;i++) {
      for (j=0;j<i;j++) {
         tmp = a[i][j];
         a[i][j] = a[j][i];
         a[j][i] = tmp;
      }
   }
}


void cross(float *a, float *b, float *res) {
  res[0] = a[1] * b[2] - a[2] * b[1];
  res[1] = a[2] * b[0] - a[0] * b[2];
  res[2] = a[0] * b[1] - a[1] * b[0];
  return ;
}


void mult(float **mat, float *v, float *res)
{
  res[0] = mat[0][0] * v[0] + mat[0][1] * v[1] + mat[0][2] * v[2];
  res[1] = mat[1][0] * v[0] + mat[1][1] * v[1] + mat[1][2] * v[2];
  res[2] = mat[2][0] * v[0] + mat[2][1] * v[1] + mat[2][2] * v[2];
}


void add(float *a, float *b, float *res)
{
  res[0] = a[0] + b[0];
  res[1] = a[1] + b[1];
  res[2] = a[2] + b[2];
}
