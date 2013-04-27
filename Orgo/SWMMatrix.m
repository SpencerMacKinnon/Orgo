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

@synthesize scalingVector;

- (id)init{
    self = [super init];
    if (self) {
        scalingVector = GLKVector3Make(1.0f, 1.0f, 1.0f);
        _translationVector = GLKVector3Make(0.0f, 0.0f, -6.0f);
        _quat = GLKQuaternionMake(0, 0, 0, 1);
        _quatStart = GLKQuaternionMake(0, 0, 0, 1);
    }
    
    return self;
}

- (void)resetOrientation {
    _slerping = YES;
    _slerpCur = 0;
    _slerpMax = 1.0;
    _slerpStart = _quat;
    _slerpEnd = GLKQuaternionMake(0, 0, 0, 1);
}

- (void)setTranslationVectorX:(float)transX {
    _translationVector.x = transX;
}
- (void)setTranslationVectorY:(float)transY {
    _translationVector.y = transY;
}
- (void)setTranslationVectorZ:(float)transZ {
    _translationVector.z = transZ;
}

- (GLKMatrix4)scaling {
    return GLKMatrix4MakeScale(scalingVector.x, scalingVector.y, scalingVector.z);
}

- (GLKMatrix4)translation {
    return GLKMatrix4MakeTranslation(_translationVector.x, _translationVector.y, _translationVector.z);
}
- (GLKMatrix4)rotation {
    return GLKMatrix4MakeWithQuaternion(_quat);
}

- (GLKMatrix4)objectTransformWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate{
    
    if (_slerping) {
        _slerpCur += timeSinceLastUpdate;
        float slerpAmt = _slerpCur / _slerpMax;
        if (slerpAmt > 1.0) {
            slerpAmt = 1.0;
            _slerping = NO;
        }
        
        _quat = GLKQuaternionSlerp(_slerpStart, _slerpEnd, slerpAmt);
    }
    
    return GLKMatrix4Multiply([self translation], GLKMatrix4Multiply([self rotation], [self scaling]));
}

- (void)computeIncremental {
    
    GLKVector3 axis = GLKVector3CrossProduct(_anchorPosition, _currentPosition);
    float dot = GLKVector3DotProduct(_anchorPosition, _currentPosition);
    float angle = acosf(dot);
    
    GLKQuaternion Q_rot = GLKQuaternionMakeWithAngleAndVector3Axis(angle * 1, axis);
    Q_rot = GLKQuaternionNormalize(Q_rot);
    
    _quat = GLKQuaternionMultiply(Q_rot, _quatStart);
}

- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    _anchorPosition = GLKVector3Make(location.x, location.y, 0);
    _anchorPosition = [self projectOntoSurface:_anchorPosition withViewBounds:viewBounds];
    
    _currentPosition = _anchorPosition;
    _quatStart = _quat;
}

- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    _currentPosition = GLKVector3Make(location.x, location.y, 0);
    _currentPosition = [self projectOntoSurface:_currentPosition withViewBounds:viewBounds];
    
    [self computeIncremental];
}

#pragma mark - Utility Functions

- (GLKVector3)projectOntoSurface:(GLKVector3) touchPoint withViewBounds:(CGRect)viewBounds{
    float radius = viewBounds.size.width/3;
    GLKVector3 center = GLKVector3Make(viewBounds.size.width/2, viewBounds.size.height/2, 0);
    GLKVector3 P = GLKVector3Subtract(touchPoint, center);
    
    //Flip the y-axis because pixel coordinates increase toward the bottom.
    P = GLKVector3Make(P.x, P.y * -1, P.z);
    
    float radius2 = radius * radius;
    float length2 = P.x*P.x + P.y*P.y;
    
    if (length2 <= radius2) {
        P.z = sqrtf(radius2 - length2);
    } else {
        P.z = radius2 / (2.0 * sqrtf(length2));
        float length = sqrtf(length2 + P.z * P.z);
        P = GLKVector3DivideScalar(P, length);
    }
    
    return GLKVector3Normalize(P);
}

@end
