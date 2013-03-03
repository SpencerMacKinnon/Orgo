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

@interface SWMVertexArray : NSObject {
    unsigned int _numberOfIndices, _numberOfVertices;
    NSMutableData *_indexData, *_vertexData;
}

@property (readonly) unsigned int  numberOfIndices, numberOfVertices;
@property (readonly) NSMutableData *indexData, *vertexData;

@end
