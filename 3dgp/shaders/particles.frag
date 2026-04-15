#version 330

in float age;
uniform sampler2D texture0;
uniform vec3 uColor;
out vec4 outColor;

void main()
{
    vec4 texColor = texture(texture0, gl_PointCoord);
    // Multiply texture by our custom color uniform
    outColor = vec4(texColor.rgb * uColor, texColor.a);
    if (outColor.a < 0.1) discard;
}