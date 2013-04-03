//
//  SWMVertex1P1D.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SWMVertex1P1D : NSObject

@property GLKVector3 position;
@property GLKVector4 diffuseColour;

- (id)initWithPosition:(GLKVector3)position andColour:(GLKVector4) diffuseColour;

@end
