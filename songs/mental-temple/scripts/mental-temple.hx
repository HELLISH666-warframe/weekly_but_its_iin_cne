/*function postCreate(){
    boyfriend.cameraOffset[0] = 650;
    dad.cameraOffset.x= 2443;
}*/
function postUpdate(elapsed:Float) {
    trace(camFollow.y);
}


/*function onEvent(eventName, value1, value2){
    if(eventName == 'EnaEvents'){
        switch(value1){
            case 'duet':
            game.isCameraOnForcedPos = true;
            FlxTween.tween(camFollow, {x: 650}, 0.5, {ease: FlxEase.smootherStepInOut});
            case 'duet off':
            game.isCameraOnForcedPos = false;   
        }
    }
}*/

function onGameOverStart() setGameOverVideo("ena_gameover");