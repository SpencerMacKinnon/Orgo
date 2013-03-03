//
//  Shader.vsh
//  Orgo
//
//  Created by Spencer MacKinnon on 12/23/12.
//  Copyright (c) 2012 Spencer MacKinnon. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec2 vertexUV;
attribute vec4 diffuseColor;

varying lowp vec4 colorVarying;
varying vec2 UV;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = diffuseColor * nDotVP;
    
    UV = vertexUV;
    
    gl_Position = modelViewProjectionMatrix * position;
}
