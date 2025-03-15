
// Mov:
velh = 0;
velv = 0;
accelPadrao = .2
desaccelPadrao = .1
accel = accelPadrao;
desaccel = desaccelPadrao

velmax = 6;
// StateMach:
state = noone;
state_debug = "noone";

// Pspecs:
simpleEightDirs = function() {
    if (_left) {
        image_xscale = -1
        image_angle = 0;
    }
    if (_right) {
        image_xscale = 1
        image_angle = 0;
    }
    if (_down) {
        image_xscale = 1
        image_angle = 270;
    }
    if (_up) {
        image_xscale = 1
        image_angle = 90;
    }
    
    if (_left && _up) {
        image_xscale = -1;
        image_angle = 315;
    }
    if (_left && _down) {
        image_xscale = -1;
        image_angle = 45;
    }
    if (_right && _up) {
        image_xscale = 1;
        image_angle = 45;
    }
    if (_right && _down) {
        image_xscale = 1;
        image_angle = 315; 
    }
}

movimentacao = function() {
    // Inputs:
    _left = keyboard_check(ord("A"));
    _right = keyboard_check(ord("D"));
    _down = keyboard_check(ord("S"));
    _up = keyboard_check(ord("W"));
    
    var _dir = point_direction(0, 0, (_right - _left), (_down - _up))
    
    // MovScript:
    if ((_left xor _right) or (_up xor _down)) {
        var _vel = lerp(point_distance(0, 0, velh, velv), velmax, accel); 
        velh = lengthdir_x(_vel, _dir);
        velv = lengthdir_y(_vel, _dir);
    }
    
    else {
        velh = lerp(velh, 0, desaccel);
        velv = lerp(velv, 0, desaccel);
    }
    
    // ImgAngle:
    simpleEightDirs()
    
}

// States:
state_parado = function() {
    state_debug = "Parado";
    
    image_speed = 0;
    image_index = 0;
    
    // CanSpecs:
    movimentacao()
    
    // ExitCond:
    if (abs(velh) > 0 || abs(velv) > 0) state = state_andando;
        
    // GunState:
    if (keyboard_check_pressed(vk_shift)){
        global.gunstate = !global.gunstate
    }
    if (global.gunstate) {
        sprite_index = spr_carroequipado;
    }
    else {
        sprite_index = spr_carrosemnada;
    }
};

state_andando = function() {
    state_debug = "Andando";
    
    image_speed = 1;
    
    
    // CanSpecs:
    movimentacao();
    
    // ExitCond:
    
    if (velh == 0 && velv == 0) state = state_parado;
        
    // GunState:
    if (keyboard_check_pressed(vk_shift)){
        global.gunstate = !global.gunstate
    }
    if (global.gunstate) {
        sprite_index = spr_carroequipado;
    }
    else {
        sprite_index = spr_carrosemnada;
    }
};
state = state_parado;