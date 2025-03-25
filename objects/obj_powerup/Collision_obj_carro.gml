if (is_callable(customfunc)){ 
    customfunc();
    audio_play_sound(snd_pwrup, 1, false)
    instance_destroy(self);
}