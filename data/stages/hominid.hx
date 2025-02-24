var FILE_PREFIX:String = 'stages/hominid/';

// stage
var helicopter:FlxSprite;
var daScale:Float = 1.75;
var helicameo:Int;
var helitrigger:Int;

function create()
{
    var bg = new FlxSprite(0, -300).loadGraphic(Paths.image('stages/hominid/sky'));
    bg.scrollFactor.set(0.5, 0.5);
    bg.scale.set(daScale, daScale);
    bg.active = false;
    insert(1, bg);
    add(bg);

    var bg2 = new FlxSprite(100, -350).loadGraphic(Paths.image('stages/hominid/distand_buildings'));
    bg.scrollFactor.set(0.8, 0.8);
    bg2.scale.set(daScale, daScale);
    bg2.active = false;
    insert(2, bg2);
    add(bg2);

    helicopter = new FlxSprite(-725, -100);
    helicopter.frames = Paths.getSparrowAtlas('stages/hominid/helicopters');
    helicopter.antialiasing = true;
    helicopter.animation.addByPrefix('1', 'helicopter_tweak', 24, true);
    helicopter.animation.addByPrefix('2', 'helicopter_funny', 24, true);
    helicopter.animation.addByPrefix('3', 'helicopter_badguy', 24, true);
    helicopter.scrollFactor.set(0.85, 0.85);
    insert(3, helicopter);
	add(helicopter);
    
    var bg3 = new FlxSprite(-500, -250).loadGraphic(Paths.image('stages/hominid/side_building_1'));
    bg3.scale.set(daScale, daScale);
    bg3.scrollFactor.set(0.9, 0.9);
    bg3.active = false;
    insert(4, bg3);
    add(bg3);

    var bg4 = new FlxSprite(1500, -250).loadGraphic(Paths.image('stages/hominid/side_building_2'));
    bg4.scale.set(daScale, daScale);
    bg4.scrollFactor.set(0.9, 0.9);
    bg4.active = false;
    insert(5, bg4);
    add(bg4);

    var bg5 = new FlxSprite(50, 700).loadGraphic(Paths.image('stages/hominid/rooftop'));
    bg5.scale.set(daScale, daScale);
    bg5.scrollFactor.set(1, 1);
    bg5.active = false;
    insert(6, bg5);
    add(bg5);

    helicameo = FlxG.random.int(1, 3);
    helitrigger = FlxG.random.int(100, 251);
}

function onCreatePost() 
{
    game.snapCamFollowToPos(675, 375);
}

function beatHit()
{
    if(curBeat == helitrigger)
    {
        FlxTween.tween(helicopter, {x: 1475}, 5.0, {ease: FlxEase.linear});
        helicopter.animation.play("" + helicameo);
        trace('heli triggered');
    }
}

/*function onEvent(name, v1, v2)
{
    if (name == 'Hominid Events') {
        switch (v1) {
            case 'snap hominid':
                game.isCameraOnForcedPos = true;
                game.snapCamFollowToPos(game.dad.getMidpoint().x, game.dad.getMidpoint().y);
            case 'snap pico':
                game.isCameraOnForcedPos = true;
                game.snapCamFollowToPos(game.boyfriend.getMidpoint().x - 150, game.boyfriend.getMidpoint().y - 50);
            case 'end snap':
                game.isCameraOnForcedPos = false;
            case 'heli cameo':
                FlxTween.tween(helicopter, {x: 1475}, 5.0, {ease: FlxEase.linear});
                helicopter.animation.play("" + helicameo);
        }
    }
}
*/
function onGameOverStart() 
{
    setGameOverVideo("alien");
}