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
    [_materialCollection updateWithProjectionMatrix:_projectionMatrix];
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
    
    UILongPressGestureRecognizer *_lgpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _lgpr.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:_lgpr];
    
    UITapGestureRecognizer *_dtgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    _dtgr.numberOfTapsRequired = 2;
    _dtgr.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:_dtgr];
    
    UITapGestureRecognizer *_tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _tgr.numberOfTapsRequired = 1;
    _tgr.numberOfTouchesRequired = 1;
    [_tgr requireGestureRecognizerToFail:_dtgr];
    [self.view addGestureRecognizer:_tgr];
    
//    UIPinchGestureRecognizer *_tfpgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
//    [self.view addGestureRecognizer:_tfpgr];
    
//    UISwipeGestureRecognizer *_sgrl = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
//    [_sgrl setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:_sgrl];
//    
//    UISwipeGestureRecognizer *_sgrr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
//    [_sgrr setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:_sgrr];
//    
//    UISwipeGestureRecognizer *_sgru = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
//    [_sgrr setDirection:UISwipeGestureRecognizerDirectionUp];
//    [self.view addGestureRecognizer:_sgru];
//    
//    UISwipeGestureRecognizer *_sgrd = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
//    [_sgrd setDirection:UISwipeGestureRecognizerDirectionDown];
//    [self.view addGestureRecognizer:_sgrd];
    
    UIPanGestureRecognizer *_ofpangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [_ofpangr setMinimumNumberOfTouches:1];
    [_ofpangr setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:_ofpangr];
    
//    UIPanGestureRecognizer *_tfpangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerPanGesture:)];
//    [_tfpangr setMinimumNumberOfTouches:2];
//    [_tfpangr setMaximumNumberOfTouches:2];
//    [_tfpangr requireGestureRecognizerToFail:_tfpgr];
//    [self.view addGestureRecognizer:_tfpangr];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"Long press detected");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    [_materialCollection resetModelsOrientation];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"Tap detected");
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer{
    [_materialCollection rotateModelsX:-(M_PI_4)];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer{
    [_materialCollection rotateModelsX:(M_PI_4)];
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)gestureRecognizer{
    [_materialCollection rotateModelsY:(M_PI_4)];
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)gestureRecognizer{
    [_materialCollection rotateModelsY:-(M_PI_4)];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        _lastTransX = 0.0f;
        _lastTransY = 0.0f;
    }
    
    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
    
    CGFloat xMagnitude = sqrtf(translatedPoint.x * translatedPoint.x);
    CGFloat yMagnitude = sqrtf(translatedPoint.y * translatedPoint.y);
    CGFloat xyDiff = xMagnitude - yMagnitude;
    xyDiff = sqrtf(xyDiff * xyDiff);

    const float ROTATION_RATE = M_PI_4 * 0.1f;
    const float DIAGONAL_PAN_DIFFERENCE = 1.0f;
    
    if ((xMagnitude > yMagnitude) /*|| (xyDiff < DIAGONAL_PAN_DIFFERENCE)*/) {
        if (translatedPoint.x > _lastTransX) {
            [_materialCollection rotateModelsY:ROTATION_RATE];
        } else {
            [_materialCollection rotateModelsY:-ROTATION_RATE];
        }
        _lastTransX = translatedPoint.x;
    }
    if ((yMagnitude > xMagnitude) /*|| (xyDiff < DIAGONAL_PAN_DIFFERENCE)*/)  {
        if (translatedPoint.y > _lastTransY) {
            [_materialCollection rotateModelsX:ROTATION_RATE];
        } else {
            [_materialCollection rotateModelsX:-ROTATION_RATE];
        }
        _lastTransY = translatedPoint.y;
    }
}

//- (void)handleTwoFingerPanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
//   
//    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
//    NSLog(@"Translated X: %f Translated Y: %f", translatedPoint.x, translatedPoint.y);
//    
//    CGFloat xMagnitude = sqrtf(translatedPoint.x * translatedPoint.x);
//    CGFloat yMagnitude = sqrtf(translatedPoint.y * translatedPoint.y);
//    CGFloat xyDiff = xMagnitude - yMagnitude;
//    xyDiff = sqrtf(xyDiff * xyDiff);
//    NSLog(@"xMag: %f yMag: %f xyDiff: %f", xMagnitude, yMagnitude, xyDiff);
//    
//    const float TRANSLATION_RATE = 0.03;
//    
//    float currentXTrans = [_model translationVector].x;
//    float currentYTrans = [_model translationVector].y;
//    
//    if ((xMagnitude > yMagnitude) || (xyDiff < 20.0f)) {
//        if (translatedPoint.x > 0) {
//            [_model setTranslationVectorX:currentXTrans + TRANSLATION_RATE];
//        } else {
//            [_model setTranslationVectorX:currentXTrans - TRANSLATION_RATE];
//        }
//    }
//    if ((yMagnitude > xMagnitude) || (xyDiff < 20.0f)) {
//        if (translatedPoint.y > 0) {
//            [_model setTranslationVectorY:currentYTrans - TRANSLATION_RATE];
//        } else {
//            [_model setTranslationVectorY:currentYTrans + TRANSLATION_RATE];
//        }
//    }
//}

//- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer{
//    
//    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//        _lastScale = 1.0;
//    }
//    
//    CGFloat scale = [gestureRecognizer scale] - _lastScale;
//    float newZPos = [_model translationVector].z;
//    newZPos += (4.0 * scale);
//    if (newZPos < MAX_ZOOM_OUT || newZPos > MAX_ZOOM_IN) {
//        return;
//    }
//    
//    [_model setTranslationVectorZ:newZPos];
//    _lastScale = [gestureRecognizer scale];
//}

@end
