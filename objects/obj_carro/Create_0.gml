
// Mov:
velh = 0;
velv = 0;
accelPadrao = .05
desaccelPadrao = .1
accel = accelPadrao;
desaccel = desaccelPadrao

// Fire
defaultFireTimer = 20;
fireTimer = defaultFireTimer;
_fls_timer = 10;
_fls = _fls_timer;
velmax = 6;
// StateMach:
state = noone;
state_debug = "noone";

// Pspecs:
// Range: 0-5
vida_padrao = 5;
vida = vida_padrao
pwr = 0

// Modifiers:
inv = false;
firerapido = false;
rapido = false;
super = false

dano = 1;

death = false;


// Timers:
invT = 60
firerapidoT = 60
rapidoT = 60
superT = 60
flash = function(enable, color1, color2) {
    
    if (!enable) { 
        image_blend = c_white
        exit
        
    };
    static _color = color1
    
    _fls--;
    image_blend = _color;
    if (_fls <= 0){
        if (_color == color1) {
            _color = color2
            
            _fls = _fls_timer;
        }
        else {
            _color = color1
            
            _fls = _fls_timer;
        }
    }
    show_debug_message(_fls)
}

canFire = function() {
    // Timer System:
    if (firerapido) {
        defaultFireTimer = 10;
        alarm[4] = 60
    }
    
    
    if (inv) {
        flash(1,c_orange, c_aqua)
        invT--
        
        if (invT <= 0) {
            
            inv = false;
            flash(1, c_white, c_white)
            invT = 60;
        }
    }
    
    if (rapido) {
        flash(1,c_red, c_aqua)
        
        if (rapidoT <= 0) {
                    
            rapido = false;
            flash(1, c_white, c_white)
            rapidoT = 60;
        }
    }
    
    if (super) {
        flash(1,c_blue, c_aqua)
        
        if (superT <= 0) {
                    
            super = false;
            flash(1, c_white, c_white)
            superT = 60;
        }
    }
    
    
    if (mouse_check_button(mb_left) && global.gunstate){
        fireTimer--;
    }
    
    if (instance_exists(obj_agiota)) {
        var enemy = instance_nearest(x, y, obj_agiota);
        var distanceToEnemy = point_distance(x, y, enemy.x, enemy.y);
        var maxDistance = 300;
        
            
        if (fireTimer <= 0 && instance_exists(enemy) && distanceToEnemy <= maxDistance) {
            var _dir = point_direction(x, y, enemy.x, enemy.y)
            
            
            var _fb = instance_create_layer(x , y , "Player", obj_bullet);
            _fb.speed = 50;
            if (_dir >= 125 && _dir <= 225) _fb.direction = 180;
            
            if (_dir >= 315 && _dir <= 45) _fb.direction = 0;
            
            if (_dir >= 45 && _dir <= 125) _fb.direction = 90;
            
            if (_dir >= 225 && _dir <= 315) _fb.direction = 270;
            audio_play_sound(snd_shoot, 1, false)
            _fb.image_angle = _fb.direction;
            
            fireTimer = defaultFireTimer;
        }
    }
    
    
}

death_system = function() {
    if (vida <= 0) {
        state = state_morrendo;
    }
}

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

movimentacao = function(_canFire) {
    if (_canFire) canFire();
    
    if (rapido) {
        velmax = 10;
    }
    else {
        velmax = 6;
    }
    
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
    
    death_system();
    
    image_speed = 0;
    image_index = 0;
    
    // CanSpecs:
    movimentacao(true)
    
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
    
    death_system();
    // CanSpecs:
    movimentacao(true);
    
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

state_morrendo = function () {
    state_debug = "Morrendo";
    
    
    
    velh = lerp(velh, 0, .1);
    velv = lerp(velv, 0, .1);
    death = true;
    if (!instance_exists(obj_explosion)) {
        instance_create_layer(x, y, "UI", obj_explosion);
    }
    // Inicia o alarme para rotacionar
    if (alarm[0] == -1) { 
        alarm[0] = 4;
    }

    if (abs(velh) <= 0 && abs(velv) <= 0 && !instance_exists(obj_explosion  )) {
        instance_create_layer(x, y, "UI", obj_explosion);
        
    }
    
    
    
}
state = state_parado;