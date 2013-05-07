//
//  SWMModelFactory.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMModel.h"
#import "SWMVertexData.h"

@interface SWMModelFactory : NSObject

@property (nonatomic, readonly) unsigned int currentVertexCount, currentIndexCount;

- (SWMVertexData *)createSphereVerticesWithRecursionLevel:(int)recursionLevel;
- (SWMVertexData *)createCylinderVerticesWithSlices:(int)slices;

@end
