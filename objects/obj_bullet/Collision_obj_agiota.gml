if (!obj_carro.super) {
    other.vida -= obj_carro.dano;
    audio_play_sound(snd_hurt, 1, false);
}else {
    other.vida -= other.vida;
}
instance_destroy(self)

