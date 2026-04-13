#version 330

in float age;
uniform sampler2D texture0;
out vec4 outColor;

void main()
{

    vec4 texColor = texture(texture0, gl_PointCoord);
    
    vec3 tint = vec3(0.8, 1.0, 0.2);
    
    outColor = vec4(texColor.rgb * tint, texColor.a);
    
    if (outColor.a < 0.1) discard;
}