//
//  SWMMaterialCollection.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/7/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SWMModel.h"
#include "SWMShader.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface SWMMaterialCollection : NSObject {
    
    GLuint _indexBuffer, _vertexArray, _vertexBuffer;
    
    SWMShader *_shader;
    NSMutableArray *_models;
    
    // Uniform index.
    enum
    {
        UNIFORM_MODELVIEWPROJECTION_MATRIX,
        UNIFORM_NORMAL_MATRIX,
        DIFFUSE_COLOR,
        //UNIFORM_SAMPLER2D,
        NUM_UNIFORMS
    };
    GLint uniforms[NUM_UNIFORMS];
    
    // Attribute index.
    enum
    {
        ATTRIB_VERTEX,
        ATTRIB_NORMAL,
        //ATTRIB_VERTEX_UV,
        NUM_ATTRIBUTES
    };
    GLint attributes[NUM_ATTRIBUTES];
}

@property SWMShader *shader;

- (id)initWithShader:(SWMShader *)shader;
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;
- (BOOL)loadShaders;
- (BOOL)releaseShaders;
- (void)resetModelsOrientation;
- (void)setupGL;
- (void)tearDownGL;
- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix;

- (void)rotateModelsX:(float)rotX;
- (void)rotateModelsY:(float)rotY;
- (void)rotateModelsZ:(float)rotZ;

@end
