



function anim_death(_entidade, _velVar, _vel) {
    
    if (_entidade._velVar > 0) {
        
        _entidade._velVar -= _vel;
    }
    else {
        instance_create_layer(_entidade.x, _entidade.y, "UI", obj_explosion)
        instance_destroy(_entidade);
    }
    
}