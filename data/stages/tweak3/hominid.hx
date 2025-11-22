// stage
var helicopter:FlxSprite;
var helicameo:Int;
var helitrigger:Int;

function create()
{
    helicopter = new FlxSprite(-725, -100);
    helicopter.frames = Paths.getSparrowAtlas('stages/tweak3//hominid/helicopters');
    helicopter.antialiasing = true;
    helicopter.animation.addByPrefix('1', 'helicopter_tweak', 24, true);
    helicopter.animation.addByPrefix('2', 'helicopter_funny', 24, true);
    helicopter.animation.addByPrefix('3', 'helicopter_badguy', 24, true);
    helicopter.scrollFactor.set(0.85, 0.85);
    insert(3, helicopter);

    helicameo = FlxG.random.int(1, 3);
    helitrigger = FlxG.random.int(100, 251);
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