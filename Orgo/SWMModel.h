//
//  SWMModel.h
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#include "SWMVertexArray.h"
#include "SWMShader.h"
#include "SWMBitmapLoader.h"
#include "SWMMatrix.h"

@interface SWMModel : NSObject
{
    GLKMatrix3 _normalMatrix;
    GLKMatrix4 _modelViewProjectionMatrix;
    
    GLKVector3 _rotationVector, _translationVector;
    GLKVector4 _diffuseLightColour;
    
    GLuint _floorTexture, _fishTexture, _colourIndex;
    
    SWMVertexArray *_vertexArray;
    SWMShader *_shader;
    
    // Uniform index.
    enum
    {
        UNIFORM_MODELVIEWPROJECTION_MATRIX,
        UNIFORM_NORMAL_MATRIX,
        UNIFORM_SAMPLER2D,
        NUM_UNIFORMS
    };
    GLint uniforms[NUM_UNIFORMS];
    
    // Attribute index.
    enum
    {
        ATTRIB_VERTEX,
        ATTRIB_NORMAL,
        ATTRIB_VERTEX_UV,
        NUM_ATTRIBUTES
    };
    GLint attributes[NUM_ATTRIBUTES];
}

@property GLKMatrix4 modelViewMatrix, modelViewProjectionMatrix;
@property GLKMatrix3 normalMatrix;
@property SWMVertexArray *vertexArray;
@property SWMShader *shader;
@property GLKVector3 rotationVector, translationVector;

- (id)initWithShader:(SWMShader *)shader;
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;
- (BOOL)loadShaders;
- (int)numberOfVertices;
- (GLKMatrix4)objectTransform;
- (BOOL)releaseShaders;
- (void)tearDownGL;
- (NSMutableData *)vertexData;
- (void)setTranslationVectorX:(float)transX;
- (void)setTranslationVectorY:(float)transY;
- (void)setTranslationVectorZ:(float)transZ;
- (void)rotateX:(float)rotX;
- (void)rotateY:(float)rotY;
- (void)rotateZ:(float)rotZ;

@end
