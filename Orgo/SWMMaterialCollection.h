//
//  SWMMaterialCollection.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/7/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMAtomFactory.h"
#import "SWMModel.h"
#import "SWMShader.h"
#import "SWMVertexData.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface SWMMaterialCollection : NSObject {
    
    GLuint _indexBuffer, _vertexArray, _vertexBuffer;
    
    SWMShader *_shader;
    NSMutableDictionary *_vertexSets;
    
    GLKVector3 lightPosition;
    float spec;
}

@property (nonatomic, strong) SWMShader *shader;
@property (nonatomic) GLKVector3 lightColour;

- (id)init;
- (void)addVertexData:(SWMVertexData *)vertexData;

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect withModels:(NSArray *)models;
- (BOOL)loadShaders;
- (BOOL)releaseShaders;
- (void)setupGL;
- (void)tearDownGL;

@end
