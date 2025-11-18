import openfl.display.BlendMode;
var tentacle:FlxAnimate;

function create()
{      
    skyScary = new FlxSprite(-3400, -230).loadGraphic(Paths.image('stages/celeste/emotional'));
    skyScary.frames = Paths.getSparrowAtlas('stages/celeste/emotional');
    skyScary.animation.addByPrefix('loop', 'emotional', 24, true);
    skyScary.animation.play('loop');
    skyScary.scrollFactor.set(0.8, 0.8);
    insert(1, skyScary);
    add(skyScary);

    tentacle = new FlxAnimate(500, -400, 'images/stages/celeste/hair');
    tentacle.showPivot = false;
    tentacle.anim.addBySymbol('loop', 'loop',24,true,0,0);
    tentacle.antialiasing = true;
    insert(2, tentacle);
    add(tentacle);

    sky = new FlxSprite( -570, -230).loadGraphic(Paths.image('stages/celeste/sky'));
    sky.scrollFactor.set(0.8, 0.8);
    insert(3, sky);
    add(sky);

    floor = new FlxSprite(-600, -50).loadGraphic(Paths.image('stages/celeste/floor'));
    floor.setGraphicSize(2077*1.3, 1151*1.3);
    insert(4, floor);
    add(floor);

    overlay = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/celeste/overlay'));
    overlay.scrollFactor.set(0, 0);
    overlay.setGraphicSize(1280*1.25, 720*1.25);
    overlay.alpha = 0.5;
    overlay.blend = BlendMode.ADD;
    insert(8, overlay);
    add(overlay);

 //   game.comboOffsetCustom = [1000, 450, 1050, 550];
}

function postCreate()
{
    healthBar.flipX = true;
    healthBarSide = 1;
    iconP1.flipX = !iconP1.flipX;
    iconP2.flipX = !iconP2.flipX;
    scoreTxt.font = Paths.font('Renogare.ttf');
//    modManager.setValue("opponentSwap", 1);
    camFollow.getPosition(350, 400);
}

var s:Float = 1;
override function update(elapsed:Float){
    s += elapsed;
    dad.x = FlxMath.lerp(dad.x, dad.x + (Math.sin(s) * -7), FlxMath.bound(1, 0, elapsed * 4));
    dad.y = FlxMath.lerp(dad.y, dad.y + (Math.cos(s) * 7), FlxMath.bound(1, 0, elapsed * 4));
}

/*function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Pink':
        switch(value1)
        {
            case 'dash':
                new FlxTimer().start(0.6, function(tmr:FlxTimer)
                {
                    FlxTween.tween(sky, {alpha : 0}, 1.3, {ease: FlxEase.expoOut});
                    FlxTween.tween(overlay, {alpha : 0}, 1.3, {ease: FlxEase.expoOut});
                    tentacle.anim.play('loop');
                });
        }
    }
}
*/
function onGameOverStart()
{
    {
        setGameOverVideo('demodingaling');
    }
}