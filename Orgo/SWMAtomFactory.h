//
//  SWMAtomFactory.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/27/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SWMModel.h"
#import "SWMModelFactory.h"

@interface SWMAtomFactory : SWMModelFactory

- (SWMModel *)createOxygen;
- (SWMModel *)createHydrogen;
- (SWMModel *)createSingleBond;
@end
