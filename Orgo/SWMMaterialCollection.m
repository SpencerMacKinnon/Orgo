//
//  SWMMaterialCollection.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/7/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMMaterialCollection.h"

@implementation SWMMaterialCollection

- (id)initWithShader:(SWMShader *)shader{
    self = [super init];
    if (self) {
        _shader = shader;
        [self loadShaders];
        _models = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    glBindVertexArrayOES(_vertexArray);
    
    GLuint offset = 0;
    
    glUseProgram([_shader program]);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    for (SWMModel *model in _models) {
        glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, [model modelViewProjectionMatrix].m);
        glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, [model normalMatrix].m);
        glUniform4fv(uniforms[DIFFUSE_COLOR], 1, [model diffuseLightColour].v);
        
        int numberOfIndices = [model numberOfIndices];
        glDrawElements(GL_TRIANGLES, numberOfIndices, GL_UNSIGNED_SHORT, (GLvoid*)(sizeof(GLushort) * offset));
        offset += numberOfIndices;
    }
    
    glBindVertexArrayOES(0);
}

- (BOOL)loadShaders{
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation([_shader program], "modelViewProjectionMatrix");
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation([_shader program], "normalMatrix");
    uniforms[DIFFUSE_COLOR] = glGetUniformLocation([_shader program], "diffuseColour");
    
    return YES;
}

- (BOOL)releaseShaders{
    return [_shader releaseShaders];
}

- (void)resetModelsOrientation {
    for (SWMModel *model in _models) {
        [model resetOrientation];
    }
}

- (void)setupGL{
    NSMutableData *vertexData = [[NSMutableData alloc] init];
    NSMutableData *indexData = [[NSMutableData alloc] init];
    
    for (SWMModel *model in _models) {
        [vertexData appendBytes:[[model vertexData] mutableBytes] length:[[model vertexData] length]];
        [indexData appendBytes:[[model indexData] mutableBytes] length:[[model indexData] length]];
    }

    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, [vertexData length], [vertexData mutableBytes], GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, [indexData length], [indexData mutableBytes], GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1D), BUFFER_OFFSET(0));
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1D), BUFFER_OFFSET(12));
    
    glBindVertexArrayOES(0);
}

- (void)tearDownGL{
    glDeleteVertexArraysOES(1, &_vertexArray);
    [_shader tearDownGL];
}

- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix andTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate{
    for (SWMModel *model in _models) {
        GLKMatrix4 modelViewMatrix = [model objectTransformWithTimeSinceLastUpdate:timeSinceLastUpdate];
        GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
        GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
        
        [model setNormalMatrix:normalMatrix];
        [model setModelViewProjectionMatrix:modelViewProjectionMatrix];
    }
}

- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    for (SWMModel *model in _models) {
        [model touchAtPoint:location withViewBounds:viewBounds];
    }
}

- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    for (SWMModel *model in _models) {
        [model touchesMoved:location withViewBounds:viewBounds];
    }
}

- (void)addModel:(SWMModel *)model {
    [_models addObject:model];
}

@end
