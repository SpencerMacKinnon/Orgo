//
//  SWMMaterialCollection.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/7/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMMaterialCollection.h"

// Uniform index.
enum
{
    MatrixMVP,
    MatrixNormal,
    VectorDiffuseColour,
    VectorLightDirection,
    VectorLightColour,
    FloatSpecular,
    NumUniforms
};

GLint uniforms[NumUniforms];

const char* uniformNames[NumUniforms] = {
    "u_mvp",
    "u_normal",
    "u_diffusecolour",
    "u_lightdirection",
    "u_lightcolour",
    "u_specular",
};

@implementation SWMMaterialCollection

@synthesize lightColour;

- (id)init{
    self = [super init];
    if (self) {
        _shader = [[SWMShader alloc] init];
        [self loadShaders];
        
        _vertexSets = [[NSMutableDictionary alloc] init];
        
        SWMAtomFactory * _atomFactory = [[SWMAtomFactory alloc] init];
        SWMVertexData *sphere = [_atomFactory createSphereVerticesWithRecursionLevel:3];
        SWMVertexData *cylinder = [_atomFactory createCylinderVerticesWithSlices:3];
        [self addVertexData:sphere];
        [self addVertexData:cylinder];
        
        [self setLightPosition:GLKVector3Make(0.0f, 0.5f, 7.0f)];
        [self setLightColour:GLKVector3Make(1.0f, 1.0f, 1.0f)];
        spec = 64.0f;
    }
    
    return self;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect withModels:(NSArray *)models{
    
    glBindVertexArrayOES(_vertexArray);
    
    glUseProgram([_shader program]);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    for (SWMModel *model in models) {
        glUniformMatrix4fv(uniforms[MatrixMVP], 1, 0, [model modelViewProjectionMatrix].m);
        glUniformMatrix3fv(uniforms[MatrixNormal], 1, 0, [model normalMatrix].m);
        glUniform4fv(uniforms[VectorDiffuseColour], 1, [model diffuseLightColour].v);
        
        [self drawVerticesForModelName:[model vertexSetName]];
    }
    
    glBindVertexArrayOES(0);
}

- (BOOL)drawVerticesForModelName:(NSString *)modelName {
    if ([_vertexSets valueForKey:modelName]) {
        SWMVertexData *vertexData = [_vertexSets valueForKey:modelName];
        glDrawElements(GL_TRIANGLES, [vertexData numberOfIndices], GL_UNSIGNED_SHORT, (GLvoid*)(sizeof(GLushort) * [vertexData offset]));
        return YES;
    }
    
    return NO;
}

- (BOOL)loadShaders{
    uniforms[MatrixMVP] = glGetUniformLocation([_shader program], uniformNames[MatrixMVP]);
    uniforms[MatrixNormal] = glGetUniformLocation([_shader program], uniformNames[MatrixNormal]);
    uniforms[VectorDiffuseColour] = glGetUniformLocation([_shader program], uniformNames[VectorDiffuseColour]);
    uniforms[VectorLightDirection] = glGetUniformLocation([_shader program], uniformNames[VectorLightDirection]);
    uniforms[VectorLightColour] = glGetUniformLocation([_shader program], uniformNames[VectorLightColour]);
    uniforms[FloatSpecular] = glGetUniformLocation([_shader program], uniformNames[FloatSpecular]);
    
    return YES;
}

- (BOOL) releaseShaders{
    return [_shader releaseShaders];
}

- (void) setupGL{
    NSMutableData *vertexSetData = [[NSMutableData alloc] init];
    NSMutableData *indexSetData = [[NSMutableData alloc] init];
    
    NSEnumerator *dictionaryEnumerator = [_vertexSets objectEnumerator];
    SWMVertexData *modelVertices;
    
    while ((modelVertices = [dictionaryEnumerator nextObject])) {
        [vertexSetData appendBytes:[[modelVertices vertexData] mutableBytes] length:[[modelVertices vertexData] length]];
        [indexSetData appendBytes:[[modelVertices indexData] mutableBytes] length:[[modelVertices indexData] length]];
    }

    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, [vertexSetData length], [vertexSetData mutableBytes], GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, [indexSetData length], [indexSetData mutableBytes], GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N), BUFFER_OFFSET(0));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N), BUFFER_OFFSET(12));
    
    glUseProgram([_shader program]);
    glUniform3fv(uniforms[VectorLightDirection], 1, lightPosition.v);
    glUniform4fv(uniforms[VectorLightColour], 1, lightColour.v);
    glUniform1f(uniforms[FloatSpecular], spec);
    
    glBindVertexArrayOES(0);
}

- (void)tearDownGL{
    glDeleteVertexArraysOES(1, &_vertexArray);
    [_shader tearDownGL];
}

- (void)setLightPosition:(GLKVector3)lightPos {
    lightPosition = lightPos;
}

- (void)addVertexData:(SWMVertexData *)vertexData {
    [_vertexSets setValue:vertexData forKey:[vertexData vertexSetName]];
}

@end
