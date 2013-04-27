//
//  SWMModel.h
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#import "SWMBitmapLoader.h"
#import "SWMMatrix.h"
#import "SWMVertexData.h"

@interface SWMModel : NSObject
{
    GLKMatrix3 _normalMatrix;
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKVector4 _diffuseLightColour;
    
    SWMVertexData *_vertexArray;
    SWMMatrix *_matrix;
}

@property GLKMatrix4 modelViewProjectionMatrix;
@property GLKMatrix3 normalMatrix;
@property GLKVector3 rotationVector, translationVector;
@property GLKVector4 diffuseLightColour;

- (id)initWithModelGenerator:(SWMVertexData *)modelGenerator andTransformation:(SWMMatrix *)transformation;
- (int)numberOfVertices;
- (int)numberOfIndices;
- (GLKMatrix4)objectTransformWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate;
- (NSMutableData *)vertexData;
- (NSMutableData *)indexData;
- (void)resetOrientation;
- (void)setTranslationVectorX:(float)transX;
- (void)setTranslationVectorY:(float)transY;
- (void)setTranslationVectorZ:(float)transZ;
- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds;
- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds;

@end
