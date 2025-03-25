
ite = 0
// Variável para controlar se todos os pontos de spawn foram usados
allPointsUsed = false;
for (var i = 0; i < instance_number(obj_canspawnpwr); i++) {
    canspawn[i] = instance_find(obj_canspawnpwr, i);
}

audio_play_sound(snd_bg, 1, true);

randomPwr = function() {
    randomize();
    willspawn = irandom(100);  // Determina a probabilidade de spawn
    
    // Se for gerado um power-up
    if (willspawn == 10 && array_length(canspawn) > 0 && !allPointsUsed) {
        // Escolhe aleatoriamente um ponto de spawn
        ite = irandom_range(0, array_length(canspawn) - 1);
        
        // Escolhe aleatoriamente um power-up da lista
        var selecionado = irandom(array_length(global.powerups) - 1);
        
        
        var conc = global.powerups[selecionado];  // Obtém o power-up escolhido
        
        // Cria o power-up na posição escolhida
        var pwr = new createPowerUp(canspawn[ite].x, canspawn[ite].y, conc.sprite, conc.effect);
        
        // Remove a posição de spawn da lista canspawn para que não apareça novamente
        array_delete(canspawn, ite, 1);
        
        // Verifica se todos os pontos de spawn foram usados
        if (array_length(canspawn) == 0) {
            allPointsUsed = true;  // Marca que todos os pontos de spawn foram usados
            
        }
    }
}

