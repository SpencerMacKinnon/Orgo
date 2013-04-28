//
//  SWMAtomFactory.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMAtomFactory.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation SWMAtomFactory

- (SWMModel *)createOxygen {
    SWMVertexData *modelGen = [[SWMVertexData alloc]
                               initSphereWithRecursionLevel:2 andColour:GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f)
                               andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.75f, 0.75f, 0.75f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createHydrogen {
    SWMVertexData *modelGen = [[SWMVertexData alloc]
                               initSphereWithRecursionLevel:2 andColour:GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f)
                               andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.5f, 0.5f, 0.5f)];
    [transformation setTranslationVector:GLKVector3Make(0.0f, -2.0f, -6.0f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createSingleBond {
    SWMVertexData *modelGen = [[SWMVertexData alloc] initCylinderWithSlices:1 andColour:GLKVector4Make(0.48f, 0.32f, 0.18f, 1.0f) andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 1.0f, 0.2f)];
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(215), 0.0f, 0.0f, 1.0f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createSingleBond2 {
    SWMVertexData *modelGen = [[SWMVertexData alloc] initCylinderWithSlices:1 andColour:GLKVector4Make(0.48f, 0.32f, 0.18f, 1.0f) andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 1.0f, 0.2f)];
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(135), 0.0f, 0.0f, 1.0f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

@end
