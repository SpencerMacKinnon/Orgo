//
//  SWMBitmapLoader.h
//  Orgo
//
//  Created by Spencer MacKinnon on 3/2/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWMBitmapLoader : NSObject {
    
}

+(GLuint)loadTexture:(NSString * const)fileName;
+(GLuint) loadBMP_custom:(char * const) imagePath;

@end
