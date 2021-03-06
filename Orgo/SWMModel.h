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
#import "SWMObjectTransformation.h"

@interface SWMModel : NSObject
{
    SWMObjectTransformation *_matrix;
}

@property GLKMatrix4 modelViewMatrix;
@property GLKMatrix4 modelViewProjectionMatrix;
@property GLKMatrix3 normalMatrix;
@property GLKVector3 rotationVector, translationVector;
@property GLKVector4 diffuseLightColour;
@property (nonatomic, strong) NSString *vertexSetName;

- (id)initWithTransformation:(SWMObjectTransformation *)transformation;
- (GLKMatrix4)slerpWithTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate;
- (GLKMatrix4)objectTransform;
- (void)scaleModel;
- (void)resetOrientation;
- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds;
- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds;

@end
