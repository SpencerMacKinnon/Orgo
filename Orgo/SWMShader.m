//
//  SWMShader.m
//  Life
//
//  Created by Spencer MacKinnon on 2/21/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMShader.h"

@implementation SWMShader

@synthesize vertShaderPathname;
@synthesize fragShaderPathname;
@synthesize program = _program;

- (id)init{
    self = [super init];
    if (self) {
        
        self.program = 0;
        
        // Create reference vertex shader path
        [self setVertShaderPathname:[[NSBundle mainBundle] pathForResource:@"BlinnPhong" ofType:@"vsh" inDirectory:@"Shaders"]];
        
        // Create reference fragment shader path
        [self setFragShaderPathname:[[NSBundle mainBundle] pathForResource:@"BlinnPhong" ofType:@"fsh" inDirectory:@"Shaders"]];
        
        [self loadShaders];
    }
    
    return self;
}

- (BOOL)loadShaders{
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Compile vertex shader.
    if (![self compileShader:&(_vertShader) type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Compile fragment shader.
    if (![self compileShader:&(_fragShader) type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(self.program, _vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(self.program, _fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    //glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    //glBindAttribLocation(_program, GLKVertexAttribTexCoord0, "vertexUV");
    
    // Link program.
    if (![self linkProgram:self.program]) {
        NSLog(@"Failed to link program: %d", self.program);
        
        if (_vertShader) {
            glDeleteShader(_vertShader);
            _vertShader = 0;
        }
        if (_fragShader) {
            glDeleteShader(_fragShader);
            _fragShader = 0;
        }
        if (self.program) {
            glDeleteProgram(self.program);
            self.program = 0;
        }
        
        return NO;
    }
    
    return YES;
}

- (BOOL)releaseShaders{
    // Release vertex and fragment shaders.
    if (_vertShader) {
        glDetachShader(self.program, _vertShader);
        glDeleteShader(_vertShader);
    }
    if (_fragShader) {
        glDetachShader(self.program, _fragShader);
        glDeleteShader(_fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (void)tearDownGL{
    if (_program){
        glDeleteProgram(_program);
        _program = 0;
    }
}

@end
