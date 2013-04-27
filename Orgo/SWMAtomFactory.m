//
//  SWMAtomFactory.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMAtomFactory.h"

@implementation SWMAtomFactory

- (SWMModel *)createOxygen {
    SWMVertexData *modelGen = [[SWMVertexData alloc]
                               initSphereWithRecursionLevel:1 andColour:GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f)
                               andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.75f, 0.75f, 0.75f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createHydrogen {
    SWMVertexData *modelGen = [[SWMVertexData alloc]
                               initSphereWithRecursionLevel:1 andColour:GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f)
                               andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.25f, 0.25f, 0.25f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createSingleBond {
    SWMVertexData *modelGen = [[SWMVertexData alloc] initCylinderWithSlices:1 andColour:GLKVector4Make(0.79f, 0.67f, 0.58f, 1.0f) andExistingVertexCount:[super currentVertexCount]];
    SWMMatrix *transformation = [[SWMMatrix alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 2.0f, 0.2f)];
    return [super addModelWithModelGen:modelGen andTransformation:transformation];
}

@end
