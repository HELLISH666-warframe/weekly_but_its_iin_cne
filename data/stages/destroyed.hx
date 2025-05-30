// I'm so exhausted man
import hxvlc.flixel.FlxVideoSprite;
var rainIntensity:Float = 0.2;
var rainShader; // ty base game
var rainTime:Float = 0;
var realSongLength:Float = 0;
var uScreenResolution:Array<Float> = [FlxG.width, FlxG.height];
var uCameraBounds:Array<Float> = [camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height];
public var defaultCamZoomAdd:Float = 0;
public var camZooming:Bool = false;
public var camZoomingDecay:Float = 1;

public var defaultHudZoom:Float = 1;
var rainShader:CustomShader  = new CustomShader("rain");

//var mosaic = newShader("mosaic");
//var mosaicStrength:Float = 1;

var time:Float = 0;

var camCanZoom:Bool = true;
var camZoomOveride:Bool = false;

var shit = null; //array of stuff from da HUD

var intro:PsychVideoSprite;
var emotional:FlxVideoSprite;

var leftpile:FlxSprite;
var rightpile:FlxSprite;
var blackHUD:FlxSprite;
var whiteHUD:FlxSprite;
var titlecard:FlxSprite;

var bossTweak:Float = 0;
var bfTweak:Float = 0;
var iconCanTweak:Bool = true;
var isSpinning:Bool = false;

var videoString:String = 'bnb_gameover';

var lyrics:FlxText;

function postCreate(){

    var sky:FlxSprite = new FlxSprite(-491, -800).loadGraphic(Paths.image('stages/bud/sky'));
    sky.antialiasing = true;
    sky.scrollFactor.set(0.5, 0.5);
    insert(1, sky);
    add(sky);

    var city:FlxSprite = new FlxSprite(-575, -772).loadGraphic(Paths.image('stages/bud/city'));
    city.antialiasing = true;
    city.scrollFactor.set(0.6, 0.6);
    insert(2, city);
    add(city);

    var fire:FlxSprite = new FlxSprite(-1266, -375);
    fire.antialiasing = true;
    fire.scrollFactor.set(0.95, 0.95);
    fire.frames = Paths.getSparrowAtlas("stages/bud/fire");
    fire.animation.addByPrefix('idle', 'flicker0', 24, true);
    fire.animation.play("idle");
    insert(3, fire);
    add(fire);
    
    var mainbg:FlxSprite = new FlxSprite(-1214, -945).loadGraphic(Paths.image('stages/bud/mainbg'));
    mainbg.antialiasing = true;
    insert(4, mainbg);
    add(mainbg);

    leftpile = new FlxSprite(-1350, 126).loadGraphic(Paths.image('stages/bud/leftpile'));
    leftpile.antialiasing = true;
    leftpile.scrollFactor.set(1.1, 1.1);
    insert(5, leftpile);
    add(leftpile);

    rightpile = new FlxSprite(1574, 138).loadGraphic(Paths.image('stages/bud/rightpile'));
    rightpile.antialiasing = true;
    rightpile.scrollFactor.set(1.1, 1.1);
    insert(6, rightpile);
    add(rightpile);

    var addlayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/bud/add'));
    addlayer.antialiasing = true;
    addlayer.blend = 0;
    addlayer.alpha = 0.5;
    insert(7, addlayer);
    add(addlayer);

    var multiplylayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/bud/multiply'));
    multiplylayer.antialiasing = true;
    multiplylayer.blend = 9; // ??????????
    insert(8, multiplylayer);
    add(multiplylayer);

   blackStage = new FlxSprite(-1000, -750).makeGraphic(FlxG.width * 2.5, FlxG.height * 2.5, FlxColor.BLACK); // this is dumb and gay to have two of these but its ok
    blackStage.visible = false;
    blackStage.alpha = 0.5;
    add(blackStage);

    blackHUD = new FlxSprite(0, 0).makeGraphic(FlxG.width * 1.2, FlxG.height * 1.2, FlxColor.BLACK); // UGHHHHHHH
    blackHUD.cameras = [camHUD];
    insert(0, blackHUD);
    add(blackHUD);

    whiteHUD = new FlxSprite(0, 0).makeGraphic(FlxG.width * 1.2, FlxG.height * 1.2, FlxColor.WHITE); // UGHHHHHHH
    whiteHUD.alpha = 0;
    whiteHUD.cameras = [camHUD];
    add(whiteHUD);

    titlecard = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/bud/introcard')); // UGHHHHHHH
    //blackHUD.alpha = 0;
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
//    game.snapCamFollowToPos(710, 175);
    
    intro = new FlxVideoSprite().load(Assets.getPath(Paths.video('BudsIntro'))); 
    add(intro = new FlxVideoSprite()).load(Paths.video("BudsIntro"));
    intro.antialiasing = true;
    intro.cameras = [camHUD];

    shit = [scoreTxt, healthBarBG, healthBar, iconP1, iconP2, accuracyTxt, missesTxt];

/*    intro('onStart',{
        for(s in shit){ s.visible = false; }
//        modManager.setValue("alpha", 1);
  //      camGame.alpha = 0;
    });
    intro('onEnd',{
        intro.kill();
        game.camGame.alpha = 1;
        game.camGame.flash(0xFFFFFFFF, 1.0);
        for(s in shit){ s.visible = true; }
//        modManager.setValue("alpha", 0);
        blackHUD.alpha = 0;
    });
//    intro.load(Paths.video('BudsIntro'), [FlxVideoSprite.muted]);
  */  add(intro);

/*    emotional = new PsychVideoSprite();
    emotional.addCallback('onFormat',()->{
        emotional.cameras = [game.camHUD];
        emotional.setGraphicSize(FlxG.width);
        emotional.screenCenter();
    });
    emotional.load(Paths.video(ClientPrefs.flashing ? 'notsillybilly' : 'notsillybillyNONFLASHING'), [PsychVideoSprite.muted]);
    emotional.antialiasing = true;
    emotional.pauseOverride = true;
    add(emotional);*/

    lyrics = new FlxText(FlxG.height - 150, FlxColor.YELLOW, 'vcr.ttf', 28);
    lyrics.cameras = [camGame];
//    lyrics.lyricLoadCallback = function() {
  //      lyrics.screenCenter(FlxAxes.X);
    //}
    add(lyrics);
    rainShader.data.uScreenResolution.value = [uScreenResolution];
    rainShader.data.uScale.value = [FlxG.height / 300];
   // camGame.addShader(rainShader);

}
override function update(elapsed:Float)
{
    camFollow.x = 710;
    camFollow.y = 175;
    rainTime += elapsed;
    rainTime++; //My stupid way of making da rain faster
	rainShader.data.uCameraBounds.value = ([camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height]);
    rainShader.data.uTime.value = [rainTime];
    rainShader.data.uIntensity.value = [rainIntensity];
    

    camZooming = camCanZoom;

    if (isSpinning) {
        iconP2.angle += elapsed * (60 / SONG.meta.bpm) * 12000;
    }
    		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom + defaultCamZoomAdd, FlxG.camera.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay));
			camHUD.zoom = FlxMath.lerp(defaultHudZoom, camHUD.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay));
		}
}

function onSongStart()
{
//    realSongLength = PlayState.instance.songLength;
  //  PlayState.instance.songLength = 199000;
    intro.play();
   /* emotional.play(); // This is to prevent the video from desyncing from the song as much as possible
    emotional.pause();
    emotional.visible = false; // Justtt incase
    //trace(realSongLength);*/
}

function beatHit()
{
    // i love you tweaking icons
    if (iconCanTweak) {
        var degreeMult:Float = ((curBeat % 2) * 2) - 1;

        FlxTween.angle(iconP1, bfTweak * degreeMult, 0, 60 / curBeat, {ease: FlxEase.sineOut});
        FlxTween.angle(iconP2, bossTweak * degreeMult, 0, 60 / curBeat, {ease: FlxEase.sineOut});
    }
}

/*function onEvent(name, v1, v2) 
{
    switch (name)
    {
        case 'Bud Events':
            switch (v1) 
            {
                case 'fade hud':
                    for(s in shit){ FlxTween.tween(s, {alpha: 0}, 0.25, {ease: FlxEase.quadOut}); }
                    FlxTween.num(0, 1, 0.25, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
                        modManager.setValue("alpha", hudIn.value);
                    }, onComplete: ()->{ modManager.setValue("alpha", 1); }});
                case 'fade in hud':
                    for(s in shit){ FlxTween.tween(s, {alpha: 1}, 0.25, {ease: FlxEase.quadOut}); }
                    FlxTween.num(1, 0, 0.25, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
                        modManager.setValue("alpha", hudIn.value);
                    }, onComplete: ()->{ modManager.setValue("alpha", 0); }});
                case 'norbert video':
                    emotional.restart([PsychVideoSprite.muted]);
                    emotional.visible = true;
                    emotional.pauseOverride = false;
                    emotional.addCallback('onEnd',()->{
                        game.camGame.flash(0xFFFFFFFF, 1.0);
                        blackHUD.alpha = 0;
                        emotional.kill();
                        camCanZoom = true;
                        game.boyfriendCameraOffset[0] = -200;
                        game.boyfriendCameraOffset[1] = -210;
                        game.opponentCameraOffset[0] = 100;
                        game.opponentCameraOffset[1] = -185;
                        videoString = 'OOGITYGOOGAMEOVER';
                        FlxTween.tween(titlecard, {alpha: 1}, 0.5);
                        new FlxTimer().start(1.25, function(tmr:FlxTimer)
                        {
                            FlxTween.tween(titlecard, {alpha: 0}, 0.5);
                        });
                    });
                    game.camHUD.zoom = 1;
                    game.vocals.volume = 1;
                case 'real time':
                    //PlayState.instance.songLength = realSongLength;
                case 'hud back':
                    for(s in shit){ FlxTween.tween(s, {alpha: 1}, 1.5, {ease: FlxEase.quadOut}); }
                    FlxTween.num(1, 0, 1.5, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
                        modManager.setValue("alpha", hudIn.value);
                    }, onComplete: ()->{ modManager.setValue("alpha", 0); }});
                case 'cut to black':
                    for(s in shit){ s.alpha = 0; }
                    modManager.setValue("alpha", 1);
                    blackHUD.alpha = 1;
                    game.camGame.alpha = 0; // this because windowed fullscreen has a sinlgle pixel u can see and im not bothered to try to properly fix it fuck my baka life
                    camGame.setFilters([]);
                case 'cut in':
                    for(s in shit){ s.alpha = 1; }
                    modManager.setValue("alpha", 0);
                    blackHUD.alpha = 0;
                    game.camGame.alpha = 1;
//                    ExUtils.addShader(rainShader, game.camGame);
                    if(v2 == 'flash')
                    {
                        game.camGame.flash(0xFFFFFFFF, 1.0);
                    }
                case 'Camera Zoom Override':
                    switch(v2)
                    {
                        case 'on':
                            camZoomOveride = true;
                        case 'off':
                            camZoomOveride = false;
                    }
                case 'Tense Section':
                    switch(v2)
                    {
                        case 'on':
                            blackStage.visible = true;
                            rightpile.alpha = 0;
                            leftpile.alpha = 0;
                        case 'off':
                            blackStage.visible = false;
                            rightpile.alpha = 1;
                            leftpile.alpha = 1;
                    }
                case 'Set Exact Zoom': // Don't feel like hardcoding this even though I've meant to for weeks
                    var val2:Float = Std.parseFloat(v2);
                    game.defaultCamZoom = val2;
                    trace(val2);
                case 'Mosaic': //fuck my prostate burns
                    FlxTween.num(1, 25, 1.5, {ease: FlxEase.linear, onUpdate: function(strength:FlxTween){
                        mosaic.data.uBlocksize.value = [strength.value, strength.value];
                    }});
                case 'fakeout zoom':
                    camCanZoom = false;
                    FlxTween.tween(FlxG.camera, {zoom: 0.75}, 1.0, {ease: FlxEase.quadOut});
                case 'Clear Mosaic':
                    ExUtils.removeShader(mosaic, game.camGame);
                case 'camera offset': //FUCK THIS IS THE MOST GAY THING EVER be nice.
                    game.boyfriendCameraOffset[0] = -175;
                    game.boyfriendCameraOffset[1] = -100;
                    game.opponentCameraOffset[0] = 75;
                    game.opponentCameraOffset[1] = -75;
                case 'spin dash': // blame mocha
                    iconCanTweak = false;
                    FlxTween.angle(game.iconP2, 0, 360 * 4, (60 / curBpm) * 4, {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween) {
                        isSpinning = true;
                    }});
                case 'end':
                    game.isCameraOnForcedPos = true;
                    camCanZoom = false;
                    FlxTween.tween(game.camFollow, {x: 710, y: -200}, 1.0, {ease: FlxEase.smootherStepInOut});
                    FlxTween.tween(whiteHUD, {alpha: 1}, 0.75, {ease: FlxEase.linear});
                    FlxTween.tween(FlxG.camera, {zoom: 0.45}, 1.0, {ease: FlxEase.smootherStepInOut});
                case 'metadata':
                    trace('fuck my faggot baka life');
                    PlayState.ihatemylifethisisthelastthingthatneedstobecoded = true;
            }
        
        case 'Set Icon Tweak':
            bossTweak = Std.parseFloat(v1);
            bfTweak = Std.parseFloat(v2);

        case 'Bud Lyric Events':
            switch (v1) 
            {
                case 'set':
                    lyrics.loadLyric(v2);

                case 'next':
                    lyrics.nextSlice();

                case 'fade':
                    lyrics.fadeOut();
            }
    }
}
*/
function onGameOverStart() 
{
    setGameOverVideo(videoString);
}

function onDestroy() {
    if (intro != null) intro.destroy();
    if (emotional != null) emotional.destroy();
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 128:
            remove(intro);
            blackHUD.alpha = 0;
            camGame.flash(0xFFFFFFFF, 1.0);
        case 1440:
            defaultCamZoom = 0.65;
            blackStage.visible = true;
            rightpile.alpha = 0;
            leftpile.alpha = 0;
        case 1423:
            blackHUD.alpha = 1;
            //camGame.alpha = 0;
        case 1439:
            blackStage.visible = true;
            rightpile.alpha = 0;
            leftpile.alpha = 0;
        case 1471:
            blackHUD.alpha = 0;
        case 1856:
            for(s in shit){ s.alpha = 0; }
            blackHUD.alpha = 1;
            camGame.alpha = 0; // this because windowed fullscreen has a sinlgle pixel u can see and im not bothered to try to properly fix it fuck my baka life
    //      camGame.setFilters([]);
        case 1888:
            blackStage.visible = false;
            rightpile.alpha = 1;
            leftpile.alpha = 1;
            FlxTween.tween(heythere, {alpha: 0.2}, (60 / SONG.meta.bpm) * 4, {onComplete: function(twn:FlxTween) {
                heythere.alpha = 0;
            }});
        case 1902:
            for(s in shit){ s.alpha = 1; }
            blackHUD.alpha = 0;
            camGame.alpha = 1;
            camGame.flash(0xFFFFFFFF, 1.0);
        case 2431:
            FlxTween.tween(blackHUD, {alpha: 1}, 0.25);
            camCanZoom = false;
            FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom * 0.75}, 1.0, {ease: FlxEase.quadOut});
        case 3330:
            inst.volume = 1;
    }
}
function SHIT(){  
    add(emotional = new FlxVideoSprite()).load(Paths.video("notsillybilly"), [FlxVideoSprite.MUTED]);
    emotional.antialiasing = true;
    emotional.cameras = [camHUD];
    vocals.volume = 0;
    inst.volume = 0;
    emotional.bitmap.onEndReached.add(function() {vidTailsEnd();});
    emotional.play([FlxVideoSprite.MUTED]);}
function SHITend(){  
}
function fadehud(){  
    for(s in shit){ FlxTween.tween(s, {alpha: 0}, 0.25, {ease: FlxEase.quadOut}); }
    FlxTween.num(0, 1, 0.25, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
        onComplete: alpha= hudIn }});
}
function fadeinhud(){  
    for(s in shit){ FlxTween.tween(s, {alpha: 1}, 0.25, {ease: FlxEase.quadOut}); }
    FlxTween.num(1, 0, 0.25, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
        onComplete: alpha= hudIn }});
}
function hudback(){  
    for(s in shit){ FlxTween.tween(s, {alpha: 1}, 1.5, {ease: FlxEase.quadOut}); }
    FlxTween.num(1, 0, 1.5, {ease: FlxEase.quadOut, onUpdate: function(hudIn:FlxTween){
        onComplete: alpha= hudIn }});
}
function spindash(){  
iconCanTweak = false;
FlxTween.angle(iconP2, 0, 360 * 4, (60 / SONG.meta.bpm) * 4, {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween) {
    isSpinning = true;
}});
}
function onSubstateOpen() {
if (intro != null && paused) intro.pause();
if (emotional != null && paused) emotional.pause();}
function onSubstateClose(){
 if (intro != null && paused) intro.resume();
if (emotional != null && paused) emotional.resume();}
function vidTailsEnd() {
    trace('feelin_OOOGLY_GOOD!');

    emotional.visible = false;
    emotional.destroy();
    camGame.flash(0xFFFFFFFF, 1.0);
    blackHUD.alpha = 0;
    vocals.volume = 1;
    FlxTween.tween(titlecard, {alpha: 1}, 0.5);
    new FlxTimer().start(1.25, function(tmr:FlxTimer)
    {
        FlxTween.tween(titlecard, {alpha: 0}, 0.5);
    });
    boyfriend.cameraOffset[0] = 70;
    boyfriend.cameraOffset[1] = -210;
    dad.cameraOffset[0] = 100;
    dad.cameraOffset[1] = -185;
    camHUD.zoom = 1;
    camCanZoom = true;
}