//
//  SWMVertexArray.m
//  Life
//
//  Created by Spencer MacKinnon on 2/21/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMVertexArray.h"

@implementation SWMVertexArray

@synthesize numberOfIndices = _numberOfIndices;
@synthesize numberOfVertices = _numberOfVertices;
@synthesize indexData = _indexData;
@synthesize vertexData = _vertexData;

- (id)init{
    self = [super init];
    if (self) {
        
        const SWMVertex1P1D1UV Vertices[] = {
            {{1, -1, 0.5}, {0, 0, 1}, {1, 0, 0, 1}, {1, 0}},
            {{1, 1, 0.5}, {0, 0, 1}, {1, 0, 0, 1}, {1, 1}},
            {{-1, 1, 0.5}, {0, 0, 1}, {0, 1, 0, 1}, {0, 1}},
            {{-1, -1, 0.5}, {0, 0, 1}, {0, 1, 0, 1}, {0, 0}},
            {{1, -1, -0.5}, {0, 0, 1}, {1, 0, 0, 1}, {1, 0}},
            {{1, 1, -0.5}, {0, 0, 1}, {1, 0, 0, 1}, {1, 1}},
            {{-1, 1, -0.5}, {0, 0, 1}, {0, 1, 0, 1}, {0, 1}},
            {{-1, -1, -0.5}, {0, 0, 1}, {0, 1, 0, 1}, {0, 0}}
        };
        _vertexData = [[NSMutableData alloc] initWithBytes:Vertices length:sizeof(Vertices)];
        _numberOfVertices = sizeof(Vertices) / sizeof(SWMVertex1P1D1UV);
        
        const GLubyte Indices[] = {
            // Front
            0, 1, 2,
            2, 3, 0,
            // Back
            4, 5, 6,
            6, 7, 4,
            // Left
            8, 9, 10,
            10, 11, 8,
            // Right
            12, 13, 14,
            14, 15, 12,
            // Top
            16, 17, 18,
            18, 19, 16,
            // Bottom
            20, 21, 22,
            22, 23, 20
        };
        
        _indexData = [[NSMutableData alloc] initWithBytes:Indices length:sizeof(Indices)];
        _numberOfIndices = sizeof(Indices) / sizeof(Indices[0]);
    }
    
    return self;
}

@end
