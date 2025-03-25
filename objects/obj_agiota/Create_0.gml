vida = 6;

dano = .1

fireTimerDef = 60;
fireTimer = fireTimerDef;

grid = mp_grid_create(0, 0, room_width div 32, room_height div 32, 32, 32);
mp_grid_add_instances(grid, obj_col, false);

path = path_add();
randomize()
velPadrao = random_range(5.5, 4)
vel = velPadrao

death = false;
deathFramesRot = 2;

fire_system = function() {
    randomize()
    var enemy = obj_carro;
    var distanceToEnemy = point_distance(x, y, obj_carro.x, obj_carro.y)
    var maxDistance = 300;
    if (distanceToEnemy <= maxDistance && instance_exists(obj_carro) && !obj_carro.death && !death) {
        fireTimer--;
        vel = velPadrao;
        var _xOffset = random_range(-30, 30)
        var _yOffset = random_range(-30, 30)
        
        if (fireTimer <= 0) {
            
            var _dir = point_direction(x, y, enemy.x, enemy.y)
            
            var _b = instance_create_layer(x, y, "Player", obj_e_bullet)
            _b.speed = 40;
            if (_dir >= 125 && _dir <= 225) _b.direction = 180;
                        
            if (_dir >= 315 && _dir <= 45) _b.direction = 0;
            
            if (_dir >= 45 && _dir <= 125) _b.direction = 90;
            
            if (_dir >= 225 && _dir <= 315) _b.direction = 270;
            _b.image_angle = _b.direction;
            
            fireTimer = fireTimerDef;
        }
    }
    if (distanceToEnemy >= maxDistance && !death) {
        vel = random_range(8, 8);
    }
}