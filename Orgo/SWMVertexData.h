//
//  SWMVertexData.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMVertexArray.h"

@interface SWMVertexData : SWMVertexArray{
    int t;
    GLushort index, _existingVertexCount;
    NSMutableArray *_vertices, *_vertexIndices;
    NSMutableDictionary *_middlePointDictionary;
}

- (id)initCube;
- (id)initSphereWithRecursionLevel:(int) recursionLevel andColour:(GLKVector4)diffuseColour andExistingVertexCount:(GLushort)existingVertexCount;
- (id)initCylinderWithSlices:(int) slices andColour:(GLKVector4)diffuseColour andExistingVertexCount:(GLushort)existingVertexCount;

@end
