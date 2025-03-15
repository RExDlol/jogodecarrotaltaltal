//
// crt + aberracao cromatica
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 resolution;

void main() {
    
    // CRT + Aberracao cromatica - por Lumina 
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    
    vec2 center = vec2(.5, .5);
    vec2 dist = uv - center;
    
    float mult = 0.005 * length(dist) * 5.0;
    
    vec2 offsetR = uv + dist * mult;
    vec2 offsetB = uv - dist * mult;
    
    float rc = texture2D(gm_BaseTexture, offsetR).r;
    float gc = texture2D(gm_BaseTexture, uv).g;
    float bc = texture2D(gm_BaseTexture, offsetB).b;
    
    vec3 color = vec3(rc, gc, bc);
    
    float scanline = 0.5 + 0.5 * sin(uv.y * resolution.y * 0.5);
    
    color *= scanline * .5;
    
    
    
    gl_FragColor = vec4(color, .1);
}

