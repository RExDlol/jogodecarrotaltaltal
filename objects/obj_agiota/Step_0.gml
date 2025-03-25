
mp_grid_add_instances(grid, obj_desaccelarea, false);
mp_grid_add_instances(grid, obj_col, false);
mp_grid_add_instances(grid, obj_wpwalk, false);

fire_system();

if (!mp_grid_path(grid, path, x, y, obj_carro.x, obj_carro.y, true)) {
    
    mp_grid_clear_all(grid);
    mp_grid_add_instances(grid, obj_col, false); 
    mp_grid_path(grid, path, x, y, obj_carro.x, obj_carro.y, true);
}

if (path_position < 1 && !death) {
    var next_x = path_get_x(path, path_position + 0.1);
    var next_y = path_get_y(path, path_position + 0.1);
    
    
    var dir = point_direction(x, y, next_x, next_y);
    
    
    image_angle = round(dir / 45) * 45;
}


path_start(path, vel, path_action_stop, false);

if (vida <= 0) {
    vel -= .1;
    if(!audio_is_playing(snd_explosion) && !death) {
        audio_play_sound(snd_explosion, 1, false);
    }
    death = true;
    if (!instance_exists(obj_explosion)) {
        instance_create_layer(x, y, "UI", obj_explosion);
    }
    // Inicia o alarme para rotacionar
    if (alarm[0] == -1) { 
        alarm[0] = 4;
    }
    
    
    
    if (vel <= 0) {
        instance_create_layer(x, y, "UI", obj_explosion);
        instance_destroy(self);
    }
}

if (obj_carro.death) {
    vel = lerp(vel, 0, 0.05);
}

