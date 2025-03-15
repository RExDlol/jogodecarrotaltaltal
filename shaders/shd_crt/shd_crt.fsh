//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniform para passar a resolução da tela
uniform vec2 resolution;

void main() {
    
    // CRT + Aberracao cromatica - por Lumina
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    
    
    float scanline = 0.5 + 0.5 * sin(uv.y * resolution.y * 0.5);
    
    
    vec3 color = texture2D(gm_BaseTexture, uv).rgb;
    
    
    color *= scanline * .2;
    
    
    gl_FragColor = vec4(color, .5);
}

