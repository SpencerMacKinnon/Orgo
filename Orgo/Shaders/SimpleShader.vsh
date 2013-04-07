//
//  Shader.vsh
//  Orgo
//
//  Created by Spencer MacKinnon on 04/06/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

attribute vec4 position;
attribute vec4 diffuseColor;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    colorVarying = diffuseColor;
    gl_Position = modelViewProjectionMatrix * position;
}
