//
//  SWMVertex.h
//  Orgo
//
//  Created by Spencer MacKinnon on 2/25/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SWMVertex : NSObject

typedef struct {
    float _position[3];
    float _diffuseColour[4];
} SWMVertex1P1D;

typedef struct {
    float _position[3];
    float _normal[3];
} SWMVertex1P1N;

typedef struct  {
    float _position[3];
    float _normal[3];
    float _diffuseColour[4];
    float _uv0[2];
} SWMVertex1P1N1D1UV;

typedef struct  {
    float _position[3];
    float _normal[3];
    float _diffuseColour[4];
    float _specularColour[4];
    float _uv0[2];
    float _uv1[2];
    unsigned short _jointIndices[4];
    float _jointWeights[3];
} SWMVertex1P1N1D1S2UV4J;

typedef enum {
    GLU_BYTE,
    GLU_SHORT,
    GLU_INT
} GLU_INDEX_TYPE;

typedef enum {
    SWM_1P1D,
    SWM_1P1N,
    SWM_P1N1D1UV,
    SWM_1P1N1D1S2UV4J
} SWM_VERTEX_TYPE;

@end
