//
//  SWMModelGenerator.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelGenerator.h"

@implementation SWMModelGenerator



- (id)initCube{
    self = [super init];
    
    if (self) {
        
        const SWMVertex1P1N1D1UV Vertices[] = {
            // Front
            {{1, -1, 1}, {0, 0, 1}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{1, 1, 1}, {0, 0, 1}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{-1, 1, 1}, {0, 0, 1}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{-1, -1, 1}, {0, 0, 1}, {0, 0, 0, 1}, {0, 0}},
            // Back
            {{1, 1, -1}, {0, 0, -1}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{-1, -1, -1}, {0, 0, -1}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{1, -1, -1}, {0, 0, -1}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{-1, 1, -1}, {0, 0, -1}, {0, 0, 0, 1}, {0, 0}},
            // Left
            {{-1, -1, 1}, {-1, 0, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{-1, 1, 1}, {-1, 0, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{-1, 1, -1}, {-1, 0, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{-1, -1, -1}, {-1, 0, 0}, {0, 0, 0, 1}, {0, 0}},
            // Right
            {{1, -1, -1}, {1, 0, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{1, 1, -1}, {1, 0, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{1, 1, 1}, {1, 0, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{1, -1, 1}, {1, 0, 0}, {0, 0, 0, 1}, {0, 0}},
            // Top
            {{1, 1, 1}, {0, 1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{1, 1, -1}, {0, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{-1, 1, -1}, {0, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{-1, 1, 1}, {0, 1, 0}, {0, 0, 0, 1}, {0, 0}},
            // Bottom
            {{1, -1, -1}, {0, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
            {{1, -1, 1}, {0, -1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
            {{-1, -1, 1}, {0, -1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
            {{-1, -1, -1}, {0, -1, 0}, {0, 0, 0, 1}, {0, 0}}
        };
        
        _vertexData = [[NSMutableData alloc] initWithBytes:Vertices length:sizeof(Vertices)];
        _numberOfVertices = sizeof(Vertices) / sizeof(SWMVertex1P1N1D1UV);
        
        const GLubyte Indices[] = {
            // Front
            0, 1, 2,
            2, 3, 0,
            // Back
            4, 5, 6,
            4, 5, 7,
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
        
        _indexType = GLU_BYTE;
        _vertexType = SWM_P1N1D1UV;
    }
    
    return self;
}

- (id)initCylinderWithSlices:(int) slices andColour:(GLKVector4)diffuseColour {
    self = [super init];
    if (self) {
        _indexType = GLU_SHORT;
        _vertexType = SWM_1P1D;
        _middlePointDictionary = [[NSMutableDictionary alloc] init];
        _vertices = [[NSMutableArray alloc] init];
        _vertexIndices = [[NSMutableArray alloc] init];
        [self generateCylinderWithSlices:slices withColour:diffuseColour];
    }
    
    return self;
}

- (void)generateCylinderWithSlices:(int)slices withColour:(GLKVector4)diffuseColour {
    
    float decreasePerSlice = 1.0 / slices;
    float currentSliceLevel = 1.0;
    int trianglesInSlice = 16.0 * 4.0;
    float sliceStepRadians = (2 * M_PI) / trianglesInSlice;
    float currentRadians = 0.0;
    NSLog(@"Vertex Data");
    for (currentSliceLevel = 1.0; currentSliceLevel >= -1.0; currentSliceLevel -= decreasePerSlice) {
        for (currentRadians = 0; currentRadians <= (2 * M_PI); currentRadians += sliceStepRadians) {
            GLKVector3 a = GLKVector3Make(cosf(currentRadians), currentSliceLevel, sinf(currentRadians));
            [_vertices addObject:[NSValue value:&a withObjCType:@encode(GLKVector3)]];
            NSLog(@"%f %f %f", a.x, a.y, a.z);
        }
    }
    
    _numberOfVertices = [_vertices count];
    _vertexData = [[NSMutableData alloc] initWithCapacity:(_numberOfVertices * sizeof(SWMVertex1P1D))];
    
    _numberOfIndices = 6.0 * _numberOfVertices;
    _indexData = [[NSMutableData alloc] initWithCapacity:(_numberOfIndices * sizeof(GLushort))];
    NSLog(@"Index Data");
    for (int i = 0; i < _numberOfVertices; i++) {
        GLKVector3 position;
        [[_vertices objectAtIndex:i] getValue:&position];
        
        SWMVertex1P1D vertex =
        {
            {position.x, position.y, position.z},
            {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
        };
        
        [_vertexData appendBytes:&vertex length:sizeof(SWMVertex1P1D)];
        
        if (position.y == -1.0) {
            continue;
        }
        
        GLushort a = i;
        GLushort b = i + 1;
        GLushort c = i + trianglesInSlice;
        GLushort d = i + trianglesInSlice + 1;
        NSLog(@"%u %u %u %u", a, b, c, d);
        [_indexData appendBytes:&a length:sizeof(GLushort)];
        [_indexData appendBytes:&b length:sizeof(GLushort)];
        [_indexData appendBytes:&c length:sizeof(GLushort)];
        
        [_indexData appendBytes:&c length:sizeof(GLushort)];
        [_indexData appendBytes:&d length:sizeof(GLushort)];
        [_indexData appendBytes:&b length:sizeof(GLushort)];
    }
}

- (id)initSphereWithRecursionLevel:(int) recursionLevel andColour:(GLKVector4)diffuseColour {
    self = [super init];
    if (self) {
        // golden ratio
        t = (1.0 + sqrt(5.0)) / 2.0;
        index = 0;
        _indexType = GLU_SHORT;
        _vertexType = SWM_1P1D;
        _middlePointDictionary = [[NSMutableDictionary alloc] init];
        _vertices = [[NSMutableArray alloc] init];
        _vertexIndices = [[NSMutableArray alloc] init];
        [self generateSphereWithRecursionLevel:recursionLevel withColour:diffuseColour];
        
    }
    return self;
}

- (void)generateSphereWithRecursionLevel:(int)recursionLevel withColour:(GLKVector4)diffuseColour{
    [self populateInitialVerticesAndIndicesForIcosahedronWithDifuseColour:diffuseColour];
    
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
    _numberOfVertices = [_vertices count];
    _vertexData = [[NSMutableData alloc] initWithCapacity:(_numberOfVertices * sizeof(SWMVertex1P1D))];
    for (int i = 0; i < _numberOfVertices; i++) {
        SWMVertex1P1D vertex;
        [[_vertices objectAtIndex:i] getValue:&vertex];
        [_vertexData appendBytes:&vertex length:sizeof(SWMVertex1P1D)];
    }
    
    _numberOfIndices = [_vertexIndices count];
    _indexData = [[NSMutableData alloc] initWithCapacity:(_numberOfIndices * sizeof(GLushort))];
    for (int i = 0; i < _numberOfIndices; i++) {
        GLushort vertexIndex;
        [[_vertexIndices objectAtIndex:i] getValue:&vertexIndex];
        [_indexData appendBytes:&vertexIndex length:sizeof(GLushort)];
    }
}
                                                           
- (int)addVertex:(SWMVertex1P1D *)vertex{
    GLKVector3 position = GLKVector3MakeWithArray(vertex -> _position);
    GLKVector4 diffuseColour = GLKVector4MakeWithArray(vertex -> _diffuseColour);
    
    double length = sqrt(position.x * position.x + position.y * position.y + position.z * position.z);
    GLKVector3 normalizedPosition = GLKVector3Make(position.x / length, position.y / length, position.z / length);
    
    SWMVertex1P1D newVertex =
    {
        {normalizedPosition.x, normalizedPosition.y, normalizedPosition.z},
        {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
    };
    
    [_vertices addObject:[NSValue value:&newVertex withObjCType:@encode(SWMVertex1P1D)]];
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
    
    SWMVertex1P1D firstVertex;
    [[_vertices objectAtIndex:p1] getValue:&firstVertex];
    GLKVector3 point1 = GLKVector3MakeWithArray(firstVertex._position);
    GLKVector4 diffuse1 = GLKVector4MakeWithArray(firstVertex._diffuseColour);
    
    SWMVertex1P1D secondVertex;
    [[_vertices objectAtIndex:p2] getValue:&secondVertex];
    GLKVector3 point2 = GLKVector3MakeWithArray(secondVertex._position);
    GLKVector4 diffuse2 = GLKVector4MakeWithArray(secondVertex._diffuseColour);
    
    GLKVector3 point3 = GLKVector3Make((point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.z + point2.z) / 2.0);
    GLKVector4 diffuse3 = GLKVector4Make((diffuse1.x + diffuse2.x) / 2.0, (diffuse1.y + diffuse2.y) / 2.0, (diffuse1.z + diffuse2.z) / 2.0, (diffuse1.w + diffuse2.w) / 2.0);
    
    SWMVertex1P1D thirdVertex =
    {
        {point3.x, point3.y, point3.z},
        {diffuse3.x, diffuse3.y, diffuse3.z, diffuse3.w}
    };
    
    GLushort i = [self addVertex:&thirdVertex];
    [_middlePointDictionary setObject:[NSNumber numberWithUnsignedShort:i] forKey:[NSNumber numberWithUnsignedInt:key]];
    
    return i;
}

- (void)populateInitialVerticesAndIndicesForIcosahedronWithDifuseColour:(GLKVector4)diffuseColour{
    
    const SWMVertex1P1D Vertices [] = {
        //XY Face
        {
            {-1, t, 0},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.0f, 0.0f, 1.0f, 1.0f}
        },
        {
            {1, t, 0},
            {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
        },
        {
            {-1, -t, 0},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.0f, 0.0f, 1.0f, 1.0f}
        },
        {
            {1, -t, 0},
            {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
        },
        
        // YZ Face
        {
            {0, -1, t},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.5f, 0.0f, 0.5f, 1.0f}
        },
        {
            {0, 1, t},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.5f, 0.0f, 0.5f, 1.0f}
        },
        {
            {0, -1, -t},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.5f, 0.0f, 0.5f, 1.0f}
        },
        {
            {0, 1, -t},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.5f, 0.0f, 0.5f, 1.0f}
        },
        
        // XZ Face
        {
            {t, 0, -1},
            {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
        },
        {
            {t, 0, 1},
            {diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
        },
        {
            {-t, 0, -1},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.0f, 0.0f, 1.0f, 1.0f}
        },
        {
            {-t, 0, 1},
            //{diffuseColour.x, diffuseColour.y, diffuseColour.z, diffuseColour.w}
            {0.0f, 0.0f, 1.0f, 1.0f}
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

//+ (NSMutableData *)generateSphereWithRadius:(int)radius numberOfTriangleStrips:(int)triangleStrips numberOfTrianglesInTriangleStrip:(int)numTriangleInStrip diffuseColour:(GLKVector4)colour numberOfVertices:(out int *) numberOfVertices withIndices:(out NSMutableData *) indices{
//    assert(radius > 0);
//    assert(triangleStrips > 4);
//    assert(numTriangleInStrip > 2);
//
//    float circleCircumfrence = 2 * M_PI * radius;
//    float radiansPerTriangleStrip = (2 * M_PI) / triangleStrips;
//
//    // Each Triangle has two unique vertices
//    // Each Triange Strip has numTriangleInStrip number of triangles, -2 vertices for the top most and bottom most points
//    // Each sphere has triangleStrips number of triangle strips
//    // The top and bottom points are shared across all triangle strips
//
//    int *numVertices = 2 * triangleStrips * (numTriangleInStrip - 2) + 2;
//    SWMVertex1P1D vertices[*numVertices];
//    NSMutableData *vertexData = [[NSMutableData alloc] initWithCapacity:*numVertices * sizeof(SWMVertex1P1D)];
//    return vertexData;
//}

@end

