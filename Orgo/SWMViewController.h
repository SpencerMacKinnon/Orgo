//
//  SWMViewController.h
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#include "SWMModel.h"

@interface SWMViewController : GLKViewController {
    GLKMatrix4 _projectionMatrix;
    float _aspect;
    GLuint _indexBuffer, _vertexArray, _vertexBuffer;
    
    SWMModel *_model;
}

@end
