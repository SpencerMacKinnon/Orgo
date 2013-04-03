//
//  SWMMatrix.h
//  Orgo
//
//  Created by Spencer MacKinnon on 3/23/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SWMMatrix : NSObject {
    GLKVector3 _rotationAxes, _rotationVector, _translationVector;
    GLKVector3 _xRotationAxes, _yRotationAxes, _zRotationAxes;
}
- (void)resetOrientation;
- (void)setTranslationVectorX:(float)transX;
- (void)setTranslationVectorY:(float)transY;
- (void)setTranslationVectorZ:(float)transZ;
- (void)rotateX:(float)rotX;
- (void)rotateY:(float)rotY;
- (void)rotateZ:(float)rotZ;
- (GLKMatrix4)objectTransform;

@end
