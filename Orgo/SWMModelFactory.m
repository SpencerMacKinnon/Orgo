//
//  SWMModelFactory.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelFactory.h"

@interface SWMModelFactory()
@property (nonatomic, readwrite) unsigned int currentVertexCount;
@end

@implementation SWMModelFactory

@synthesize currentVertexCount;

- (id)init {
    self = [super init];
    if (self) {
        currentVertexCount = 0;
    }
    
    return self;
}

- (SWMModel *)createSphereWithRecursionLevel:(int)recursionLevel withColour:(GLKVector4)colour {
    SWMVertexData *modelGen = [[SWMVertexData alloc] initSphereWithRecursionLevel:recursionLevel andColour:colour andExistingVertexCount:currentVertexCount];
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    return [self addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)createCylinderWithSlices:(int)slices withColour:(GLKVector4)colour {
    SWMVertexData *modelGen = [[SWMVertexData alloc] initCylinderWithSlices:slices andColour:colour andExistingVertexCount:currentVertexCount];
    SWMObjectTransformation *transformation = [[SWMObjectTransformation alloc] init];
    return [self addModelWithModelGen:modelGen andTransformation:transformation];
}

- (SWMModel *)addModelWithModelGen:(SWMVertexData *)modelGen andTransformation:(SWMObjectTransformation *)transformation {
    SWMModel *model = [[SWMModel alloc] initWithModelGenerator:modelGen andTransformation:transformation];
    currentVertexCount += [model numberOfVertices];
    return model;
}

@end
