uniform lowp vec4 u_diffusecolour;
uniform lowp vec4 u_lightcolour;
uniform lowp vec4 u_lightdirection;
uniform mediump float u_specular;

varying lowp vec3 N;
varying lowp vec3 v;

void main()
{
    lowp vec3 L = normalize(u_lightdirection.xyz - v);
    lowp vec3 E = normalize(-v);
    lowp vec3 R = normalize(-reflect(L,N));
    
    lowp vec4 Iamb = 1.0 * u_diffusecolour;

    lowp vec4 Idiff = u_diffusecolour * max(dot(N,L), 0.0);
    Idiff = clamp(Idiff, 0.0, 1.0);
    
    lowp vec4 Ispec = u_lightcolour * pow(max(dot(R,E),0.0),0.3 * u_specular);
    Ispec = clamp(Ispec, 0.0, 1.0);

    gl_FragColor = /*Iamb + */Idiff ;//+ Ispec;
}