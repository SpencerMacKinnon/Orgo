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

- (id)initWithModelGenerator:(SWMVertexData *)modelGenerator andTransformation:(SWMObjectTransformation *)transformation{
    self = [super init];
    if (self){
        _vertexArray = modelGenerator;
        _diffuseLightColour = GLKVector4Make(1.0, 1.0, 1.0, 0.5);
        _matrix = transformation;
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

- (GLKMatrix4)objectTransformWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate {
    return [_matrix objectTransformWithTimeSinceLastUpdate:timeSinceLastUpdate];
}

- (void)resetOrientation {
    [_matrix resetOrientation];
}

- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    [_matrix touchAtPoint:location withViewBounds:viewBounds];
}

- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    [_matrix touchesMoved:location withViewBounds:viewBounds];
}

@end
