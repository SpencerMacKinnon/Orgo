//
//  SWMModelFactory.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelFactory.h"

@interface SWMModelFactory()
@property (nonatomic, readwrite) unsigned int currentVertexCount, currentIndexCount;
@end

@implementation SWMModelFactory

@synthesize currentVertexCount;

- (id)init {
    self = [super init];
    if (self) {
        currentVertexCount = 0;
        _currentIndexCount = 0;
    }
    
    return self;
}

- (SWMVertexData *)createSphereVerticesWithRecursionLevel:(int)recursionLevel {
    SWMVertexData *vertexGen = [[SWMVertexData alloc] initSphereWithRecursionLevel:recursionLevel
                                                          withExistingVertexCount:currentVertexCount
                                                                        andOffset:_currentIndexCount];
    [vertexGen setVertexSetName:@"SPHERE"];
    return [self returnVertexData:vertexGen];
}

- (SWMVertexData *)createCylinderVerticesWithSlices:(int)slices {
    SWMVertexData *vertexGen = [[SWMVertexData alloc] initCylinderWithSlices:slices
                                                    withExistingVertexCount:currentVertexCount
                                                                  andOffset:_currentIndexCount];
    [vertexGen setVertexSetName:@"CYLINDER"];
    return [self returnVertexData:vertexGen];
}

- (SWMVertexData *)returnVertexData:(SWMVertexData *)vertexData {
    currentVertexCount += [vertexData numberOfVertices];
    _currentIndexCount += [vertexData numberOfIndices];
    
    return vertexData;
}

@end
