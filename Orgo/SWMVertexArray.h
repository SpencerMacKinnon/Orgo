//
//  SWMVertexArray.h
//  Life
//
//  Created by Spencer MacKinnon on 2/21/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "SWMVertex.h"

@interface SWMVertexArray : NSObject {
    GLU_INDEX_TYPE _indexType;
    SWM_VERTEX_TYPE _vertexType;
}

@property GLuint offset;
@property unsigned int  numberOfIndices, numberOfVertices;
@property (nonatomic, strong) NSMutableData *indexData, *vertexData;
@property (nonatomic, strong) NSString *vertexSetName;

-(GLU_INDEX_TYPE)getIndexType;
-(SWM_VERTEX_TYPE)getVertexType;

@end
