//
//  SWMModelFactory.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMModel.h"

@interface SWMModelFactory : NSObject

@property (nonatomic, readonly) unsigned int currentVertexCount;

- (SWMModel *)createSphereWithRecursionLevel:(int)recursionLevel withColour:(GLKVector4)colour;
- (SWMModel *)createCylinderWithSlices:(int)slices withColour:(GLKVector4)colour;
- (SWMModel *)addModelWithModelGen:(SWMVertexData *)modelGen andTransformation:(SWMObjectTransformation *)transformation;

@end
