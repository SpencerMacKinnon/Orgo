//
//  SWMModelGenerator.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SWMVertexArray.h"
@interface SWMModelGenerator : SWMVertexArray{
    int t;
    GLushort index;
    NSMutableArray *_vertices, *_vertexIndices;
    NSMutableDictionary *_middlePointDictionary;
}

//+ (SWMVertex1P1D *)generateSphereWithRadius:(int)radius numberOfTriangleStrips:(int)triangleStrips numberOfTrianglesInTriangleStrip:(int)numTriangleStrip diffuseColour:(GLKVector4)colour;
- (id)initCube;
- (id)initSphereWithRecursionLevel:(int) recursionLevel andColour:(GLKVector4)diffuseColour;

@end
