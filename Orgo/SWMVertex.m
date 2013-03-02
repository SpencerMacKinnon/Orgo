//
//  SWMVertex.m
//  Orgo
//
//  Created by Spencer MacKinnon on 2/25/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMVertex.h"
#import <GLKit/GLKit.h>

struct SWMVertex1P1D1S2UV4J {
    GLKVector3 _position;
    GLKVector4 _diffuseColour;
    GLKVector4 _specularColour;
    float _uv0[2];
    float _uv1[2];
    unsigned short _jointIndices[4];
    float _jointWeights[3];
};
