#ifndef MATRIX_H
#define MATRIX_H

void cross(float *a, float *b, float *res);
void CoFactor(float **a,int n,float **b);
void Transpose(float **a,int n);
float Determinant(float **a,int n);

void mult(float **mat, float *v, float *res);
void add(float *a, float *b, float *res);

#endif
