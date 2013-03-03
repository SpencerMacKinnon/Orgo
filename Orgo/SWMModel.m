//
//  SWMModel.m
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModel.h"

@implementation SWMModel

@synthesize modelViewMatrix = _modelViewMatrix;
@synthesize modelViewProjectionMatrix = _modelViewProjectionMatrix;
@synthesize normalMatrix = _normalMatrix;
@synthesize vertexArray = _vertexArray;
@synthesize shader = _shader;

- (id)initWithShader:(SWMShader *)shader{
    self = [super init];
    if (self){
        _shader = shader;
        _vertexArray = [[SWMVertexArray alloc] init];
        _modelViewMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
        _diffuseLightColour = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
        [self loadShaders];
    }
    
    return self;
}

- (NSMutableData *)vertexData{
    return [_vertexArray vertexData];
}

- (int)numberOfVertices {
    return [_vertexArray numberOfVertices];
}

- (BOOL)loadShaders{
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation([_shader program], "modelViewProjectionMatrix");
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation([_shader program], "normalMatrix");
    uniforms[UNIFORM_SAMPLER2D] = glGetUniformLocation([_shader program], "myTextureSampler");
    _colourIndex = glGetUniformLocation([_shader program], "diffuseColour");
    
    NSString *floorPath = [[NSBundle mainBundle] pathForResource:@"tile_floor" ofType:@"png" inDirectory:@"Art"];
    NSString *fishPath = [[NSBundle mainBundle] pathForResource:@"item_powerup_fish" ofType:@"png" inDirectory:@"Art"];
    
    _floorTexture = [SWMBitmapLoader loadTexture:floorPath];
    _fishTexture = [SWMBitmapLoader loadTexture:fishPath];
    
    return YES;
}

- (BOOL)releaseShaders{
    return [_shader releaseShaders];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glUseProgram([_shader program]);
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
    glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
    glUniform4f(_colourIndex, _diffuseLightColour.x, _diffuseLightColour.y, _diffuseLightColour.z, _diffuseLightColour.w);
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _floorTexture);
    glUniform1i(uniforms[UNIFORM_SAMPLER2D], 0);
}

- (void)tearDownGL{
    [_shader tearDownGL];
}

@end
