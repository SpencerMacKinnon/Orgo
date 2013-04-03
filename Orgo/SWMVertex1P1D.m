//
//  SWMVertex1P1D.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMVertex1P1D.h"

@implementation SWMVertex1P1D

- (id)initWithPosition:(GLKVector3)position andColour:(GLKVector4) diffuseColour {
    self = [super init];
    if (self) {
        self.position = position;
        self.diffuseColour = diffuseColour;
    }
    
    return self;
}

@end
