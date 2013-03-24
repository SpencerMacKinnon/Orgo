//
//  SWMViewController.m
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

#import "SWMViewController.h"
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

const float MAX_ZOOM_IN = -3.5;
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
    _model = [[SWMModel alloc] initWithShader:_shader];
    [_model setModelViewMatrix:GLKMatrix4MakeTranslation(0, 0, -10.0f)];
    
    unsigned int totalDataSize = 0;
    NSMutableData *vertexData = [[NSMutableData alloc] init];
    
    totalDataSize += [[_model vertexData] length];
    [vertexData appendBytes:[[_model vertexData] mutableBytes] length:[[_model vertexData] length]];
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, totalDataSize, [vertexData mutableBytes], GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, [[[_model vertexArray] indexData] length], [[[_model vertexArray] indexData] mutableBytes], GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N1D1UV), BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N1D1UV), BUFFER_OFFSET(12));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N1D1UV), BUFFER_OFFSET(24));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SWMVertex1P1N1D1UV), BUFFER_OFFSET(40));
    
    glBindVertexArrayOES(0);
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    self.effect = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    _aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), _aspect, 0.1f, 100.0f);
    
    GLKMatrix4 modelViewMatrix = [_model objectTransform];
    GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(_projectionMatrix, modelViewMatrix);
    
    [_model setNormalMatrix:normalMatrix];
    [_model setModelViewProjectionMatrix:modelViewProjectionMatrix];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    GLint offset = 0;
    int numberOfVertices = [_model numberOfVertices];
    [_model glkView:view drawInRect:rect];
    glDrawElements(GL_TRIANGLES, [[_model vertexArray] numberOfIndices], GL_UNSIGNED_BYTE, 0);
    offset += numberOfVertices;
    
    glBindVertexArrayOES(_vertexArray);
    
}

- (void)setupGestureRecognizers
{
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
    
    UIPinchGestureRecognizer *_tfpgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:_tfpgr];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"Long press detected");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    [_model setTranslationVector:GLKVector3Make(0, 0, -6.0)];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"Tap detected");
    [_model rotateY:M_PI_2 / 10.0];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer{
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = [gestureRecognizer scale] - _lastScale;
    float newZPos = [_model translationVector].z;
    newZPos += (4.0 * scale);
    if (newZPos < MAX_ZOOM_OUT || newZPos > MAX_ZOOM_IN) {
        return;
    }
    
    [_model setTranslationVectorZ:newZPos];
    _lastScale = [gestureRecognizer scale];
}

@end
