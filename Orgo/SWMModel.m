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

- (id)initWithTransformation:(SWMObjectTransformation *)transformation{
    self = [super init];
    if (self){
        _diffuseLightColour = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
        _matrix = transformation;
    }
    
    return self;
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
