attribute vec3 position;
attribute vec3 normal;

uniform mat4 u_mvp;
uniform mat3 u_normal;
//uniform vec4 u_cameraposition;
//uniform vec4 u_lightdirection;

varying lowp vec3 N;
varying lowp vec3 v;

void main()
{
    gl_Position = u_mvp * vec4(position, 1.0);
    
    v = (u_mvp * vec4(position, 1.0)).xyz;
    N = normalize(u_normal * normal);
}