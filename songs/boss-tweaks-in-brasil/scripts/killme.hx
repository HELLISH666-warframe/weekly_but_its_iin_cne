function postCreate(){
    iconP2.visible = false;
    dad.visible = false;
    boyfriend.flipX = !boyfriend.flipX;
 //   game.boyfriend.cameraPosition[0] = 400;
    FlxG.camera.follow(935, 590);
    boyfriend.cameraOffset[0] = 400;
    br = new FlxSprite().loadGraphic(Paths.image("stages/brasil"));
    br.antialiasing = true;
    br.screenCenter(); 
    br.cameras = [camHUD];
    br.alpha = 0.0001;
    add(br); 

    port = new FlxSprite().loadGraphic(Paths.image("stages/portugal"));
    port.antialiasing = true;
    port.setGraphicSize(1280, 720);
    port.screenCenter(); 
    port.cameras = [camHUD];
    port.alpha = 0.0001;
    add(port); 
    for (i in 0...playerStrums.members.length){
		playerStrums.members[i].x -= 325;
	}

	for(i in 0...cpuStrums.members.length){
		cpuStrums.members[i].x -= 9999999999;
	}
}
function beatHit() {
    switch(curBeat) {
 //       case 191:
   //     isCameraOnForcedPos = false;
        case 192:
        iconP2.visible = true;
        dad.visible = true;
    }
}
function flag1()
{
    br.alpha = 1;
    FlxTween.tween(br, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});
}
function flag2()
{
    port.alpha = 1;
    FlxTween.tween(port, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});	
}