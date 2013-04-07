//
//  SWMVertexArray.h
//  Life
//
//  Created by Spencer MacKinnon on 2/21/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#include "SWMVertex.h"
#define TEX_COORD_MAX 1

@interface SWMVertexArray : NSObject {
    unsigned int _numberOfIndices, _numberOfVertices;
    NSMutableData *_indexData, *_vertexData;
    GLU_INDEX_TYPE _indexType;
    SWM_VERTEX_TYPE _vertexType;
    
}

@property (readonly) unsigned int  numberOfIndices, numberOfVertices;
@property (readonly) NSMutableData *indexData, *vertexData;

-(GLU_INDEX_TYPE)getIndexType;
-(SWM_VERTEX_TYPE)getVertexType;

@end
