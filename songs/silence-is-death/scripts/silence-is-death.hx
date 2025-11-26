import openfl.display.BlendMode;

var loadingScreen:FlxSprite;
var wheel:FlxSprite;
var loadingText:FlxSprite;

function create() {
    defaultCamZoom = 1.1;
}

function postCreate() {
    loadingScreen = new FlxSprite(0,0).loadGraphic(Paths.image('stages/tweak8/guest/LoadingScreen'));
    loadingScreen.camera = camOther;
    add(loadingScreen);

    wheel = new FlxSprite(1128,565).loadGraphic(Paths.image('stages/tweak8/guest/Wheel'));
    wheel.camera = camOther;
    add(wheel);

    loadingText = new FlxSprite(1150,614).loadGraphic(Paths.image('stages/tweak8/guest/LoadingText'));
    loadingText.frames = Paths.getSparrowAtlas('stages/tweak8/guest/LoadingText');
    loadingText.animation.addByPrefix('load', 'Loading', 24, true);
    loadingText.camera = camOther;
    loadingText.animation.play('load');
    add(loadingText);

    strumLines.members[3].characters[0].setPosition(50,-600);
    remove(strumLines.members[3].characters[0]);
    insert(3,strumLines.members[3].characters[0]);
    stage.getSprite("bg").setGraphicSize(1280*1.7, 720*1.7);
    trace(stage.getSprite("bg").scale.x,stage.getSprite("bg").scale.y);

    stage.getSprite("overlay").alpha = 0.08;
    stage.getSprite("overlay").blend = BlendMode.ADD;

    dad.playAnim('scarystart', true);
    for(i in [accuracyTxt,missesTxt,scoreTxt,timeTxt])
    i.font = Paths.font('tweak8/Boblox.ttf');
    timeTxt.y -= 7;
}

var s:Float = 1;
function update(elapsed:Float) {
    s += elapsed;
    strumLines.members[3].characters[0].x = FlxMath.lerp(strumLines.members[3].characters[0].x, strumLines.members[3].characters[0].x + (Math.sin(s) * -5), FlxMath.bound(1, 0, elapsed * 4));
    strumLines.members[3].characters[0].y = FlxMath.lerp(strumLines.members[3].characters[0].y, strumLines.members[3].characters[0].y + (Math.cos(s) * 5), FlxMath.bound(1, 0, elapsed * 4));

    wheel.angle += 1;
}

function onCountdown(event) event.cancel();
function onStartCountdown(event) {event.cancel();
    inCutscene = true;
    camHUD.alpha = 0.001;
    //snapCamFollowToPos(700, 500);
    new FlxTimer().start(2, function(tmr:FlxTimer)  {
        FlxTween.tween(loadingScreen, {alpha : 0}, 1);
        FlxTween.tween(wheel, {alpha : 0}, 1);
        FlxTween.tween(loadingText, {alpha : 0}, 1);
        inCutscene = false;
        startCountdown();
    });
}
function onDadHit(e) {
    if (e.noteType == "Female666"){
    e.cancelAnim();
    strumLines.members[3].characters[0].playSingAnim(e.direction, e.animSuffix);
    }
    if (e.noteType == "Duet") strumLines.members[3].characters[0].playSingAnim(e.direction, e.animSuffix);
}
function onPlayerHit(e) {
    if (e.noteType == "Duet") strumLines.members[2].characters[0].playSingAnim(e.direction, e.animSuffix);
    e.ratingPrefix = "stages/tweak8/guest/";
}
function stepHit(curStep:Int) {
    switch(curStep){
        case 50: FlxTween.tween(stage.getSprite("black"), {alpha : 0.3}, 1.5, {ease: FlxEase.linear});
        case 64/*16*/: camHUD.alpha = 1;
        defaultCamZoom = 0.9;
        FlxTween.tween(stage.getSprite("black"), {alpha : 0}, 0.6, {ease: FlxEase.expoOut});
        FlxTween.tween(stage.getSprite("black"), {alpha : 0}, 0.4, {ease: FlxEase.expoOut});
        case 319/*79*/|391/*97*/|447/*111*/|704/*176*/|904/*226*/|1343/*335*/|1415/*353*/|1471/*367*/: 
        FlxTween.tween(stage.getSprite("black"), {alpha : 0}, 0.4, {ease: FlxEase.expoOut});
        case 688/*172*/: FlxTween.tween(strumLines.members[3].characters[0], {y: -10}, 4, {ease: FlxEase.expoOut});
        iconP2.setIcon('tweak8/doppelbloxxers');
        case 907: FlxTween.tween(gf, {x: -440}, 4, {ease: FlxEase.linear,
        onComplete: function(tween:FlxTween) {
            gf.playAnim('danceLeft', true);
            iconP1.setIcon('tweak8/bloxxers');
        }});
    }
}

function flash(value:Float) {
    FlxTween.tween(stage.getSprite("black"), {alpha : value}, 0.4, {ease: FlxEase.expoOut});
}

function onGameOverStart()
{
    if(FlxG.random.bool(3))
    {
        setGameOverVideo('robloxfriend');
    }
    else
    {
        setGameOverVideo('scarygameover');
    }
}