a = instance_create_layer(0,0, "UI", obj_cursor)
time = 0;

desenha_ui = function() {
	// Root V
	time+=.5
	var _tela_w = display_get_gui_width();
	var _tela_h = display_get_gui_height();
	var _mult_factor = 4;
	
	// Comb V
	
	var _meio_w = _tela_w / 2;
	var _meio_h = _tela_h / 2;
	
	
	var _marg_portrait_x = 20;
	var _marg_portrait_y = 16;
	var _portrait_y = 0 + _marg_portrait_y;
	var _portrait_x = 0 + _marg_portrait_x;
	
	var _marg_healthbar_x = sprite_get_width(spr_portrait) * _mult_factor
	var _marg_healthbar_y = 32
	var _healthbar_x = _portrait_x * _mult_factor + _marg_healthbar_x;
	var _healthbar_y = 0 + _marg_healthbar_y;
	
	var _pwrbar_y =  _healthbar_y + sprite_get_height(spr_player_health) * _mult_factor;
	// Draws (plr & portraitbg):
	
	draw_sprite_ext(spr_player_bg, 0, _portrait_x, _portrait_y, image_xscale * _mult_factor, image_yscale * _mult_factor, 0, c_white, 1.0);
	draw_sprite_ext(spr_portrait, 0, _portrait_x , _portrait_y , image_xscale * _mult_factor, image_yscale * _mult_factor, 0, c_white, 1.0);
	
	// Draws (health)
    scribble_anim_wave(2, .1, .1)
	var _sc = scribble("[wave][c_red][wheel]HP");
    _sc.draw(_healthbar_x - 16, _healthbar_y-2)
    _sc.starting_format("fnt_simple", c_white)
    
    scribble_anim_wave(2, .1, .1)
    var _sc = scribble("[wave][c_blue][wheel]PWR");
    _sc.draw(_healthbar_x - 24, _pwrbar_y)
    _sc.starting_format("fnt_simple", c_white)
    
    
    
	draw_sprite_ext(spr_player_health, obj_carro.vida, _healthbar_x + 24, _healthbar_y, image_xscale * _mult_factor, image_yscale * _mult_factor, 0, c_white, 1.0)
    
    
	draw_sprite_ext(spr_player_pwr, obj_carro.pwr, _healthbar_x + 24,_pwrbar_y, image_xscale * _mult_factor, image_yscale * _mult_factor, 0, c_white, 1.0)
    
    var _nea = instance_nearest(obj_carro.x, obj_carro.y, obj_agiota);
    
    if (global.gunstate && instance_exists(obj_agiota)) {
        
        a.x = lerp(a.x, _nea.x, .5);
        a.y = lerp(a.y, _nea.y, .5)
        
        a.image_angle = sin(time * 75) * 10
        a.image_alpha = lerp(a.image_alpha, 1, .5)
    }
    else {
        a.x = lerp(a.x, obj_carro.x, .5);
        a.y = lerp(a.y, obj_carro.y, .5)
        
        a.image_alpha = lerp(a.image_alpha, 0, .1)
    }
    
    
}