function create() {
    var sky:FlxSprite = new FlxSprite(-275, -200);
    sky.loadGraphic(Paths.image("stages/fancy/sky"));
    sky.antialiasing = false;
    sky.scrollFactor.set(0.5, 0.5);
    insert(1, sky);
	add(sky);

    var grass:FlxSprite = new FlxSprite(-100, -475);
    grass.loadGraphic(Paths.image("stages/fancy/mountains"));
    grass.antialiasing = false;
    grass.scrollFactor.set(0.75, 0.75);
    insert(2, grass);
	add(grass);

    var flag:FlxSprite = new FlxSprite(1650, 365);
    flag.loadGraphic(Paths.image("stages/fancy/flag"));
    flag.antialiasing = false;
    insert(3, flag);
	add(flag);

    var ground:FlxSprite = new FlxSprite(0, -475);
    ground.loadGraphic(Paths.image("stages/fancy/platforms"));
    ground.antialiasing = false;
    insert(4, ground);
	add(ground);
}


function onCreatePost(){
    game.snapCamFollowToPos(1300, 500);
}

function onGameOverStart() 
{
    setGameOverVideo('fancy_gameover');
}