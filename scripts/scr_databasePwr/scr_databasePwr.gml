///@func createPowerUp(sprite, customfunc)
///@param {Real} x A cordenada X do powerUp
///@param {Real} y A cordenada y do powerUp
///@param {Asset.GMSprite} sprite A sprite a ser usada no PowerUp
///@param {Function} customfunc A função do powerup

function createPowerUp(_x , _y, sprite, customfunc) constructor {
    var pwr = instance_create_layer(_x, _y, "Player", obj_powerup);
    
    pwr.sprite_index = sprite;
    pwr.customfunc = customfunc;
    
    return pwr;
}
global.powerups = [
    {
        name: "Invencível",
        sprite: spr_pwrinvencivel,
        effect: function() {
            obj_carro.inv = true;
            obj_carro.super = true;
        }
    },
    {
        name: "Vida + tiro",
        sprite: spr_pwrvida,
        effect: function() {
            if (obj_carro.vida <= 3) {
                obj_carro.vida += 2
            }
            
            obj_carro.firerapido = true;
            obj_carro.super = true;
        }
    },
    {
        name: "Inv + boost + tiro",
        sprite: spr_pwrlongo,
        effect: function() {
            obj_carro.inv = true
            obj_carro.firerapido = true;
            obj_carro.rapido = true;
        }
    }
];