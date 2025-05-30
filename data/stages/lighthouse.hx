var PREFIX:String = 'stages/siiva/';

var lights:FlxSprite;
var fnaf:FlxSprite;
var black:FlxSprite;
var fade:FlxSprite;
var shit = null;

var colours:Array<FlxColor> = [0xffe64c44, 0xfff3ad52, 0xfff3f163, 0xFF4fed34, 0xFF34edd4, 0xFF61A4F0, 0xFFac34ed, 0xFFed34cb];
var curColour:Int = 0;
var gay:Bool = false;
introLength = 0;
function onCountdown(event) event.cancel();

function create()
{
    var bg = new FlxSprite(-600, -300).loadGraphic(Paths.image(PREFIX + 'sky'));
    bg.scrollFactor.set(0.1, 0.1);
    insert(1, bg);
    add(bg);

    var lighthouse = new FlxSprite(-600, 100).loadGraphic(Paths.image(PREFIX + 'bg'));
    lighthouse.scrollFactor.set(0.3, 0.3);
    insert(2, lighthouse);
    add(lighthouse);

    lights = new FlxSprite(-580, 115).loadGraphic(Paths.image(PREFIX + 'blammed'));
    lights.scrollFactor.set(0.3, 0.3);
    insert(3, lights);
    add(lights);

    var foreground = new FlxSprite(-500, 700).loadGraphic(Paths.image(PREFIX + 'ground'));
    foreground.scrollFactor.set(1, 1);
    insert(4, foreground);
    add(foreground);

    fade = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
   // fade.cameras = [game.camOther];
    fade.cameras = [camHUD];
    add(fade);


    fnaf = new FlxSprite(0,0).loadGraphic(Paths.image(PREFIX + 'thumbnail'));
    fnaf.cameras = [camHUD];
    //fnaf.cameras = [game.camOther];
    fnaf.alpha = 0.001;
    add(fnaf);

}

function postCreate()
{
    //game.camHUD.alpha = 0;

    black = new FlxSprite(-100, -100).makeGraphic(3000, 3000, FlxColor.BLACK);
    black.alpha = 0;
	insert(members.indexOf(dad)-1, black);
    shit = [scoreTxt, healthBarBG, healthBar, iconP1, iconP2, accuracyTxt, missesTxt];
    for(s in shit){ s.alpha = 0; }
}
function stepHit(curStep)
{
    switch (curStep)
    {
        // 'hi circus':
        case 5:
            fnaf.alpha = 1;
            defaultCamZoom = 1.6;
            // 'bye circus':
        case 59:
            FlxTween.tween(fnaf, {alpha: 0}, 0.3);
            // 'hi friends':
        case 64:
            boyfriend.cameraOffset[0] = 200000000;

          //  camFollow.y = 100;
          camFollow.y = 800;
          camFollow.x = 100;
          // FlxG.camera.follow(800, 100);
            FlxTween.tween(fade, {alpha: 0}, 1.2);
        case 128:
            var daY:Float = 400;
            var daEase:FlxEase = FlxEase.quadInOut;

            FlxTween.tween(camFollow, {y: daY}, 0.48 * 12, {ease : daEase});

            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 0.48 * 12, {ease : daEase});
            defaultCamZoom = 0.7;
        case 180:
            for(s in shit){ s.alpha = 1; }
        case 180:
            defaultCamZoom = 0.8;
            //_FUCK_YOUgame.isCameraOnForcedPos = false;
    }
}
/*function onEvent(name:String, v1:String, v2:String)
{
    switch (name) 
    {
        case 'SiIva Events':
            switch (v1) 
            {
                // circus

                // intro
                case 'start gaming':
                    game.defaultCamZoom = 0.8;
                    game.isCameraOnForcedPos = false;
                case 'Lighthouse Flash':
                    gay = ClientPrefs.flashing;
                case 'Stop Flash':
                    gay = false;
                // fake game over
                case 'zoom in':
                    game.isCameraOnForcedPos = true;

                    var daX:Float = game.boyfriend.x + 150;
                    var daY:Float = game.boyfriend.y + 350;
                    var daEase:FlxEase = FlxEase.expoIn;

                    FlxTween.tween(game.camFollow, {x : daX, y : daY}, 0.48 * 2, {ease: daEase});
                    FlxTween.tween(game.camFollowPos, {x : daX, y : daY}, 0.48 * 2, {ease: daEase});
                    FlxTween.tween(FlxG.camera, {zoom : 0.95}, 0.48 * 2, {ease : daEase});

                case 'DIE DIE DIE':
                    game.isCameraOnForcedPos = true;
                    game.camHUD.alpha = 0;
                    black.alpha = 1;
                    game.boyfriend.playAnim('dead');
                    game.boyfriend.animTimer = 999;

                case 'bye friend':
                    FlxTween.tween(game.boyfriend, {alpha : 0}, 0.48 * 4);
            }
    }
}
*/
function beatHit()
{
    if (gay) 
    {
        FlxTween.color(lights, 0.3, FlxColor.WHITE, colours[curColour]);
        curColour = (curColour + 1) % colours.length;
    }
    else
    {
        lights.color = FlxColor.WHITE;
    }
}
function snapCamFollowToPos(x:Float, y:Float) {
    FlxG.camera.follow.set(x,y);
    camFollow.setPosition(FlxAxes.x,FlxAxes.y);
}
function onGameOverStart()
{
    setGameOverVideo('siiva');
}