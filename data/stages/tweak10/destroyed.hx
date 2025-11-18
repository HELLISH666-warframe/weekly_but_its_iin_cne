// I'm so exhausted man
public var defaultCamZoomAdd:Float = 0;
public var camZooming:Bool = false;
public var camZoomingDecay:Float = 1;

public var defaultHudZoom:Float = 1;

var camCanZoom:Bool = true;

var leftpile:FlxSprite;
var rightpile:FlxSprite;

var videoString:String = 'bnb_gameover';

function create() {
    trace(leftpile.x,leftpile.y);

    var addlayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/tweak10/bud/add'));
    addlayer.antialiasing = true;
    addlayer.blend = 0;
    addlayer.alpha = 0.5;
    insert(5,addlayer);

    var multiplylayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/tweak10/bud/multiply'));
    multiplylayer.antialiasing = true;
    multiplylayer.blend = 9; // ??????????
    insert(6,multiplylayer);

    blackStage = new FlxSprite(-1000, -750).makeGraphic(FlxG.width * 2.5, FlxG.height * 2.5, FlxColor.BLACK); // this is dumb and gay to have two of these but its ok
    blackStage.visible = false;
    blackStage.alpha = 0.5;
    insert(7,blackStage);
}
override function update(elapsed:Float)
{
    camFollow.x = 710;
    camFollow.y = 175;

    camZooming = camCanZoom;
    if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom + defaultCamZoomAdd, FlxG.camera.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay));
			camHUD.zoom = FlxMath.lerp(defaultHudZoom, camHUD.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay));
		}
}
function onGameOverStart() 
{
    setGameOverVideo(videoString);
}
function stepHit(curStep) {
    switch (curStep) {
        case 1440:
            defaultCamZoom = 0.65;
            blackStage.visible = true;
            rightpile.alpha = 0;
            leftpile.alpha = 0;
        case 1439:
            blackStage.visible = true;
            rightpile.alpha = 0;
            leftpile.alpha = 0;
        case 1888:
            blackStage.visible = false;
            rightpile.alpha = 1;
            leftpile.alpha = 1;
        case 3330:
            inst.volume = 1;
    }
}