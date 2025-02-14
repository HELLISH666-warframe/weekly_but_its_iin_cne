import hxvlc.flixel.FlxVideoSprite;
function postCreate() {
    intro = new FlxVideoSprite().load(Assets.getPath(Paths.video('kys'))); 
    add(intro = new FlxVideoSprite()).load(Paths.video("kys"));
    intro.antialiasing = true;
    intro.cameras = [camHUD];

    var bg:FlxSprite = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image("stages/chefblast/kitchen"));
    bg.scrollFactor.set(0.9, 1.0);
    insert(1,bg);
	add(bg); 

    var stageFront:FlxSprite = new FlxSprite(10, 875);
    stageFront.loadGraphic(Paths.image("stages/chefblast/table"));
    insert(2,stageFront);
    add(stageFront);
}

function onGameOverStart() 
{   
    setGameOverVideo('gordonover');
}    

function stepHit(curStep)
{
    if (curStep == 796)
	{
        intro.play();
	}
    if (curStep == 817)
	{
        remove(intro);
	}
}
//        remove(intro);