//
//  SWMModelGenerator.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SWMVertex.h"
#include "SWMVertex1P1D.h"
@interface SWMModelGenerator : NSObject {
    int index;
}

//+ (SWMVertex1P1D *)generateSphereWithRadius:(int)radius numberOfTriangleStrips:(int)triangleStrips numberOfTrianglesInTriangleStrip:(int)numTriangleStrip diffuseColour:(GLKVector4)colour;
- (id)initSphereWithRecursionLevel:(int) recursionLevel andColour:(GLKVector4)diffuseColour;

@property NSMutableDictionary *middlePointDictionary;
@property NSMutableArray *vertices;
@property NSMutableData *vertexData;
@property NSMutableArray *vertexIndices;
@end
