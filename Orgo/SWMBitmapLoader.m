//
//  SWMBitmapLoader.m
//  Orgo
//
//  Created by Spencer MacKinnon on 3/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import "SWMBitmapLoader.h"

@implementation SWMBitmapLoader

-(id) init{
    self = [super init];
    if (self) {
    }
    
    return self;
}

+ (GLuint)loadTexture:(NSString * const)fileName {
    UIImage *image = [UIImage imageWithContentsOfFile:fileName];
    
    CGImageRef spriteImage = image.CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image");
        return 0;
    }
    
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte *spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    free(spriteData);
    return texName;
}

+(GLuint) loadBMP_custom:(char * const) imagePath {
    unsigned char header[54];
    unsigned int dataPos;
    unsigned int width, height;
    unsigned int imageSize;
    unsigned char *data;
    
    FILE *file = fopen(imagePath, "rb");
    if (!file) {
        NSLog(@"File could not be opened");
        return 0;
    }
    
    if (fread(header, 1, 54, file)!=54) {
        NSLog(@"Not a correct BMP file");
        return 0;
    }
    
    if (header[0]!='B' || header[1]!='M') {
        NSLog(@"Not a correct BMP file");
        return 0;
    }
    
    dataPos = *(int*)&(header[0x0A]);
    imageSize = *(int*)&(header[0x22]);
    width = *(int*)&(header[0x12]);
    height = *(int*)&(header[0x16]);
    
    if (imageSize == 0) { // Some BMP files are misformatted, try a best guess
        imageSize = width * height * 3;
    }
    
    if (dataPos == 0) { // header is 54 bytes long
        dataPos = 54;
    }
    
    data = (unsigned char *)malloc(imageSize);
    fread(data, 1, imageSize, file);
    fclose(file);
    
    GLuint textureID;
    glGenTextures(1, &textureID);
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_BGRA_EXT, GL_UNSIGNED_BYTE, data);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    return textureID;
}

@end
