var coolSection:Bool = false;
function postCreate() {
    healthBar.flipX= iconP1.flipX = iconP2.flipX = true;
    camZooming = true;
    stage.getSprite("thelight").blend = 8;
    stage.getSprite("thedark").blend = 9;
}

function beatHit(curBeat:Int) {
    if (camZooming && Options.camZoomOnBeat && coolSection) {
        FlxG.camera.zoom += 0.015 * camZoomingStrength;
        camHUD.zoom += 0.03 * camZoomingStrength;
    }
}

function stepHit(curStep:Int) {
    switch(curStep){
        case 1727|1791:coolSection=!coolSection;
    }
}

function postUpdate(elapsed){	
	var center:Float = healthBar.x + healthBar.width * FlxMath.remapToRange(healthBar.percent, 100, 0, 1, 0);

	iconP1.x = center - (iconP1.width - 26);
	iconP2.x = center - 26;
}

/*function onEvent(eventName, value1, value2) 
    if(eventName == 'Middle') switch(value1) {
            case 'on': camFollow.set(1900, 1200);
            isCameraOnForcedPos = true;
            case 'off':isCameraOnForcedPos = false;
        }
*/
function onGameOverStart() setGameOverVideo("peppino");