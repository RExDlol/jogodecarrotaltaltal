// Col:

if (place_meeting(x + velh, y, obj_col)) {
    
    var _vs = sign(velh);
    
    while(!place_meeting(x + _vs, y, obj_col)) {
        velh += _vs;
        break;
    }
    
    velh = 0;
}
x += velh;
if (place_meeting(x, y + velv, obj_col)) {
    
    var _vs = sign(velv);
    
    while(!place_meeting(x, y + _vs, obj_col)) {
        velv += _vs;
        break;
    }
    
    velv = 0;
}
y += velv;

// DesaccelArea:

if (place_meeting(x, y, obj_desaccelarea)) {
    velmax = 2;
    accel = 0.05;
    desaccel = 0.05;
}
else {
    velmax = 6;
    accel = accelPadrao;
    desaccel = desaccelPadrao;
}