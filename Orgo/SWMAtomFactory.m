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

- (id) init {
    self = [super init];
    if (self) {
        HYDROGEN_SCALING = GLKVector3Make(0.5f, 0.5f, 0.5f);
        NORMAL_ATOM_SCALING = GLKVector3Make(0.75f, 0.75f, 0.75f);
    }
    
    return self;
}

- (SWMModel *)createOxygen {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.75f, 0.75f, 0.75f)];
    [transformation setTranslationVector:GLKVector3Make(0.0f, 0.0f, 0.0f)];
    
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
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(225), 0.0f, 0.0f, 1.0f)];
    [transformation setTranslationVector:GLKVector3Make(0.5f, -0.5f, 0.0f)];
    
    SWMModel *singleBond = [[SWMModel alloc] initWithTransformation:transformation];
    [singleBond setDiffuseLightColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
    [singleBond setVertexSetName:@"CYLINDER"];
    
    return singleBond;
}

- (SWMModel *)createAtomWithType:(SWM_ATOM_NAME)atomName {
    GLKVector3 scaling = NORMAL_ATOM_SCALING;
    GLKVector4 colour = GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f);
    
    switch (atomName) {
        case CARBON:
            colour = GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f);
            break;
        case HYDROGEN:
            colour = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
            scaling = HYDROGEN_SCALING;
            break;
        case NITROGEN:
            colour = GLKVector4Make(0.0f, 0.0f, 1.0f, 1.0f);
            break;
        case OXYGEN:
            colour = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);
            break;
        case PHOSPHORUS:
            colour = GLKVector4Make(0.0f, 1.0f, 1.0f, 1.0f);
            break;
        default:
            break;
    }
    
    return [self createAtomWithScaling:scaling andColour:colour];
}

- (SWMModel *)createBondWithOrientaiton:(SWM_BOND_ORIENTATION)bondOrientation {
    SWMModel *bond = nil;
    
    switch (bondOrientation) {
        case NORTH:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(0), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(0.0f, 0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case NORTHEAST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(315), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(0.5f, 0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case EAST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(270), 0.0f, 0.0f, 1.0f)
                                        withTranslation:GLKVector3Make(0.5f, 0.0f, 0.0f)
                                            withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                              andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case SOUTHEAST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(225), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(0.5f, -0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case SOUTH:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(180), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(0.0f, -0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case SOUTHWEST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(135), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(-0.5f, -0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case WEST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(90), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(-0.5f, 0.0f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        case NORTHWEST:
            bond = [self createBondUsingRotation:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(45), 0.0f, 0.0f, 1.0f)
                                 withTranslation:GLKVector3Make(-0.5f, 0.5f, 0.0f)
                                     withScaling:GLKVector3Make(0.2f, 1.0f, 0.2f)
                                       andColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
            break;
        default:
            break;
    }
    
    return bond;
}

- (SWMModel *)createSingleBond2 {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:GLKVector3Make(0.2f, 1.0f, 0.2f)];
    [transformation setQuat:GLKQuaternionMakeWithAngleAndAxis(DEGREES_TO_RADIANS(135), 0.0f, 0.0f, 1.0f)];
    [transformation setTranslationVector:GLKVector3Make(-0.5f, -0.5f, 0.0f)];
    
    SWMModel *singleBond = [[SWMModel alloc] initWithTransformation:transformation];
    [singleBond setDiffuseLightColour:GLKVector4Make(0.56f, 0.31f, 0.14f, 1.0f)];
    [singleBond setVertexSetName:@"CYLINDER"];
    
    return singleBond;
}

- (SWMModel *)createAtomWithScaling:(GLKVector3)scalingVector andColour:(GLKVector4)colour {
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:scalingVector];
    [transformation setTranslationVector:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    
    SWMModel *atom = [[SWMModel alloc] initWithTransformation:transformation];;
    [atom setDiffuseLightColour:colour];
    [atom setVertexSetName:@"SPHERE"];
    
    return atom;
}

- (SWMModel *)createBondUsingRotation:(GLKQuaternion)angleAndRotation
                            withTranslation:(GLKVector3)translationVector
                                withScaling:(GLKVector3)scalingVector
                                  andColour:(GLKVector4)colour{
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    [transformation setScalingVector:scalingVector];
    [transformation setQuat:angleAndRotation];
    [transformation setTranslationVector:translationVector];
    
    SWMModel *bond = [[SWMModel alloc] initWithTransformation:transformation];
    [bond setDiffuseLightColour:colour];
    [bond setVertexSetName:@"CYLINDER"];
    
    return bond;
}

/*Fix bad code */

//- (void)addCarbonWithBondOne:(unsigned short)bondOne withBondTwo:(unsigned short)bondTwo withBondThree:(unsigned short)bondThree andBondFour:(unsigned short)bondFour {
//    [_modelGraph addModel:[self createAtomWithType:CARBON]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondOne andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondTwo andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondThree andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondFour andSecondVertex:[_modelGraph vertexCount]];
//}
//
//- (void)addHydrogenWithBond:(unsigned short)bond {
//    [_modelGraph addModel:[self createAtomWithType:HYDROGEN]];
//    [_modelGraph createEdgeBetweenFirstVertex:bond andSecondVertex:[_modelGraph vertexCount]];
//}
//
//- (void)addNitrogenWithBondOne:(unsigned short)bondOne withBondTwo:(unsigned short)bondTwo andBondThree:(unsigned short)bondThree {
//    [_modelGraph addModel:[self createAtomWithType:NITROGEN]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondOne andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondTwo andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondThree andSecondVertex:[_modelGraph vertexCount]];
//}
//
//- (void)addOxygenWithBondOne:(unsigned short)bondOne andBondTwo:(unsigned short)bondTwo {
//    [_modelGraph addModel:[self createAtomWithType:NITROGEN]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondOne andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondTwo andSecondVertex:[_modelGraph vertexCount]];
//}
//
//- (void)addPhosphorusWithBondOne:(unsigned short)bondOne withBondTwo:(unsigned short)bondTwo withBondThree:(unsigned short)bondThree withBondFour:(unsigned short)bondFour andBondFive:(unsigned short)bondFive{
//    [_modelGraph addModel:[self createAtomWithType:PHOSPHORUS]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondOne andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondTwo andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondThree andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondFour andSecondVertex:[_modelGraph vertexCount]];
//    [_modelGraph createEdgeBetweenFirstVertex:bondFive andSecondVertex:[_modelGraph vertexCount]];
//}
//
//- (void)createWater {
//    SWMModel *bond1 = [self createSingleBond];
//    SWMModel *bond2 = [self createSingleBond2];
//    SWMModel *oxygen = [self createOxygen];
//    SWMModel *hydrogen1 = [self createHydrogen];
//    SWMModel *hydrogen2 = [self createHydrogen];
//    
//    [_modelGraph addModel:oxygen];
//    [_modelGraph addModel:bond1];
//    [_modelGraph addModel:bond2];
//    [_modelGraph addModel:hydrogen1];
//    [_modelGraph addModel:hydrogen2];
//    
//    [_modelGraph createEdgeBetweenFirstVertex:0 andSecondVertex:1];
//    [_modelGraph createEdgeBetweenFirstVertex:0 andSecondVertex:2];
//    [_modelGraph createEdgeBetweenFirstVertex:1 andSecondVertex:3];
//    [_modelGraph createEdgeBetweenFirstVertex:2 andSecondVertex:4];
//}

@end
