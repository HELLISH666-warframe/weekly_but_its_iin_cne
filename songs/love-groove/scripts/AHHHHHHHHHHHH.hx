import openfl.filters.ShaderFilter;
import modchart.Manager;
import modchart.Config;

var unHud;

var threedeez = new CustomShader("tweak5/3D");
var para = new CustomShader("tweak5/paranoia");

var canMoveX:Bool = false;
var canMoveY:Bool = false;
var canUpdate:Bool = false;
var move:Float = 0;
var moveMult:Float = 0.5;

var canLerp:Bool = false;
var splitLerp:Float = 1;

function postCreate() {
    var funk = new Manager();
    add(funk);
    funk.addModifier("confusion", -1);
    funk.ease("confusion", 120/4, 0.7,120*4, FlxEase.quadOut, -1);
    unHud = [healthBarBG, healthBar, iconP1, iconP2, timeBar, timeBarBG, timeTxt];
    var newWidth:Float = 960;
    var newHeight:Float = 720; 
    var scaledHeight:Float = 720;

    for(camera in [camHUD,camOther,camGame]){
        camera.width = 1280;
        if(newHeight <= 720){
            camera.height = 720 * (1280 / newHeight);
            scaledHeight = camera.height;
        }
    }

    FlxG.resizeWindow(newWidth, newHeight);
    if(newHeight == newWidth) FlxG.scaleMode.height = FlxG.scaleMode.width;
    else FlxG.scaleMode.height = 960;

    para.data.splitCount.value = [1];
    threedeez.data.xrot.value = [0];
    threedeez.data.yrot.value = [0];
    threedeez.data.zrot.value = [0];

    var filter:ShaderFilter = new ShaderFilter(threedeez);
    var filter2:ShaderFilter = new ShaderFilter(para);
    camHUD.setFilters([filter, filter2]);
    camGame.setFilters([filter]);

    for (i in stage.stageSprites) remove(i);
    remove(dad);
    remove(gf);
    remove(boyfriend);
    for(i in unHud) remove(i);

    scoreTxt.scale.set(3,3);
    scoreTxt.updateHitbox();
    scoreTxt.screenCenter();
    scoreTxt.alpha = 0;
    defaultCamZoom = 1;
    //comboPrefix = 'notitg/';

    bg = new FlxSprite().loadGraphic(Paths.image("stages/tweak5/LOVE_GROOVE_FINAL_BACKGROUND"));
    bg.scrollFactor.set();
    bg.scale.set(1.5, 1.5);
    bg.updateHitbox();
    bg.screenCenter();
    bg.y -= 12.5;
    add(bg).alpha = 0;
    //loadModchart();
}

function onSongStart(){
    FlxTween.tween(bg, {alpha: 0.25}, (Conductor.stepCrotchet / 1000) * 16, { ease: FlxEase.quadOut});
}

var fartbutt:Float = 0;
function update(elapsed:Float) {
    camZooming = false;

    if(canUpdate) move += (elapsed * moveMult);
    if(canMoveX) para.data.x.value = [move];
    if(canMoveY) para.data.y.value = [move];

    if(canLerp){
        fartbutt = FlxMath.lerp(para.data.splitCount.value[0], splitLerp, FlxMath.bound(elapsed * 2.4, 0, 1));
        para.data.splitCount.value = [fartbutt];    
    }
}

function destroy() {
    if(!window.fullscreen) FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.height = 720;
}




function stepHit(curStep:Int) {
    switch(curStep) {
        case 512:
            FlxTween.num(1, 4, (Conductor.stepCrotchet / 1000) * 14, {ease: FlxEase.quadInOut, onUpdate: (twn:FlxTween)->{
            para.data.splitCount.value = [twn.value];
        }});
        case 528: para.data.splitCount.value = [1];
        case 536: para.data.splitCount.value = [2];
        case 544: para.data.splitCount.value = [1];
        case 552: para.data.splitCount.value = [2];
    }
}





function numericForInterval(start, end, interval, func){
    var index = start;
    while(index < end){
        func(index);
        index += interval;
    }
}
