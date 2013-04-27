//
//  SWMViewController.m
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

#import "SWMViewController.h"

const float MAX_ZOOM_IN = 3.5;
const float MAX_ZOOM_OUT = -9.0;

@interface SWMViewController () {
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;
@end

@implementation SWMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    _aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), _aspect, 0.1f, 100.0f);
    [self setupGL];
    [self setupGestureRecognizers];
}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    glEnable(GL_DEPTH_TEST);
    
    SWMShader *_shader = [[SWMShader alloc] init];
    _materialCollection = [[SWMMaterialCollection alloc] initWithShader:_shader];
    [_materialCollection setupGL];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    [_materialCollection tearDownGL];
    self.effect = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    _aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), _aspect, 0.1f, 100.0f);
    [_materialCollection updateWithProjectionMatrix:_projectionMatrix andTimeSinceLastUpdate:self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [_materialCollection glkView:view drawInRect:rect];
}

#pragma mark - Gesture Recognizers

- (void)setupGestureRecognizers
{
    _lastScale = 1.0f;
    _lastTransX = 0.0f;
    _lastTransY = 0.0f;
    
    UITapGestureRecognizer *_dtgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    _dtgr.numberOfTapsRequired = 2;
    _dtgr.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:_dtgr];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [_materialCollection resetModelsOrientation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [_materialCollection touchAtPoint:location withViewBounds:self.view.bounds];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [_materialCollection touchesMoved:location withViewBounds:self.view.bounds];
}

@end
