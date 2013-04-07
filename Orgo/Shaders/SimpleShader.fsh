//
//  SimpleShader.fsh
//  Orgo
//
//  Created by Spencer MacKinnon on 04/06/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
