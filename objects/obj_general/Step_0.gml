if (keyboard_check(vk_alt)) {
    if (keyboard_check_pressed(ord("D"))) {
        global.debug = !global.debug;
    }
}