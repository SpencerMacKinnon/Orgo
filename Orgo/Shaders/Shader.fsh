//
//  Shader.fsh
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
