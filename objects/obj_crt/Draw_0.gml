// Defina a resolução da tela
var res_width = display_get_width();
var res_height = display_get_height();

// Crie uma superfície para capturar o conteúdo da tela
var surface = surface_create(res_width, res_height);
surface_set_target(surface);

// Desenhe o conteúdo da tela (tudo o que você quiser)
draw_clear(c_white); // Limpa a tela com uma cor (ou desenha o conteúdo normalmente)

// Retorne para o alvo normal
surface_reset_target();

// Defina o shader CRT
shader_set(shd_crt);
var ss = shader_get_uniform(shd_crt, "resolution")
// Passe a uniform 'resolution' para o shader
shader_set_uniform_f(ss, res_width, res_height);

// Desenhe a superfície (agora com o conteúdo da tela) com o shader
draw_surface(surface, 0, 0);

// Desligue o shader após o desenho
shader_reset();

// Libere a superfície (opcional, mas recomendado)
surface_free(surface);