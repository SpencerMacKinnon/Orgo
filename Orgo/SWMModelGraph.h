//
//  SWMModelGraph.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWMMaterialCollection.h"
#import "SWMModel.h"

@interface SWMModelGraph : NSObject {
    SWMMaterialCollection *materialCollection;
    NSMutableArray *adjacencyList;
    NSMutableArray *vertices;
    NSMutableArray *models;
    NSMutableArray *modelsWithHierarchy;
    NSMutableDictionary *edges;
    unsigned short numVertices;
    unsigned short numEdges;
}

- (id)init;

- (void)replaceVertex:(SWMModel *)vertex atIndex:(unsigned short)index;
- (void)addModel:(SWMModel *)model;

- (void)createEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex;
- (void)removeEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex;

- (void)resetModelsOrientation;
- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix andTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate;
- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds;
- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds;

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;

- (unsigned short)vertexCount;

- (void) setupGL;
- (void) tearDownGL;

@end
