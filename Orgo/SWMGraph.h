//
//  SWMGraph.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWMGraph : NSObject {
    BOOL *adjacencyMatrix;
    NSMutableData *adjacencyMatrixData;
    NSMutableArray *vertices;
    NSMutableDictionary *edges;
    unsigned short numVertices;
    unsigned short numEdges;
}

- (id)initWithNumberOfVertices:(unsigned short) numberOfVertices;
- (void)addVertex:(NSObject *)vertex;
- (void)addVertex:(NSObject *)vertex atIndex:(unsigned short)index;

@end
