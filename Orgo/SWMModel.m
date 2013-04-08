//
//  SWMModel.m
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModel.h"

@implementation SWMModel

@synthesize modelViewProjectionMatrix = _modelViewProjectionMatrix;
@synthesize normalMatrix = _normalMatrix;
@synthesize rotationVector = _rotationVector;
@synthesize translationVector = _translationVector;

- (id)initWithModelGenerator:(SWMModelGenerator *)modelGenerator{
    self = [super init];
    if (self){
        _vertexArray = modelGenerator;
        _diffuseLightColour = GLKVector4Make(1.0, 1.0, 1.0, 0.5);
        _matrix = [[SWMMatrix alloc] init];
    }
    
    return self;
}

- (NSMutableData *)vertexData{
    return [_vertexArray vertexData];
}

- (NSMutableData *)indexData{
    return [_vertexArray indexData];
}

- (int)numberOfVertices {
    return [_vertexArray numberOfVertices];
}

- (int)numberOfIndices {
    return [_vertexArray numberOfIndices];
}

- (GLKMatrix4)objectTransform {
    return [_matrix objectTransform];
}

- (void)resetOrientation {
    [_matrix resetOrientation];
}

- (void)setTranslationVectorX:(float)transX {
    [_matrix setTranslationVectorX:transX];
}
- (void)setTranslationVectorY:(float)transY {
    [_matrix setTranslationVectorY:transY];
}
- (void)setTranslationVectorZ:(float)transZ {
    [_matrix setTranslationVectorZ:transZ];
}
- (void)rotateX:(float)rotX {
    [_matrix rotateX:rotX];
}
- (void)rotateY:(float)rotY {
    [_matrix rotateY:rotY];
}
- (void)rotateZ:(float)rotZ {
    [_matrix rotateZ:rotZ];
}

@end
