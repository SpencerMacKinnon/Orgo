//
//  SWMGraph.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMGraph.h"

@implementation SWMGraph

- (id)init {
    self = [super init];
    if (self) {
        numVertices = 0;
        numEdges = 0;
        adjacencyMatrixData = [[NSMutableData alloc] init];
        adjacencyMatrix = [adjacencyMatrixData mutableBytes];
        vertices = [[NSMutableArray alloc] init];
        edges = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id)initWithNumberOfVertices:(unsigned short) numberOfVertices{
    self = [super init];
    if (self) {
        numVertices = numberOfVertices;
        numEdges = 0;
        adjacencyMatrixData = [[NSMutableData alloc] initWithCapacity:(numVertices * numVertices) * sizeof(short)];
        adjacencyMatrix = [adjacencyMatrixData mutableBytes];
        vertices = [[NSMutableArray alloc] initWithCapacity:numberOfVertices];
        edges = [[NSMutableDictionary alloc] initWithCapacity:numberOfVertices * numberOfVertices];
        
        [self resetAdjacencyMatrix];
        [self resetVertices];
    }
    
    return self;
}

- (void)addVertex:(NSObject *)vertex {
    numVertices++;
    [vertices addObject:vertex];
}

- (void)addVertex:(NSObject *)vertex atIndex:(unsigned short)index {
    if (![self vertexWithinRange:index]) {
        return;
    }
    
    [vertices replaceObjectAtIndex:index withObject:vertex];
}

- (void)createEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = YES;
    adjacencyMatrix[(secondVertex * numVertices) + firstVertex] = YES;
    numEdges++;
}

- (void)removeEdgeBetweenFirstVertex:(unsigned short)firstVertex andSecondVertex:(unsigned short)secondVertex {
    if (![self vertexPairExistsInGraph:firstVertex secondVertex:secondVertex]) {
        return;
    }
    
    adjacencyMatrix[(firstVertex * numVertices) + secondVertex] = NO;
    adjacencyMatrix[(secondVertex * numVertices) + firstVertex] = NO;
    numEdges--;
}

- (void)resetAdjacencyMatrix {
    for (int i = 0; i < numVertices * numVertices; i++) {
        adjacencyMatrix[i] = NO;
    }
}

- (void)resetVertices {
    for (int i = 0; i < numVertices; i++) {
        [vertices addObject:[NSNull null]];
    }
}

- (BOOL)vertexWithinRange:(unsigned short)vertex {
    return (vertex >= 0 && vertex < numVertices);
}

- (BOOL)vertexExistsInGraph:(unsigned short)vertex {
    if (![self vertexWithinRange:vertex]) {
        return NO;
    }
    return [vertices objectAtIndex:vertex] != nil;
}

- (BOOL)vertexPairExistsInGraph:(unsigned int)firstVertex secondVertex:(unsigned int)secondVertex {
    return [self vertexExistsInGraph:firstVertex] && [self vertexExistsInGraph:secondVertex];
}

@end
