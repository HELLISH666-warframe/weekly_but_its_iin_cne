// EVENTS
var jump:FlxSprite;
function create() 
{
    // Stage
    var bg:FlxSprite = new FlxSprite(300, 300);
    bg.loadGraphic(Paths.image("stages/background"));
    bg.setGraphicSize(1000 * 2, 562 * 2);
    insert(1, bg);
    add(bg);

    // Jumpscare
}
function beatHit()
{
    var targetRotate:Int = curBeat / 2;
    if (curBeat % 2 == 0) {
        targetRotate *= -1;
    }

    FlxTween.angle(iconP1, targetRotate, 0, 0.3, {ease: FlxEase.quadOut});
    FlxTween.angle(iconP2, targetRotate, 0, 0.3, {ease: FlxEase.quadOut});
}
function postCreate()
{
    jump = new FlxSprite(0, 0);
    jump.loadGraphic(Paths.image("stages/jumpscare!"));
    jump.setGraphicSize(1280, 720);
    jump.screenCenter();
    jump.antialiasing = true;
    jump.alpha = 0.001;
    jump.cameras = [camHUD];
    add(jump);
 //   game.snapCamFollowToPos(700, 500);
}

function jumP()
{
    jump.alpha = 1;
}
function jumPoff(){
    jump.alpha = 0.000001;
}