%{
%File: /build_score_mex.m
%Created Date: Wednesday August 23rd 2023
%Author: Hance Ng
%-----
%Last Modified: Wednesday, 23rd August 2023 3:54:41 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%}

% A square matrix with variable size
XType = coder.typeof(rand(1, 1), [Inf Inf], [1 1]);

% A logical row vector with variable length
IType = coder.typeof(true, [1 Inf], [0 1]);

% Another logical row vector with variable length
JType = coder.typeof(true, [1 Inf], [0 1]);

codegen score -args {XType, IType, JType}
