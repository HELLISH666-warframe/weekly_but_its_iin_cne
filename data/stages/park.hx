var crowd:FlxSprite;

function create() {
    var sky:FlxSprite = new FlxSprite(-600, -300);
    sky.loadGraphic(Paths.image("stages/minus/sky"));
    sky.antialiasing = true;
    sky.scrollFactor.set(0.5, 0.5);
    insert(1, sky);
	add(sky);

    var back:FlxSprite = new FlxSprite(-700, -100);
    back.loadGraphic(Paths.image("stages/minus/back"));
    back.antialiasing = true;
    back.scrollFactor.set(0.8, 0.8);
    insert(2, back);
	add(back);

    crowd = new FlxSprite(-650, 480);
    crowd.frames = Paths.getSparrowAtlas("stages/minus/crowd");
    crowd.antialiasing = true;
    crowd.animation.addByPrefix('idle', 'crowd', 24, false);
    crowd.animation.play("idle");
    crowd.scrollFactor.set(0.9, 0.9);
    insert(3, crowd);
	add(crowd); 

    var front:FlxSprite = new FlxSprite(-900, 100);
    front.loadGraphic(Paths.image("stages/minus/front"));
    front.antialiasing = true;
    front.scrollFactor.set(1, 1);
    insert(4, front);
	add(front);

    }

function beatHit()
{
    if(curBeat % 2 == 0){
        crowd.animation.play('idle', true);
        trace('POOPP)PPP');
    }
} 

function onSongStart() {
    crowd.animation.play('idle', true);
}

function onCountdownTick(swagCounter){
    if(swagCounter % 2 == 0) crowd.animation.play('idle', true);
}

function onGameOverStart() 
{
    setGameOverVideo('minus');
}