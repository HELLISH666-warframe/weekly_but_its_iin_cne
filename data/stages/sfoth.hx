import openfl.display.BlendMode;
var PREFIX:String = 'Guest/';
public var v0:FNFSprite;

var bg:BGSprite;
var sky:BGSprite;
var loadingScreen:FlxSprite;
var wheel:FlxSprite;
var loadingText:FlxSprite;

// THIS CODE IS BAD I KNOW !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
introLength = 0;
function onCountdown(event) event.cancel();
function create()
{
    sky = new FlxSprite(-600, -50).loadGraphic(Paths.image('stages/guest/Sky'));
    sky.scrollFactor.set(0.8,0.8);
    insert(1, sky);
    add(sky);

    bg = new FlxSprite( -900, -200).loadGraphic(Paths.image('stages/guest/BG'));
    bg.setGraphicSize(1280*1.7, 720*1.7);
    insert(2, bg);
    add(bg);

    black = new FlxSprite(-300, -300).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    black.scrollFactor.set(0, 0);
    black.alpha = 0;
    insert(3, black);
    add(black);

    v0 = new FunkinSprite(50, -600);
    v0.frames = Paths.getSparrowAtlas('stages/guest/zero');
    v0.animation.addByPrefix('load', 'Loading', 24, true);
    v0.playAnim('idle', true);
    add(v0);

    loadingScreen = new FlxSprite(0,0).loadGraphic(Paths.image('stages/guest/LoadingScreen'));
    loadingScreen.cameras = [camHUD];
    add(loadingScreen);

    wheel = new FlxSprite(1128,565).loadGraphic(Paths.image('stages/guest/Wheel'));
    wheel.cameras = [camHUD];
    add(wheel);

    loadingText = new FlxSprite(1150,614).loadGraphic(Paths.image('stages/guest/LoadingText'));
    loadingText.frames = Paths.getSparrowAtlas('stages/guest/LoadingText');
    loadingText.animation.addByPrefix('load', 'Loading', 24, true);
    loadingText.cameras = [camHUD];
    loadingText.animation.play('load');
    add(loadingText);

    overlay = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/guest/overlay'));
    overlay.scrollFactor.set(0, 0);
    overlay.setGraphicSize(1280*1.25, 720*1.25);
    overlay.alpha = 0.08;
    overlay.blend = BlendMode.NORMAL;
    insert(7, black);
    add(overlay);

    defaultCamZoom = 1.1;
}

function postCreate()
{
    skipCountdown = true;
    dad.playAnim('scarystart', true);
    scoreTxt.font = Paths.font('Boblox.ttf');
}

var s:Float = 1;
var v0X:Float = 0;
var v0Y:Float = 0;
override function update(elapsed:Float){
    s += elapsed;
    v0.x = FlxMath.lerp(v0.x, v0.x + (Math.sin(s) * -5), FlxMath.bound(1, 0, elapsed * 4));
    v0.y = FlxMath.lerp(v0.y, v0.y + (Math.cos(s) * 5), FlxMath.bound(1, 0, elapsed * 4));

    wheel.angle += 1;
}

function doStartCountdown()
{
    return Function_Stop;
}

function onSongStart(){    
    inCutscene = true;
    camHUD.alpha = 0.001;
    camFollow.getPosition(700, 500);
    new FlxTimer().start(2, function(tmr:FlxTimer) 
        {
            FlxTween.tween(loadingScreen, {alpha : 0}, 1);
            FlxTween.tween(wheel, {alpha : 0}, 1);
            FlxTween.tween(loadingText, {alpha : 0}, 1);
            inCutscene = false;
            startCountdown();
        });}
function onSpawnNotePost(note){
    if(note.noteType == 'Female666') note.noAnimation = true;
}
function opponentNoteHit(note){
    if(note.noteType == 'Female666' ||  note.noteType == 'Duet'){
        v0.playAnim(game.singAnimations[note.noteData], true);
        v0.holdTimer = 0;
    } 

    if(note.noteType == 'Female666' && !mustHitSection)
    {
        game.camFollow.set(v0.getMidpoint().x - 10, v0.getMidpoint().y + 250);
        game.isCameraOnForcedPos = true;

        switch(note.noteData)
        {
            case 0:
                camFollow.set(v0.getMidpoint().x - 25, v0.getMidpoint().y + 250);
            case 1:
                camFollow.set(v0.getMidpoint().x - 10, v0.getMidpoint().y + 265);
            case 2:
                camFollow.set(v0.getMidpoint().x - 10, v0.getMidpoint().y + 235);
            case 3:
                camFollow.set(v0.getMidpoint().x + 5, v0.getMidpoint().y + 250);
        }
    }
    else {
        game.isCameraOnForcedPos = false;
    }
}

function goodNoteHit(note){
    if(note.noteType == 'Duet'){
        game.gf.playAnim(game.singAnimations[note.noteData], true);
        game.gf.holdTimer = 0;
    }
    if(note.noteType != 'GF Sing' && mustHitSection)
    {
        game.isCameraOnForcedPos = false;
    }
    if(note.noteType == 'GF Sing' && mustHitSection)
    {
        game.camFollow.set(gf.getMidpoint().x - 100, gf.getMidpoint().y + 250);
        game.isCameraOnForcedPos = true;

        switch(note.noteData)
        {
            case 0:
                game.camFollow.set(gf.getMidpoint().x - 115, gf.getMidpoint().y + 250);
            case 1:
                game.camFollow.set(gf.getMidpoint().x - 100, gf.getMidpoint().y + 265);
            case 2:
                game.camFollow.set(gf.getMidpoint().x - 100, gf.getMidpoint().y + 235);
            case 3:
                game.camFollow.set(gf.getMidpoint().x - 85, gf.getMidpoint().y + 250);
        }
    }
}

function beatHit(){
    if(v0.canResetIdle && curBeat % 2 == 0) v0.playAnim('idle', true);
}

/*function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Guest':
        switch(value1)
        {
            case 'v0':
                FlxTween.tween(v0, {y: -10}, 4, {ease: FlxEase.expoOut});
                iconP2.changeIcon('doppelbloxxers');
            case "betty":
                FlxTween.tween(game.gf, {x: 530}, 4, {ease: FlxEase.linear,
                onComplete: function(tween:FlxTween) {
                    game.gf.playAnim('danceLeft', true);
                    iconP1.changeIcon('bloxxers');
                }});
            case "flash":
                FlxTween.tween(black, {alpha : value2}, 0.4, {ease: FlxEase.expoOut});
            case "friend":
                FlxTween.tween(black, {alpha : 0.3}, 1.5, {ease: FlxEase.linear});
        }
    }
}
*/
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

function fakeMoveCamera(char:Character, toggle:Bool) //thanks orbyy
{
    game.isCameraOnForcedPos = toggle;
    if (toggle)
    {
        var curCharacter:Character = char;
        if (game.camCurTarget != null) curCharacter = game.camCurTarget;

        var desiredPos = char.getMidpoint();
        desiredPos.x += 150 + char.cameraPosition[0] + game.opponentCameraOffset[0];
        desiredPos.y += -100 + char.cameraPosition[1] + game.opponentCameraOffset[1];

        var displacement:FlxPoint = curCharacter.returnDisplacePoint();

        game.camFollow.x = desiredPos.x + displacement.x;
        game.camFollow.y = desiredPos.y + displacement.y;

        displacement.put();
        desiredPos.put();

        whosTurn = char;
    }
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 50:
            FlxTween.tween(black, {alpha : 0.3}, 1.5, {ease: FlxEase.linear});
        case 64:
            camHUD.alpha = 1;
            defaultCamZoom = 1.1;
            FlxTween.tween(black, {alpha : 0}, 0.6, {ease: FlxEase.expoOut});
            FlxTween.tween(black, {alpha : 0}, 0.4, {ease: FlxEase.expoOut});
        case 907:
            FlxTween.tween(gf, {x: gf.x=  -430}, 4, {ease: FlxEase.linear,
                onComplete: function(tween:FlxTween) {
                    gf.playAnim('danceLeft', true);
                    iconP1.setIcon('bloxxers');
                }});
    }
}