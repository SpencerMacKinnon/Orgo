//
//  SWMModelGenerator.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelGenerator.h"

@implementation SWMModelGenerator

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

- (id)initSphereWithRecursionLevel:(int) recursionLevel andColour:(GLKVector4)diffuseColour {
    self = [super init];
    if (self) {
        [self generateSphereWithRecursionLevel:recursionLevel withColour:diffuseColour];
        _middlePointDictionary = [[NSMutableDictionary alloc] init];
        _vertices = [[NSMutableArray alloc] init];
        _vertexData = [[NSMutableData alloc] init];
        _vertexIndices = [[NSMutableArray alloc] init];
        index = 0;
    }
    
    return self;
}

- (void)generateSphereWithRecursionLevel:(int)recursionLevel withColour:(GLKVector4)diffuseColour{
    // golden ratio
    const int t = (1.0 + sqrt(5.0)) / 2.0;
    
    [self addVertex:GLKVector3Make(-1, t, 0) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(1, t, 0) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(-1, -t, 0) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(1, -t, 0) withColour:diffuseColour];
    
    [self addVertex:GLKVector3Make(0, -1, t) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(0, 1, t) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(0, -1, -t) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(0, 1, -t) withColour:diffuseColour];
    
    [self addVertex:GLKVector3Make(t, 0, -1) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(t, 0, 1) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(-t, 0, -1) withColour:diffuseColour];
    [self addVertex:GLKVector3Make(-t, 0, 1) withColour:diffuseColour];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:0]];
    [_vertexIndices addObject:[NSNumber numberWithInt:11]];
    [_vertexIndices addObject:[NSNumber numberWithInt:5]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:0]];
    [_vertexIndices addObject:[NSNumber numberWithInt:5]];
    [_vertexIndices addObject:[NSNumber numberWithInt:1]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:0]];
    [_vertexIndices addObject:[NSNumber numberWithInt:1]];
    [_vertexIndices addObject:[NSNumber numberWithInt:7]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:0]];
    [_vertexIndices addObject:[NSNumber numberWithInt:7]];
    [_vertexIndices addObject:[NSNumber numberWithInt:10]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:0]];
    [_vertexIndices addObject:[NSNumber numberWithInt:10]];
    [_vertexIndices addObject:[NSNumber numberWithInt:11]];
    
    
    [_vertexIndices addObject:[NSNumber numberWithInt:1]];
    [_vertexIndices addObject:[NSNumber numberWithInt:5]];
    [_vertexIndices addObject:[NSNumber numberWithInt:9]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:5]];
    [_vertexIndices addObject:[NSNumber numberWithInt:11]];
    [_vertexIndices addObject:[NSNumber numberWithInt:4]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:11]];
    [_vertexIndices addObject:[NSNumber numberWithInt:10]];
    [_vertexIndices addObject:[NSNumber numberWithInt:2]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:10]];
    [_vertexIndices addObject:[NSNumber numberWithInt:7]];
    [_vertexIndices addObject:[NSNumber numberWithInt:6]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:7]];
    [_vertexIndices addObject:[NSNumber numberWithInt:1]];
    [_vertexIndices addObject:[NSNumber numberWithInt:8]];
    
    
    [_vertexIndices addObject:[NSNumber numberWithInt:3]];
    [_vertexIndices addObject:[NSNumber numberWithInt:9]];
    [_vertexIndices addObject:[NSNumber numberWithInt:4]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:3]];
    [_vertexIndices addObject:[NSNumber numberWithInt:4]];
    [_vertexIndices addObject:[NSNumber numberWithInt:2]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:3]];
    [_vertexIndices addObject:[NSNumber numberWithInt:2]];
    [_vertexIndices addObject:[NSNumber numberWithInt:6]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:3]];
    [_vertexIndices addObject:[NSNumber numberWithInt:6]];
    [_vertexIndices addObject:[NSNumber numberWithInt:8]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:3]];
    [_vertexIndices addObject:[NSNumber numberWithInt:8]];
    [_vertexIndices addObject:[NSNumber numberWithInt:9]];
    
    
    [_vertexIndices addObject:[NSNumber numberWithInt:4]];
    [_vertexIndices addObject:[NSNumber numberWithInt:9]];
    [_vertexIndices addObject:[NSNumber numberWithInt:5]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:2]];
    [_vertexIndices addObject:[NSNumber numberWithInt:4]];
    [_vertexIndices addObject:[NSNumber numberWithInt:11]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:6]];
    [_vertexIndices addObject:[NSNumber numberWithInt:2]];
    [_vertexIndices addObject:[NSNumber numberWithInt:10]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:8]];
    [_vertexIndices addObject:[NSNumber numberWithInt:6]];
    [_vertexIndices addObject:[NSNumber numberWithInt:7]];
    
    [_vertexIndices addObject:[NSNumber numberWithInt:9]];
    [_vertexIndices addObject:[NSNumber numberWithInt:8]];
    [_vertexIndices addObject:[NSNumber numberWithInt:1]];
    
    for (int i = 0; i < recursionLevel; i++) {
        NSMutableArray *newVertexIndices = [[NSMutableArray alloc] init];
        for (int j = 0; j < [_vertexIndices count]; j++) {
            SWMVertex1P1D *tri = [_vertexIndices objectAtIndex:j];
            GLKVector3 pos = [tri position];
            int a = [self getMiddlePoint:pos.x withSecondPoint:pos.y];
            int b = [self getMiddlePoint:pos.y withSecondPoint:pos.z];
            int c = [self getMiddlePoint:pos.z withSecondPoint:pos.x];
            
            [newVertexIndices addObject:[NSNumber numberWithInt:pos.x]];
            [newVertexIndices addObject:[NSNumber numberWithInt:a]];
            [newVertexIndices addObject:[NSNumber numberWithInt:c]];
            
            [newVertexIndices addObject:[NSNumber numberWithInt:pos.y]];
            [newVertexIndices addObject:[NSNumber numberWithInt:b]];
            [newVertexIndices addObject:[NSNumber numberWithInt:a]];
            
            [newVertexIndices addObject:[NSNumber numberWithInt:pos.z]];
            [newVertexIndices addObject:[NSNumber numberWithInt:c]];
            [newVertexIndices addObject:[NSNumber numberWithInt:b]];
            
            [newVertexIndices addObject:[NSNumber numberWithInt:a]];
            [newVertexIndices addObject:[NSNumber numberWithInt:b]];
            [newVertexIndices addObject:[NSNumber numberWithInt:c]];
        }
        _vertexIndices = newVertexIndices;
    }
}

- (int)addVertex:(GLKVector3)vertex withColour:(GLKVector4)vertexColour{
    double length = sqrt(vertex.x * vertex.x + vertex.y * vertex.y + vertex.z * vertex.z);
    GLKVector3 normalizedPosition = GLKVector3Make(vertex.x / length, vertex.y / length, vertex.z / length);
    [_vertices addObject:[[SWMVertex1P1D alloc] initWithPosition:normalizedPosition andColour:vertexColour]];
    return index++;
}

- (int)getMiddlePoint:(int)p1 withSecondPoint:(int)p2 {
    bool firstIsSmaller = p1 < p2;
    int64_t smallerIndex = firstIsSmaller ? p1 : p2;
    int64_t greaterIndex = firstIsSmaller ? p2 : p1;
    
    int64_t key = (smallerIndex << 32) + greaterIndex;
    
    if ([_middlePointDictionary objectForKey:[NSNumber numberWithInt:key]]) {
        return [_middlePointDictionary objectForKey:[NSNumber numberWithInt:key]];
    }
    
    SWMVertex1P1D *firstVertex = [_vertices objectAtIndex:p1];
    GLKVector3 point1 = [firstVertex position];
    SWMVertex1P1D *secondVertex = [_vertices objectAtIndex:p2];
    GLKVector3 point2 = [secondVertex position];
    GLKVector3 point3 = GLKVector3Make((point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.z + point2.z) / 2.0);
    int i = [self addVertex:point3 withColour:[firstVertex diffuseColour]];
    [_middlePointDictionary setObject:[NSNumber numberWithInt:i] forKey:[NSNumber numberWithInt:key]];
    return i;
}

@end

