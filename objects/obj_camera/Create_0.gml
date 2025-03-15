segue_nada = function() {
    alvo = noone;
}

segue_alvo = function(){
        
    //Pegando o tamanho da camera
    var _view_w = camera_get_view_width(view_camera[0])
    var _view_h = camera_get_view_height(view_camera[0])
    
    //Pegando o x e y da camera (Com esses dois a camera fica no meio)
    var _cam_x	= x - _view_w/2
    var _cam_y	= y - _view_h/2 
    
    //Impedindo que a camera mostre fora da room ("Clamp") [Opcional]
    _cam_x = clamp(_cam_x,0,room_width - _view_h) //Veja a aula para entender mais
    _cam_y = clamp(_cam_y,0,room_height - _view_w) //Veja a aula para entender mais
    
    //Definindo a posição da camera (antes, tira que a opção de seguir a camera no inspetor)
    //Voltando metade da camera pois o x e o y da camera é o 0,0 da room (top left)
    camera_set_view_pos(view_camera[0], _cam_x , _cam_y) //[*Obrigatório]
    
    
    
    
    //Fazendo a camera seguir de fato o alvo
    x = lerp(x,alvo.x,0.1)
    y = lerp(y,alvo.y,0.1)
}

//Seguindo o player
segue_player = function(){
    //Checando se o player existe
    if instance_exists(obj_carro){
        alvo = obj_carro;
    }else{
        estado = segue_nada
    }
    
    segue_alvo()
    
    

}
