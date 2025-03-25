//
// crt + aberracao cromatica
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 resolution;

void main() {
    // Normaliza as coordenadas da textura
    vec2 uv = v_vTexcoord;

    // Criação de scanlines (linhas horizontais)
    if(mod(floor(v_vTexcoord.y * resolution.g), 2.0) == 0.0) {
        discard;
    }
    
    // Textura com o efeito CRT
    vec4 color = texture2D(gm_BaseTexture, uv);
    
    
    
    gl_FragColor = vec4(color.rgb, .2);
}
