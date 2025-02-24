function create() {
    var sky:FlxSprite = new FlxSprite(-614, -1027);
    sky.loadGraphic(Paths.image("stages/annie/sky"));
    sky.antialiasing = true;
    sky.scrollFactor.set(0.65, 0.65);
    insert(1, sky);
	add(sky);

    var clouds:FlxSprite = new FlxSprite(-336, -524);
    clouds.loadGraphic(Paths.image("stages/annie/clouds"));
    clouds.antialiasing = true;
    clouds.scrollFactor.set(0.7, 0.7);
    insert(2, clouds);
	add(clouds);

    var buildingsfar:FlxSprite = new FlxSprite(103, -176);
    buildingsfar.loadGraphic(Paths.image("stages/annie/buildingsbg"));
    buildingsfar.antialiasing = true;
    buildingsfar.scrollFactor.set(0.8, 0.8);
    insert(3, buildingsfar);
	add(buildingsfar);

    var buildings:FlxSprite = new FlxSprite(-778, -304);
    buildings.loadGraphic(Paths.image("stages/annie/buildings"));
    buildings.antialiasing = true;
    buildings.scrollFactor.set(0.9, 0.9);
    insert(4, buildings);
	add(buildings);

    var grass:FlxSprite = new FlxSprite(-547, -240);
    grass.loadGraphic(Paths.image("stages/annie/grass"));
    grass.antialiasing = true;
    grass.scrollFactor.set(0.95, 0.95);
    insert(5, grass);
	add(grass);

    var ground:FlxSprite = new FlxSprite(-785, 387);
    ground.loadGraphic(Paths.image("stages/annie/road"));
    ground.antialiasing = true;
    insert(6, ground);
	add(ground);
}


function onCreatePost(){
   // game.snapCamFollowToPos(700, 200);
}

function onGameOverStart() 
{
    setGameOverVideo('annie');
}