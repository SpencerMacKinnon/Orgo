//
//  SWMCompoundGraph.m
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMCompoundGraph.h"

@implementation SWMCompoundGraph

- (void)addAtom:(SWM_ATOM)atom {
    NSValue *value = [NSValue value:&atom withObjCType:@encode(SWM_ATOM)];
    [super addVertex:value];
}

- (void)replaceAtom:(SWM_ATOM)atom atIndex:(unsigned short)index {
    NSValue *value = [NSValue value:&atom withObjCType:@encode(SWM_ATOM)];
    [super replaceVertex:value atIndex:index];
}

@end
