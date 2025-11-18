function create() {
    var sky:FlxSprite = new FlxSprite(-685, -506);
    sky.loadGraphic(Paths.image("stages/ena/sky"));
    sky.antialiasing = true;
    sky.scrollFactor.set(0.65, 0.65);
    insert(1, sky);
	add(sky);
    
    var clouds:FlxSprite = new FlxSprite(-712, -513);
    clouds.loadGraphic(Paths.image("stages/ena/clouds"));
    clouds.antialiasing = true;
    clouds.scrollFactor.set(0.75, 0.75);
    insert(2, clouds);
	add(clouds);
    
    var statues:FlxSprite = new FlxSprite(289, -14);
    statues.loadGraphic(Paths.image("stages/ena/far_places"));
    statues.antialiasing = true;
    statues.scrollFactor.set(0.8, 0.8);
    insert(3, statues);
	add(statues);
    
    var hillsback:FlxSprite = new FlxSprite(-747, 267);
    hillsback.loadGraphic(Paths.image("stages/ena/more_hills"));
    hillsback.antialiasing = true;
    hillsback.scrollFactor.set(0.85, 0.85);
    insert(4, hillsback);
	add(hillsback);

    var hills:FlxSprite = new FlxSprite(-667, 236);
    hills.loadGraphic(Paths.image("stages/ena/hills_back"));
    hills.antialiasing = true;
    hills.scrollFactor.set(0.9, 0.9);
    insert(5, hills);
	add(hills);
    
    var hourglass:FlxSprite = new FlxSprite(-420, 117);
    hourglass.loadGraphic(Paths.image("stages/ena/hourglasses_bg"));
    hourglass.antialiasing = true;
    hourglass.scrollFactor.set(0.95, 0.95);
    insert(6, hourglass);
	add(hourglass);

    var floor:FlxSprite = new FlxSprite(-756, 521);
    floor.loadGraphic(Paths.image("stages/ena/hill_floor"));
    floor.antialiasing = true;
    insert(7, floor);
	add(floor);
    boyfriend.cameraOffset[9] = 75;
    dad.cameraOffset[9] = 650;
}

function postCreate(){

    boyfriend.cameraOffset[0] = 650;
    dad.cameraOffset[0] = 75;
}

/*function onEvent(eventName, value1, value2){
    if(eventName == 'EnaEvents'){
        switch(value1){
            case 'duet':
            game.isCameraOnForcedPos = true;
            FlxTween.tween(game.camFollow, {x: 650}, 0.5, {ease: FlxEase.smootherStepInOut});
            case 'duet off':
            game.isCameraOnForcedPos = false;   
        }
    }
}
*/
function onGameOverStart() 
{
    setGameOverVideo("ena_gameover");
}