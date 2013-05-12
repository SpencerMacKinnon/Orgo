//
//  SWMModelGraph.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMModelGraph.h"

@implementation SWMModelGraph

@synthesize materialCollection;

- (id)initWithMaterialCollection:(SWMMaterialCollection *)matCollection {
    self = [super init];
    if (self) {
        numVertices = 0;
        numEdges = 0;
        adjacencyMatrixData = [[NSMutableData alloc] init];
        adjacencyMatrix = [adjacencyMatrixData mutableBytes];
        vertices = [[NSMutableArray alloc] init];
        edges = [[NSMutableDictionary alloc] init];
        _models = [[NSMutableArray alloc] init];
        modelsWithHierarchy = [[NSMutableArray alloc] init];
        materialCollection = matCollection;
    }
    
    return self;
}

- (void)replaceVertex:(SWMModel *)vertex atIndex:(unsigned short)index {
    if (![self vertexWithinRange:index]) {
        return;
    }
    
    [_models replaceObjectAtIndex:index withObject:vertex];
}

- (void)createDirectionalEdgeFromFirstVertex:(unsigned short)firstVertex toSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = YES;
    numEdges++;
}

- (void)removeDirectionalEdgeFromFirstVertex:(unsigned short)firstVertex toSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = NO;
    numEdges--;
}

- (void)createEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = YES;
    adjacencyMatrix[(secondVertex * numVertices) + firstVertex] = YES;
    numEdges += 2;
}

- (void)removeEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = NO;
    adjacencyMatrix[(secondVertex * numVertices) + firstVertex] = NO;
    numEdges -= 2;
}

- (void)resetAdjacencyMatrix {
    for (int i = 0; i < numVertices * numVertices; i++) {
        adjacencyMatrix[i] = NO;
    }
}

- (void)resetVertices {
    for (int i = 0; i < numVertices; i++) {
        [_models addObject:[NSNull null]];
    }
}

- (BOOL)vertexWithinRange:(unsigned short)vertex {
    return (vertex >= 0 && vertex < numVertices);
}

- (BOOL)vertexExistsInGraph:(unsigned short)vertex {
    if (![self vertexWithinRange:vertex]) {
        return NO;
    }
    return [_models objectAtIndex:vertex] != nil;
}

- (BOOL)vertexPairExistsInGraph:(unsigned int)firstVertex secondVertex:(unsigned int)secondVertex {
    return [self vertexExistsInGraph:firstVertex] && [self vertexExistsInGraph:secondVertex];
}

- (void)resetModelsOrientation {
    [[_models objectAtIndex:0] resetOrientation];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [materialCollection glkView:view drawInRect:rect withModels:modelsWithHierarchy];
}

- (void)modelsWithHierarchicalTransformationForLevel:(unsigned short)level withModels:(NSMutableArray *)models{
    
    if (level == numVertices) {
        return;
    }
    
    SWMModel *parentModel = [models objectAtIndex:level];
    
    GLKMatrix4 parentModelViewMatrix = [parentModel modelViewMatrix];
    
    for (int i = level; i < numVertices; i++) {
        if (adjacencyMatrix[(level * numVertices) + i] == YES)
        {
            SWMModel *childModel = [models objectAtIndex:i];
            GLKMatrix4 childModelViewMatrix = [childModel objectTransform];
            childModelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, childModelViewMatrix);
            [childModel setModelViewMatrix:childModelViewMatrix];
            [models replaceObjectAtIndex:i withObject:childModel];
        }
    }
    
    [self modelsWithHierarchicalTransformationForLevel:level+1 withModels:models];
}

- (void)updateWithProjectionMatrix:(GLKMatrix4)projectionMatrix andTimeSinceLastUpdate:(NSTimeInterval)timeSinceLastUpdate{
    GLKMatrix4 rootModelMatrix = [[_models objectAtIndex:0] slerpWithTimeSinceLastUpdate:timeSinceLastUpdate];
    rootModelMatrix = GLKMatrix4Multiply(GLKMatrix4MakeTranslation(0.0f, -1.5f, -6.0f), rootModelMatrix);
    [[_models objectAtIndex:0] setModelViewMatrix:rootModelMatrix];
    modelsWithHierarchy = [[NSMutableArray alloc] initWithArray:_models];
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
    [[_models objectAtIndex:0] touchAtPoint:location withViewBounds:viewBounds];
}

- (void)touchesMoved:(CGPoint)location withViewBounds:(CGRect)viewBounds {
    [[_models objectAtIndex:0] touchesMoved:location withViewBounds:viewBounds];
}

- (void)addModel:(SWMModel *)model{
    numVertices++;
    [_models addObject:model];
}

- (unsigned short)vertexCount {
    return numVertices;
}

@end
