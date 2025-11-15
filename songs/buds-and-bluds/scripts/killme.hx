// I'm so exhausted man
import hxvlc.flixel.FlxVideoSprite;
var bfZoom:Float = 0.6;
var bossZoom:Float = 0.5;

var camZoomOveride:Bool = false;

var mosaic:CustomShader = new CustomShader("mosaic");
var mosaicStrength:Float = 1;

var bossTweak:Float = 0;
var bfTweak:Float = 0;
var iconCanTweak:Bool = true;
var isSpinning:Bool = false;

introLength = 0;
function onCountdown(event) event.cancel();
var emotional;
var intro;
var blackHUD:FlxSprite;
var titlecard:FlxSprite;
var whiteHUD:FlxSprite;
function create() {
    songLength=199000;
}
function destroy() {
    Options.camZoomOnBeat=true;
}
function postCreate(){
    Options.camZoomOnBeat=true;
    blackHUD = new FlxSprite(0, 0).makeGraphic(FlxG.width * 1.2, FlxG.height * 1.2, FlxColor.BLACK); // UGHHHHHHH
    blackHUD.cameras = [camHUD];
    insert(0, blackHUD);
    add(blackHUD);

    whiteHUD = new FlxSprite(0, 0).makeGraphic(FlxG.width * 1.2, FlxG.height * 1.2, FlxColor.WHITE); // UGHHHHHHH
    whiteHUD.alpha = 0;
    whiteHUD.cameras = [camHUD];
    add(whiteHUD);

    titlecard = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/bud/introcard')); // UGHHHHHHH
    titlecard.screenCenter();
    titlecard.cameras = [camHUD];
    titlecard.alpha = 0;
    add(titlecard);

    heythere = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/bud/Hey there'));
    heythere.scale.set(0.15, 0.15);
    heythere.cameras = [camHUD];
    heythere.screenCenter();
    heythere.alpha = 0.001;
    add(heythere);

    add(emotional = new FlxVideoSprite()).load(Paths.video("notsillybilly"));
    emotional.camera = camHUD;
    add(emotional);

    intro = new FlxVideoSprite().load(Assets.getPath(Paths.video('BudsIntro'))); 
    add(intro = new FlxVideoSprite()).load(Paths.video("BudsIntro"));
    intro.antialiasing = true;
    intro.camera = camHUD;
    add(intro);

    intro.bitmap.onEndReached.add(function() {
        intro.kill();
        camGame.alpha = 1;
        camGame.flash(0xFFFFFFFF, 1.0);
        for(s in budAndBludsShitVar){ s.visible = true; }
         blackHUD.alpha = 0;
    });
}
function onSongStart() {
    intro.play();
}

function onCameraMove(e)
    strumLines.members[curCameraTarget].characters[0].isPlayer == true ? defaultCamZoom = bfZoom : defaultCamZoom = bossZoom;
function update(elapsed:Float) {
    if (isSpinning) iconP2.angle += elapsed * (60 / Conductor.bpm) * 12000;
}
function beatHit() {
    // i love you tweaking icons
    if (iconCanTweak) {
        var degreeMult:Float = ((curBeat % 2) * 2) - 1;

        for(i in [iconP1,iconP2])FlxTween.cancelTweensOf(i,['angle']);
        FlxTween.angle(iconP1, bfTweak * degreeMult, 0, 60 / Conductor.bpm, {ease: FlxEase.sineOut});
        FlxTween.angle(iconP2, bossTweak * degreeMult, 0, 60 / Conductor.bpm, {ease: FlxEase.sineOut});
    }
}
function stepHit(curStep) {
    switch (curStep) {
        case 1407:
            FlxG.camera.addShader(mosaic);camHUD.addShader(mosaic);
            FlxTween.num(1, 25, 1.5, {ease: FlxEase.linear, onUpdate: function(strength:FlxTween){
                mosaic.data.uBlocksize.value = [strength.value, strength.value];
            }});
        case 1423:
            FlxG.camera.removeShader(mosaic);camHUD.removeShader(mosaic);
            for(s in budAndBludsShitVar){ s.alpha = 0; }
        //  ExUtils.addShader(rainShader, game.camGame);
    }
}

function onSubstateOpen() {
if (intro != null && paused) intro.pause();
if (emotional != null && paused) emotional.pause();}
function onSubstateClose(){
 if (intro != null && paused) intro.resume();
if (emotional != null && paused) emotional.resume();}

function setIconTweak(icon1:String,icon2:String){
    bossTweak = Std.parseFloat(icon1);
    bfTweak = Std.parseFloat(icon2);
}

function norbert_Video(){  
    camZooming=false;
    emotional.antialiasing = true;
    emotional.camera = camHUD;
    vocals.volume = 0;
    inst.volume = 0;
    emotional.play([FlxVideoSprite.MUTED]);
    emotional.bitmap.onEndReached.add(function() {
        camGame.flash(0xFFFFFFFF, 1.0);
        blackHUD.alpha = 0;
        emotional.kill();
        boyfriend.cameraOffset[0] = -200;
        boyfriend.cameraOffset[1] = -210;
        dad.cameraOffset[0] = 100;
        dad.cameraOffset[1] = -185;
        videoString = 'OOGITYGOOGAMEOVER';
        Options.camZoomOnBeat = true;
        FlxTween.tween(titlecard, {alpha: 1}, 0.5);
        songLength = FlxG.sound.music.length;
        new FlxTimer().start(1.25, function(tmr:FlxTimer) {
            FlxTween.tween(titlecard, {alpha: 0}, 0.5);
        });
    });
}
function tenseSection(ok:Bool){
    if(ok){
        blackStage.visible = true;
        rightpile.alpha = 0;
        leftpile.alpha = 0;
    }else{
        blackStage.visible = false;
        rightpile.alpha = 1;
        leftpile.alpha = 1;
    }

}

function cutToBlack(){
    for(s in budAndBludsShitVar){ s.alpha = 0; }
    blackHUD.alpha = 1;
    camGame.alpha = 0;
    //camGame.setFilters([]);
}

function fade(){
    FlxTween.tween(blackHUD, {alpha: 1}, 0.25);
}

function fadehud(){  
    for(s in budAndBludsShitVar){ FlxTween.tween(s, {alpha: 0}, 0.25, {ease: FlxEase.quadOut}); }
}
function fadeinhud(){  
    for(s in budAndBludsShitVar){ FlxTween.tween(s, {alpha: 1}, 0.25, {ease: FlxEase.quadOut}); }
}
function hudback(){  
    for(s in budAndBludsShitVar){ FlxTween.tween(s, {alpha: 1}, 1.5, {ease: FlxEase.quadOut}); }
}
function heyThere(){  
    FlxTween.tween(heythere, {alpha : 0.1}, (60 / Conductor.bpm) * 4, {onComplete: function(twn:FlxTween) {
        heythere.alpha = 0;
    }});
}
function cutIn(?flash){  
    for(s in budAndBludsShitVar){ s.alpha = 1; }
    blackHUD.alpha = 0;
    camGame.alpha = 1;
    //ExUtils.addShader(rainShader, game.camGame);
    if(flash)
        camGame.flash(0xFFFFFFFF, 1.0);
}
function fakeoutZoom(){  
    Options.camZoomOnBeat = false;
    FlxTween.tween(FlxG.camera, {zoom: 0.75}, 1.0, {ease: FlxEase.quadOut});
}

function spindash(){  
    iconCanTweak = false;
    FlxTween.angle(iconP2, 0, 360 * 4, (60 / Conductor.bpm) * 4, {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween) {isSpinning = true;}});
}

function end(){  
    //isCameraOnForcedPos = true;
    Options.camZoomOnBeat = false;
    //FlxTween.tween(game.camFollow, {x: 710, y: -200}, 1.0, {ease: FlxEase.smootherStepInOut});
    FlxTween.tween(whiteHUD, {alpha: 1}, 0.75, {ease: FlxEase.linear});
    FlxTween.tween(FlxG.camera, {zoom: 0.45}, 1.0, {ease: FlxEase.smootherStepInOut});
}