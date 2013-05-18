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

@interface SWMAtomFactory : SWMModelFactory {
    GLKVector3 HYDROGEN_SCALING;
    GLKVector3 NORMAL_ATOM_SCALING;
}

- (SWMModel *)createOxygen;
- (SWMModel *)createHydrogen;
- (SWMModel *)createSingleBond;
- (SWMModel *)createSingleBond2;

- (SWMModel *)createAtomWithType:(SWM_ATOM_NAME)atomName;
- (SWMModel *)createBondWithOrientaiton:(SWM_BOND_ORIENTATION)bondOrientation;

@end
