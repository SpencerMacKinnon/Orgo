//
//  SWMObjectTransformation.h
//  Orgo
//
//  Created by Spencer MacKinnon on 3/23/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SWMObjectTransformation : NSObject {
    float _rotation;
    GLKVector3 _anchorPosition;
    GLKVector3 _currentPosition;
    GLKQuaternion _quatStart;
    
    BOOL _slerping;
    float _slerpCur;
    float _slerpMax;
    GLKQuaternion _slerpStart;
    GLKQuaternion _slerpEnd;
}
@property GLKVector3 translationVector;
@property GLKVector3 scalingVector;
@property GLKQuaternion quat;

- (GLKMatrix4)slerpWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate;
- (GLKMatrix4)objectTransform;
- (GLKMatrix4)scaling;
- (void)resetOrientation;
- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds;
- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds;

@end
