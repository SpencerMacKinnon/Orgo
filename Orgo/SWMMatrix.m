//
//  SWMMatrix.m
//  Orgo
//
//  Created by Spencer MacKinnon on 3/23/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMMatrix.h"

@implementation SWMMatrix
// They go row and then column
// 0  4  8  12      1 0 0 0
// 1  5  9  13      0 1 0 0
// 2  6  10 14      0 0 1 0
// 3  7  11 15      0 0 0 1

- (id)init{
    self = [super init];
    if (self) {
        [self resetOrientation];
    }
    
    return self;
}

- (void)resetOrientation{
    _rotationAxes = GLKVector3Make(1.0f, 1.0f, 1.0f);
    _rotationVector = GLKVector3Make(0.0f, 0.0f, 0.0f);
    _translationVector = GLKVector3Make(0.0f, 0.0f, -6.0f);
    
    _xRotationAxes = GLKVector3Make(1.0f, 0.0f, 0.0f);
    _yRotationAxes = GLKVector3Make(0.0f, 1.0f, 0.0f);
    _zRotationAxes = GLKVector3Make(0.0f, 0.0f, 1.0f);
}

- (void)setTranslationVectorX:(float)transX{
    _translationVector.x = transX;
}
- (void)setTranslationVectorY:(float)transY{
    _translationVector.y = transY;
}
- (void)setTranslationVectorZ:(float)transZ{
    _translationVector.z = transZ;
}
- (void)rotateX:(float)rotX;{
    _rotationVector.x += rotX;
    
    _yRotationAxes.y += rotX;
    _yRotationAxes.z += rotX;
    
    //_rotationAxes.y += rotX;
    //_rotationAxes.z += rotX;
}
- (void)rotateY:(float)rotY{
    _rotationVector.y += rotY;
    
    _xRotationAxes.x += rotY;
    _xRotationAxes.z += rotY;
    
//    _rotationAxes.x += rotY;
//    _rotationAxes.z += rotY;
//    NSLog(@"PI: %f", M_PI);
//    NSLog(@"rVy: %f", _rotationVector.y);
//    if (_rotationVector.y - M_PI < 0.05)
//    NSLog(@"rVy: %f rAx: %f rAz: %f", _rotationVector.y, _rotationAxes.x, _rotationAxes.z);
}
- (void)rotateZ:(float)rotZ{
    _rotationVector.z += rotZ;
    
    _rotationAxes.x += rotZ;
    _rotationAxes.y += rotZ;
}

- (GLKMatrix4)translation{
    return GLKMatrix4MakeTranslation(_translationVector.x, _translationVector.y, _translationVector.z);
}

- (GLKMatrix4)rotationX{
    //return GLKMatrix4MakeRotation(_rotationVector.x, _rotationAxes.x, 0.0, 0.0);
    //return GLKMatrix4MakeRotation(_rotationVector.x, _xRotationAxes.x, _xRotationAxes.y, _xRotationAxes.z);
    return GLKMatrix4MakeXRotation(_rotationVector.x);
}

- (GLKMatrix4)rotationY{
    //return GLKMatrix4MakeRotation(_rotationVector.y, 0.0, _rotationAxes.y, 0.0);
    //return GLKMatrix4MakeRotation(_rotationVector.y, _yRotationAxes.x, _yRotationAxes.y, _yRotationAxes.z);
    return GLKMatrix4MakeYRotation(_rotationVector.y);
}

- (GLKMatrix4)rotationZ{
    //return GLKMatrix4MakeRotation(_rotationVector.z, 0.0, 0.0, _rotationAxes.z);
    //return GLKMatrix4MakeRotation(_rotationVector.z, _zRotationAxes.x, _zRotationAxes.y, _zRotationAxes.z);
    return GLKMatrix4MakeZRotation(_rotationVector.z);
}

- (GLKMatrix4)objectTransform{
    GLKMatrix4 trans = [self translation];
    GLKMatrix4 rotX = [self rotationX];
    GLKMatrix4 rotY = [self rotationY];
    GLKMatrix4 rotZ = [self rotationZ];
    
    return [self objectTransformWithTranslationMatrix:trans withRotationMatrixX:rotX withRotationMatrixY:rotY withRotationMatrixZ:rotZ];
}

- (GLKMatrix4)objectTransformWithTranslationMatrix:(GLKMatrix4)translationMatrix withRotationMatrixX:(GLKMatrix4)rotationMatrixX withRotationMatrixY:(GLKMatrix4)rotationMatrixY withRotationMatrixZ:(GLKMatrix4)rotationMatrixZ {
    
    return GLKMatrix4Multiply(translationMatrix, GLKMatrix4Multiply(rotationMatrixX, GLKMatrix4Multiply(rotationMatrixY, rotationMatrixZ)));
}

@end
