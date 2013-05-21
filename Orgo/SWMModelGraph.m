//
//  SWMModelGraph.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelGraph.h"

@implementation SWMModelGraph

- (id)init{
    self = [super init];
    if (self) {
        numVertices = 0;
        numEdges = 0;
        adjacencyList = [[NSMutableArray alloc] init];
        vertices = [[NSMutableArray alloc] init];
        edges = [[NSMutableDictionary alloc] init];
        models = [[NSMutableArray alloc] init];
        modelsWithHierarchy = [[NSMutableArray alloc] init];
        materialCollection = [[SWMMaterialCollection alloc] init];
    }
    
    return self;
}

- (void)replaceVertex:(SWMModel *)vertex atIndex:(unsigned short)index {
    if (![self vertexWithinRange:index]) {
        return;
    }
    
    [models replaceObjectAtIndex:index withObject:vertex];
}

- (void)createDirectionalEdgeFromFirstVertex:(unsigned short)firstVertex toSecondVertex:(unsigned short)secondVertex {
    
    NSMutableArray *arrayListForFirstVertex = [adjacencyList objectAtIndex:firstVertex];
    
    if (![arrayListForFirstVertex containsObject:[NSNumber numberWithUnsignedShort:secondVertex]]) {
        [[adjacencyList objectAtIndex:firstVertex] addObject:[NSNumber numberWithUnsignedShort:secondVertex]];
    }
    
    numEdges++;
}

- (void)removeDirectionalEdgeFromFirstVertex:(unsigned short)firstVertex toSecondVertex:(unsigned short)secondVertex {
    
    NSMutableArray *arrayListForFirstVertex = [adjacencyList objectAtIndex:firstVertex];
    
    if ([arrayListForFirstVertex containsObject:[NSNumber numberWithUnsignedShort:secondVertex]]) {
        [[adjacencyList objectAtIndex:firstVertex] removeObject:[NSNumber numberWithUnsignedShort:secondVertex]];
    }
    
    numEdges--;
}

- (void)createEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    [self createDirectionalEdgeFromFirstVertex:firstVertex toSecondVertex:secondVertex];
    [self createDirectionalEdgeFromFirstVertex:secondVertex toSecondVertex:firstVertex];
    
    numEdges += 2;
}

- (void)removeEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    [self removeDirectionalEdgeFromFirstVertex:firstVertex toSecondVertex:secondVertex];
    [self removeDirectionalEdgeFromFirstVertex:secondVertex toSecondVertex:firstVertex];
    
    numEdges -= 2;
}

- (void)resetAdjacencyMatrix {
    for (int i = 0; i < numVertices; i++) {
        [[adjacencyList objectAtIndex:i] removeAllObjects];
    }
}

- (void)resetVertices {
    for (int i = 0; i < numVertices; i++) {
        [models addObject:[NSNull null]];
    }
}

- (BOOL)vertexWithinRange:(unsigned short)vertex {
    return (vertex >= 0 && vertex < numVertices);
}

- (BOOL)vertexExistsInGraph:(unsigned short)vertex {
    if (![self vertexWithinRange:vertex]) {
        return NO;
    }
    return YES;
    //return [_models objectAtIndex:vertex] != nil;
}

- (BOOL)vertexPairExistsInGraph:(unsigned int)firstVertex secondVertex:(unsigned int)secondVertex {
    return [self vertexExistsInGraph:firstVertex] && [self vertexExistsInGraph:secondVertex];
}

- (void)resetModelsOrientation {
    [[models objectAtIndex:0] resetOrientation];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [materialCollection glkView:view drawInRect:rect withModels:modelsWithHierarchy];
}

- (void)modelsWithHierarchicalTransformationForLevel:(unsigned short)level withModels:(NSMutableArray *)m{
    
    if (level == numVertices) {
        return;
    }
    
    SWMModel *parentModel = [m objectAtIndex:level];
    
    GLKMatrix4 parentModelViewMatrix = [parentModel modelViewMatrix];
    
    for (int i = level; i < numVertices; i++) {
        if ([[adjacencyList objectAtIndex:level] containsObject:[NSNumber numberWithUnsignedShort:i]])
        {
            SWMModel *childModel = [m objectAtIndex:i];
            GLKMatrix4 childModelViewMatrix = [childModel objectTransform];
            childModelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, childModelViewMatrix);
            [childModel setModelViewMatrix:childModelViewMatrix];
            [m replaceObjectAtIndex:i withObject:childModel];
        }
    }
    
    [self modelsWithHierarchicalTransformationForLevel:level+1 withModels:m];
}

- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix andTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate{
    GLKMatrix4 rootModelMatrix = [[models objectAtIndex:0] slerpWithTimeSinceLastUpdate:timeSinceLastUpdate];
    rootModelMatrix = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(0.0f, -2.5f, -6.0f), rootModelMatrix);
    [[models objectAtIndex:0] setModelViewMatrix:rootModelMatrix];
    
    modelsWithHierarchy = [[NSMutableArray alloc] initWithArray:models];
    [self modelsWithHierarchicalTransformationForLevel:0 withModels:modelsWithHierarchy];
    
    for (SWMModel *model in modelsWithHierarchy) {
        [model scaleModel];
        GLKMatrix4 modelViewMatrix = [model modelViewMatrix];
        GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
        GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
        
        [model setNormalMatrix:normalMatrix];
        [model setModelViewProjectionMatrix:modelViewProjectionMatrix];
    }
}

- (void)touchAtPoint:(CGPoint)location withViewBounds:(CGRect)viewBounds {    
    [[models objectAtIndex:0] touchAtPoint:location withViewBounds:viewBounds];
}

- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    [[models objectAtIndex:0] touchesMoved:location withViewBounds:viewBounds];
}

- (void)addModel:(SWMModel *)model{
    numVertices++;
    [adjacencyList addObject:[[NSMutableArray alloc] init]];
    [models addObject:model];
}

- (unsigned short)vertexCount {
    return numVertices;
}

- (void) setupGL {
    [materialCollection setupGL];
}

- (void) tearDownGL {
    [materialCollection tearDownGL];
}

@end
