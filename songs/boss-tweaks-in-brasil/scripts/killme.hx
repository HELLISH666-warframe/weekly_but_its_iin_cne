var br:FlxSprite;
var port:FlxSprite;
function postCreate(){
    br = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/brasil"));
    br.antialiasing = true;
    br.screenCenter(); 
    br.camera = camHUD;
    br.alpha = 0.000001;
	add(br); 

    port = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/portugal"));
    port.antialiasing = true;
    port.setGraphicSize(1280, 720);
    port.screenCenter(); 
    port.camera = camHUD;
    port.alpha = 0.000001;
	add(port); 

    iconP2.visible = false;
    dad.visible = false;
 //   game.boyfriend.cameraPosition[0] = 400;
    FlxG.camera.follow(935, 590);
    boyfriend.cameraOffset[0] = 400;
}
function beatHit(curBeat:Int)
    switch(curBeat) {
        //case 191: isCameraOnForcedPos = false;
        case 192: iconP2.visible = dad.visible = true;
    }
function flag(flag:String){
    switch(flag){
        case "brasil": br.alpha = 1; FlxTween.tween(br, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});	
        default: port.alpha = 1; FlxTween.tween(port, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});	
    }
}