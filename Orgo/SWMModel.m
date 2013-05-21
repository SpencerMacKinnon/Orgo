//
//  SWMModel.m
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModel.h"

@implementation SWMModel

@synthesize modelViewMatrix;
@synthesize modelViewProjectionMatrix;
@synthesize normalMatrix;
@synthesize rotationVector;
@synthesize translationVector;

- (id)initWithTransformation:(SWMObjectTransformation *)transformation{
    self = [super init];
    if (self){
        _diffuseLightColour = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
        _matrix = transformation;
    }
    
    return self;
}

- (GLKMatrix4)slerpWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate {
    return [_matrix slerpWithTimeSinceLastUpdate:timeSinceLastUpdate];
}

- (GLKMatrix4)objectTransform {
    return [_matrix objectTransform];
}

- (void)scaleModel {
    //self.modelViewMatrix = GLKMatrix4Multiply([_matrix scaling], self.modelViewMatrix);
    self.modelViewMatrix = GLKMatrix4Multiply(self.modelViewMatrix, [_matrix scaling]);
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
