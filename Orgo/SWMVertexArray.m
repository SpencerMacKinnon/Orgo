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
        _vertexData = [[NSMutableData alloc] init];
        _numberOfVertices = 0;
        _indexData = [[NSMutableData alloc] init];
        _numberOfIndices = 0;
    }
    
    return self;
}

- (GLU_INDEX_TYPE) getIndexType{
    return _indexType;
}

- (SWM_VERTEX_TYPE) getVertexType{
    return _vertexType;
}

@end
