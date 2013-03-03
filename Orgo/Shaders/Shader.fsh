//
//  Shader.fsh
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

varying lowp vec2 UV;

varying lowp vec4 colorVarying;

uniform sampler2D myTextureSampler;

void main()
{
    //gl_FragColor = colorVarying;
    gl_FragColor = colorVarying * texture2D(myTextureSampler, UV);
}
