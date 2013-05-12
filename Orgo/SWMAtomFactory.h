//
//  SWMAtomFactory.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SWMAtom.h"
#import "SWMModel.h"
#import "SWMModelFactory.h"
#import "SWMModelGraph.h"

@interface SWMAtomFactory : SWMModelFactory {
    GLKVector3 HYDROGEN_SCALING;
    GLKVector3 NORMAL_ATOM_SCALING;
}

@property SWMModelGraph *modelGraph;

- (SWMModel *)createOxygen;
- (SWMModel *)createHydrogen;
- (SWMModel *)createSingleBond;
- (SWMModel *)createSingleBond2;

- (void)createAmericanCompound;
- (void)createWater;
@end
