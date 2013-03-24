//
//  SWMMatrix.m
//  Orgo
//
//  Created by Spencer MacKinnon on 3/23/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMMatrix.h"

@implementation SWMMatrix

+(GLKMatrix4)translation:(GLKVector3)vector {
    return GLKMatrix4MakeTranslation(vector.x, vector.y, vector.z);
}

+(GLKMatrix4)rotationX:(float)angle {
    return GLKMatrix4MakeRotation(angle, 1.0, 0.0, 0.0);
}

+(GLKMatrix4)rotationY:(float)angle {
    return GLKMatrix4MakeRotation(angle, 0.0, 1.0, 0.0);
}

+(GLKMatrix4)rotationZ:(float)angle {
    return GLKMatrix4MakeRotation(angle, 0.0, 0.0, 1.0);
}

+(GLKMatrix4)objectTransformWithTranslationVector:(GLKVector3)translationVector andWithRotationVector:(GLKVector3)rotationVector {
    GLKMatrix4 trans = [self translation:translationVector];
    GLKMatrix4 rotX = [self rotationX:rotationVector.x];
    GLKMatrix4 rotY = [self rotationY:rotationVector.y];
    GLKMatrix4 rotZ = [self rotationZ:rotationVector.z];
    
    return [self objectTransformWithTranslationMatrix:trans withRotationMatrixX:rotX withRotationMatrixY:rotY withRotationMatrixZ:rotZ];
}

+(GLKMatrix4)objectTransformWithTranslationMatrix:(GLKMatrix4)translationMatrix withRotationMatrixX:(GLKMatrix4)rotationMatrixX withRotationMatrixY:(GLKMatrix4)rotationMatrixY withRotationMatrixZ:(GLKMatrix4)rotationMatrixZ {
    
    return GLKMatrix4Multiply(translationMatrix, GLKMatrix4Multiply(rotationMatrixX, GLKMatrix4Multiply(rotationMatrixY, rotationMatrixZ)));
}

@end
