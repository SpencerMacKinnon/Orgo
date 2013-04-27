//
//  SWMModel.h
//  Life
//
//  Created by Spencer MacKinnon on 2/10/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "SWMBitmapLoader.h"
#include "SWMMatrix.h"
#include "SWMModelGenerator.h"

@interface SWMModel : NSObject
{
    GLKMatrix3 _normalMatrix;
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKVector4 _diffuseLightColour;
    
    SWMModelGenerator *_vertexArray;
    SWMMatrix *_matrix;
}

@property GLKMatrix4 modelViewProjectionMatrix;
@property GLKMatrix3 normalMatrix;
@property GLKVector3 rotationVector, translationVector;
@property GLKVector4 diffuseLightColour;

- (id)initWithModelGenerator:(SWMModelGenerator *)modelGenerator;
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
