//
//  SWMMatrix.h
//  Orgo
//
//  Created by Spencer MacKinnon on 3/23/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SWMMatrix : NSObject

+(GLKMatrix4)translation:(GLKVector3)vector;
+(GLKMatrix4)rotationX:(float)angle;
+(GLKMatrix4)rotationY:(float)angle;
+(GLKMatrix4)rotationZ:(float)angle;
+(GLKMatrix4)objectTransformWithTranslationVector:(GLKVector3)translationVector andWithRotationVector:(GLKVector3)rotationVector;
+(GLKMatrix4)objectTransformWithTranslationMatrix:(GLKMatrix4)translationMatrix withRotationMatrixX:(GLKMatrix4)rotationMatrixX withRotationMatrixY:(GLKMatrix4)rotationMatrixY withRotationMatrixZ:(GLKMatrix4)rotationMatrixZ;

@end
