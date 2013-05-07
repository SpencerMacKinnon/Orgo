//
//  SWMMaterialCollection.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/7/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMModel.h"
#import "SWMShader.h"
#import "SWMVertexData.h"
#import "SWMGraph.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface SWMMaterialCollection : NSObject {
    
    GLuint _indexBuffer, _vertexArray, _vertexBuffer;
    
    SWMShader *_shader;
    NSMutableArray *_models;
    NSMutableDictionary *_vertexSets;
    
    GLKVector3 lightPosition;
    float spec;
}

@property SWMShader *shader;
@property GLKVector3 lightColour;

- (id)initWithShader:(SWMShader *)shader;
- (void)addModel:(SWMModel *)model;
- (void)addVertexData:(SWMVertexData *)vertexData;

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;
- (BOOL)loadShaders;
- (BOOL)releaseShaders;
- (void)resetModelsOrientation;
- (void)setupGL;
- (void)tearDownGL;
- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix andTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate;

- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds;
- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds;

@end
