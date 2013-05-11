//
//  SWMViewController.h
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "SWMAtomFactory.h"
#import "SWMModelGraph.h"
#import "SWMMaterialCollection.h"

@interface SWMViewController : GLKViewController {
    GLKMatrix4 _projectionMatrix;
    CGFloat _lastScale,_lastTransX, _lastTransY;
    float _aspect;
    
    SWMModelGraph *_modelGraph;
}

@end
