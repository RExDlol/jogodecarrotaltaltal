
var window_width = display_get_width();
var window_height = display_get_height();


var window_aspect = window_width / window_height;


var target_aspect = 4 / 3;


var app_width, app_height;


if (window_aspect > target_aspect) {
    
    app_height = window_height;
    app_width = app_height * target_aspect;
} else {
    
    app_width = window_width;
    app_height = app_width / target_aspect;
}

surface_resize(application_surface, app_width, app_height);

var x_offset = (window_width - app_width) / 2;
var y_offset = (window_height - app_height) / 2;

draw_surface(application_surface, x_offset, y_offset);

if (x_offset > 0) {
    
    // Esquerda
    draw_rectangle(0, 0, x_offset, window_height, true);
    draw_rectangle(x_offset + app_width, 0, window_width, window_height, true); // Direita
} else if (y_offset > 0) {
    
    // Topo
    draw_rectangle(0, 0, window_width, y_offset, true);
    draw_rectangle(0, y_offset + app_height, window_width, window_height, true); // Base
}
