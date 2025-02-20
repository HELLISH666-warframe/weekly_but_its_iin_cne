// EVENTS
function create() 
{
    // Stage
    var bg:FlxSprite = new FlxSprite(300, 300);
    bg.loadGraphic(Paths.image("stages/background"));
    bg.setGraphicSize(1000 * 2, 562 * 2);
    insert(1, bg);
    add(bg);

    // Jumpscare
    jump = new FlxSprite(0, 0);
    jump.loadGraphic(Paths.image("stages/jumpscare!"));
    jump.setGraphicSize(1280, 720);
    jump.screenCenter();
    jump.alpha = 0.001;
}

function onCreatePost()
{
    jump.cameras = [camHUD];
    add(jump);
 //   game.snapCamFollowToPos(700, 500);
}

function jumpscare()
{
    jump.alpha = 1;
}