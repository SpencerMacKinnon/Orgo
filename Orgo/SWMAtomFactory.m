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
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.75f, 0.75f, 0.75f)];
    [transformation setTranslationVector:GLKVector3Make(0.0f, 0.0f, -6.0f)];
    
    SWMModel *oxygen = [[SWMModel alloc] initWithTransformation:transformation];
    [oxygen setDiffuseLightColour:GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f)];
    [oxygen setVertexSetName:@"SPHERE"];
    
    return oxygen;
}

- (SWMModel *)createHydrogen {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.5f, 0.5f, 0.5f)];
    [transformation setTranslationVector:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    
    SWMModel *hydrogen = [[SWMModel alloc] initWithTransformation:transformation];;
    [hydrogen setDiffuseLightColour:GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f)];
    [hydrogen setVertexSetName:@"SPHERE"];
    
    return hydrogen;
}

- (SWMModel *)createSingleBond {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 1.0f, 0.2f)];
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(215), 0.0f, 0.0f, 1.0f)];
    [transformation setTranslationVector:GLKVector3Make(0.5f, -0.5f, 0.0f)];
    
    SWMModel *singleBond = [[SWMModel alloc] initWithTransformation:transformation];
    [singleBond setDiffuseLightColour:GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f)];
    [singleBond setVertexSetName:@"CYLINDER"];
    
    return singleBond;
}

- (SWMModel *)createSingleBond2 {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 1.0f, 0.2f)];
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(135), 0.0f, 0.0f, 1.0f)];
    [transformation setTranslationVector:GLKVector3Make(-0.5f, -0.5f, 0.0f)];
    
    SWMModel *singleBond = [[SWMModel alloc] initWithTransformation:transformation];
    [singleBond setDiffuseLightColour:GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f)];
    [singleBond setVertexSetName:@"CYLINDER"];
    
    return singleBond;
}

@end
