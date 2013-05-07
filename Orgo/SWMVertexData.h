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

//- (id)initCube;
- (id)initSphereWithRecursionLevel:(int)recursionLevel withExistingVertexCount:(GLushort)existingVertexCount andOffset:(GLuint)offset;
- (id)initCylinderWithSlices:(int)slices withExistingVertexCount:(GLushort)existingVertexCount andOffset:(GLuint)offset;

@end
