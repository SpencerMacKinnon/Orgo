//
//  SWMVertexData.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMVertexData.h"

@implementation SWMVertexData

//- (id)initCube{
//    self = [super init];
//    
//    if (self) {
//        
//        const SWMVertex1P1N1D1UV Vertices[] = {
//            // Front
//            {{1, -1, 1}, {0, 0, 1}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{1, 1, 1}, {0, 0, 1}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{-1, 1, 1}, {0, 0, 1}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{-1, -1, 1}, {0, 0, 1}, {0, 0, 0, 1}, {0, 0}},
//            // Back
//            {{1, 1, -1}, {0, 0, -1}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{-1, -1, -1}, {0, 0, -1}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{1, -1, -1}, {0, 0, -1}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{-1, 1, -1}, {0, 0, -1}, {0, 0, 0, 1}, {0, 0}},
//            // Left
//            {{-1, -1, 1}, {-1, 0, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{-1, 1, 1}, {-1, 0, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{-1, 1, -1}, {-1, 0, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{-1, -1, -1}, {-1, 0, 0}, {0, 0, 0, 1}, {0, 0}},
//            // Right
//            {{1, -1, -1}, {1, 0, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{1, 1, -1}, {1, 0, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{1, 1, 1}, {1, 0, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{1, -1, 1}, {1, 0, 0}, {0, 0, 0, 1}, {0, 0}},
//            // Top
//            {{1, 1, 1}, {0, 1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{1, 1, -1}, {0, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{-1, 1, -1}, {0, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{-1, 1, 1}, {0, 1, 0}, {0, 0, 0, 1}, {0, 0}},
//            // Bottom
//            {{1, -1, -1}, {0, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
//            {{1, -1, 1}, {0, -1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
//            {{-1, -1, 1}, {0, -1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
//            {{-1, -1, -1}, {0, -1, 0}, {0, 0, 0, 1}, {0, 0}}
//        };
//        
//        _vertexData = [[NSMutableData alloc] initWithBytes:Vertices length:sizeof(Vertices)];
//        _numberOfVertices = sizeof(Vertices) / sizeof(SWMVertex1P1N1D1UV);
//        
//        const GLubyte Indices[] = {
//            // Front
//            0, 1, 2,
//            2, 3, 0,
//            // Back
//            4, 5, 6,
//            4, 5, 7,
//            // Left
//            8, 9, 10,
//            10, 11, 8,
//            // Right
//            12, 13, 14,
//            14, 15, 12,
//            // Top
//            16, 17, 18,
//            18, 19, 16,
//            // Bottom
//            20, 21, 22,
//            22, 23, 20
//        };
//        
//        _indexData = [[NSMutableData alloc] initWithBytes:Indices length:sizeof(Indices)];
//        _numberOfIndices = sizeof(Indices) / sizeof(Indices[0]);
//        
//        _indexType = GLU_BYTE;
//        _vertexType = SWM_P1N1D1UV;
//    }
//    
//    return self;
//}

- (id)initCylinderWithSlices:(int) slices withExistingVertexCount:(GLushort)existingVertexCount andOffset:(GLuint)offset{
    self = [super init];
    if (self) {
        _existingVertexCount = existingVertexCount;
        self.offset = offset;
        self.vertexSetName = @"CYLINDER";
        _indexType = GLU_SHORT;
        _vertexType = SWM_1P1N;
        _middlePointDictionary = [[NSMutableDictionary alloc] init];
        _vertices = [[NSMutableArray alloc] init];
        _vertexIndices = [[NSMutableArray alloc] init];
        
        [self generateCylinderWithSlices:slices];
    }
    
    return self;
}

- (void)generateCylinderWithSlices:(int)slices{
    
    float decreasePerSlice = 1.0 / slices;
    float currentSliceLevel = 1.0;
    int trianglesInSlice = 4.0 * 4.0;
    float sliceStepRadians = (2 * M_PI) / trianglesInSlice;
    float currentRadians = 0.0;
    
    for (currentSliceLevel = 1.0; currentSliceLevel >= -1.0; currentSliceLevel -= decreasePerSlice) {
        for (currentRadians = 0; currentRadians <= (2 * M_PI); currentRadians += sliceStepRadians) {
            
            SWMVertex1P1N vertex =
            {
                {cosf(currentRadians), currentSliceLevel, sinf(currentRadians)},
                {cosf(currentRadians), currentSliceLevel, sinf(currentRadians)}
            };
            
            
            [self.vertexData appendBytes:&vertex length:sizeof(SWMVertex1P1N)];
            self.numberOfVertices++;
        }
    }
    
    for (int i = 0; i <= slices; i++) {
        for (int j = 0; j < trianglesInSlice; j++) {
            
            GLushort a = (j % trianglesInSlice) + (i * trianglesInSlice) + _existingVertexCount;
            GLushort b = ((j + 1)  % trianglesInSlice) + (i * trianglesInSlice) + _existingVertexCount;
            GLushort c = (j % trianglesInSlice) + ((i + 1) * trianglesInSlice) + _existingVertexCount;
            GLushort d = ((j + 1) % trianglesInSlice) + ((i + 1) * trianglesInSlice)  + _existingVertexCount;
            
            [self.indexData appendBytes:&a length:sizeof(GLushort)];
            [self.indexData appendBytes:&b length:sizeof(GLushort)];
            [self.indexData appendBytes:&c length:sizeof(GLushort)];
            
            [self.indexData appendBytes:&c length:sizeof(GLushort)];
            [self.indexData appendBytes:&d length:sizeof(GLushort)];
            [self.indexData appendBytes:&b length:sizeof(GLushort)];
        }
    }
    
    self.numberOfIndices = [self.indexData length] / sizeof(GLushort);
}

- (id)initSphereWithRecursionLevel:(int)recursionLevel withExistingVertexCount:(GLushort)existingVertexCount andOffset:(GLuint)offset{
    self = [super init];
    if (self) {
        // golden ratio
        t = (1.0 + sqrt(5.0)) / 2.0;
        _existingVertexCount = existingVertexCount;
        self.offset = offset;
        index = 0;
        _indexType = GLU_SHORT;
        _vertexType = SWM_1P1N;
        _middlePointDictionary = [[NSMutableDictionary alloc] init];
        _vertices = [[NSMutableArray alloc] init];
        _vertexIndices = [[NSMutableArray alloc] init];
        [self generateSphereWithRecursionLevel:recursionLevel];
    }
    return self;
}

- (void)generateSphereWithRecursionLevel:(int)recursionLevel {
    [self populateInitialVerticesAndIndicesForIcosahedron];
    
    for (int i = 0; i < recursionLevel; i++) {
        NSMutableArray *newVertexIndices = [[NSMutableArray alloc] init];
        for (int j = 0; j < [_vertexIndices count]; j+=3) {
            GLushort x;
            [[_vertexIndices objectAtIndex:j] getValue:&x];
            
            GLushort y;
            [[_vertexIndices objectAtIndex:j+1] getValue:&y];
            
            GLushort z;
            [[_vertexIndices objectAtIndex:j+2] getValue:&z];
            
            GLushort a = [self getMiddlePoint:x withSecondPoint:y];
            GLushort b = [self getMiddlePoint:y withSecondPoint:z];
            GLushort c = [self getMiddlePoint:z withSecondPoint:x];
            
            [newVertexIndices addObject:[NSValue value:&x withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&a withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&c withObjCType:@encode(GLushort)]];
            
            [newVertexIndices addObject:[NSValue value:&y withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&b withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&a withObjCType:@encode(GLushort)]];
            
            [newVertexIndices addObject:[NSValue value:&z withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&c withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&b withObjCType:@encode(GLushort)]];
            
            [newVertexIndices addObject:[NSValue value:&a withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&b withObjCType:@encode(GLushort)]];
            [newVertexIndices addObject:[NSValue value:&c withObjCType:@encode(GLushort)]];
        }
        _vertexIndices = [[NSMutableArray alloc] initWithArray:newVertexIndices];
    }
    
    self.numberOfVertices = [_vertices count];
    
    for (int i = 0; i < self.numberOfVertices; i++) {
        SWMVertex1P1N vertex;
        [[_vertices objectAtIndex:i] getValue:&vertex];
        [self.vertexData appendBytes:&vertex length:sizeof(SWMVertex1P1N)];
    }
    
    self.numberOfIndices = [_vertexIndices count];
    
    for (int i = 0; i < self.numberOfIndices; i++) {
        GLushort vertexIndex;
        [[_vertexIndices objectAtIndex:i] getValue:&vertexIndex];
        vertexIndex += _existingVertexCount;

        [self.indexData appendBytes:&vertexIndex length:sizeof(GLushort)];
    }
}
                                                           
- (int)addVertex:(SWMVertex1P1N *)vertex{
    GLKVector3 position = GLKVector3MakeWithArray(vertex -> _position);
    
    double length = sqrt(position.x * position.x + position.y * position.y + position.z * position.z);
    GLKVector3 normalizedPosition = GLKVector3Make(position.x / length, position.y / length, position.z / length);
    
    SWMVertex1P1N newVertex =
    {
        {normalizedPosition.x, normalizedPosition.y, normalizedPosition.z},
        {normalizedPosition.x, normalizedPosition.y, normalizedPosition.z}
    };
    
    [_vertices addObject:[NSValue value:&newVertex withObjCType:@encode(SWMVertex1P1N)]];
    return index++;
}

- (GLushort)getMiddlePoint:(GLushort)p1 withSecondPoint:(GLushort)p2 {
    bool firstIsSmaller = p1 < p2;
    GLuint smallerIndex = firstIsSmaller ? p1 : p2;
    GLuint greaterIndex = firstIsSmaller ? p2 : p1;
    
    GLuint key = (smallerIndex << 16) + greaterIndex;
    
    if ([_middlePointDictionary objectForKey:[NSNumber numberWithUnsignedInt:key]]) {
        NSNumber *shortValue = [_middlePointDictionary objectForKey:[NSNumber numberWithUnsignedInt:key]];
        return [shortValue unsignedShortValue];
    }
    
    SWMVertex1P1N firstVertex;
    [[_vertices objectAtIndex:p1] getValue:&firstVertex];
    GLKVector3 point1 = GLKVector3MakeWithArray(firstVertex._position);
    
    SWMVertex1P1N secondVertex;
    [[_vertices objectAtIndex:p2] getValue:&secondVertex];
    GLKVector3 point2 = GLKVector3MakeWithArray(secondVertex._position);
    
    GLKVector3 point3 = GLKVector3Make((point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.z + point2.z) / 2.0);
    
    SWMVertex1P1N thirdVertex =
    {
        {point3.x, point3.y, point3.z},
        {point3.x, point3.y, point3.z}
    };
    
    GLushort i = [self addVertex:&thirdVertex];
    [_middlePointDictionary setObject:[NSNumber numberWithUnsignedShort:i] forKey:[NSNumber numberWithUnsignedInt:key]];
    
    return i;
}

- (void)populateInitialVerticesAndIndicesForIcosahedron{
    
    SWMVertex1P1N Vertices [] = {
        //XY Face
        {
            {-1, t, 0},
            {-1, t, 0}
        },
        {
            {1, t, 0},
            {1, t, 0}
        },
        {
            {-1, -t, 0},
            {-1, -t, 0}
        },
        {
            {1, -t, 0},
            {1, -t, 0}
        },
        
        // YZ Face
        {
            {0, -1, t},
            {0, -1, t}
        },
        {
            {0, 1, t},
            {0, 1, t}
        },
        {
            {0, -1, -t},
            {0, -1, -t}
        },
        {
            {0, 1, -t},
            {0, 1, -t}
        },
        
        // XZ Face
        {
            {t, 0, -1},
            {t, 0, -1}
        },
        {
            {t, 0, 1},
            {t, 0, 1}
        },
        {
            {-t, 0, -1},
            {-t, 0, -1}
        },
        {
            {-t, 0, 1},
            {-t, 0, 1}
        }
    };
    
    for (int i = 0; i < 12; i++) {
        [self addVertex:&(Vertices[i])];
    }
    
    const GLushort Indices[] = {
        0, 11, 5,
        0, 5, 1,
        0, 1, 7,
        0, 7, 10,
        0, 10, 11,
        
        1, 5, 9,
        5, 11, 4,
        11, 10, 2,
        10, 7, 6,
        7, 1, 8,
        
        3, 9, 4,
        3, 4, 2,
        3, 2, 6,
        3, 6, 8,
        3, 8, 9,
        
        4, 9, 5,
        2, 4, 11,
        6, 2, 10,
        8, 6, 7,
        9, 8, 1
    };
    
    for (int i = 0; i < 60; i++) {
        [_vertexIndices addObject:[NSValue value:&(Indices[i]) withObjCType:@encode(GLushort)]];
    }
}

@end

