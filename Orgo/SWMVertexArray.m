//
//  SWMVertexArray.m
//  Life
//
//  Created by Spencer MacKinnon on 2/21/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMVertexArray.h"

@implementation SWMVertexArray

@synthesize numberOfIndices;
@synthesize numberOfVertices;
@synthesize indexData;
@synthesize vertexData;
@synthesize vertexSetName;
@synthesize offset;

- (id)init{
    self = [super init];
    if (self) {
        self.vertexData = [[NSMutableData alloc] init];
        self.numberOfVertices = 0;
        self.indexData = [[NSMutableData alloc] init];
        self.numberOfIndices = 0;
        self.offset = 0;
        self.vertexSetName = [NSString stringWithFormat:@""];
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
