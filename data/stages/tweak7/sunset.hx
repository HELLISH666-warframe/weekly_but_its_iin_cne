//addHaxeLibrary('Lib', 'openfl');
import flixel.ui.FlxBar;
var cameras = [camGame, camHUD, /*camOther*/];
var actualBar:FlxBar;
var blackScreen:FlxSprite;
var supersonic:Bool = false;

FlxG.scaleMode.width = 1280; 
FlxG.scaleMode.height = 720;   
FlxG.camera.width = 1280;  
FlxG.camera.height = 720; 
FlxG.resizeWindow(1280, 720);
camHUD.width = 1280;
camHUD.height = 720;

function postCreate()
{
    
    var bg:FlxSprite = new FlxSprite(-50, -100);
    bg.frames = Paths.getSparrowAtlas("stages/ffsonic/bg");
    bg.antialiasing = true;
    bg.animation.addByPrefix('idle', 'bg', 24, true);
    bg.animation.play("idle");
    bg.scale.set(5, 5);
    bg.updateHitbox();
    bg.scrollFactor.set(0,0);
    insert(1, bg);
	add(bg); 
    
    var trees:FlxSprite = new FlxSprite(0, -125);
    trees.loadGraphic(Paths.image("stages/ffsonic/trees"));
    trees.antialiasing = true;
    trees.scale.set(5, 5);
    trees.updateHitbox();
    trees.scrollFactor.set(0.1,0.1);
    insert(2, trees);
    add(trees); 

    var fg:FlxSprite = new FlxSprite(-300, 700);
    fg.loadGraphic(Paths.image("stages/ffsonic/fg"));
    fg.antialiasing = false;
    fg.scale.set(4, 4);
    fg.updateHitbox();
    insert(3, fg);
	add(fg); 

    blackScreen = new FlxSprite().makeGraphic(1, 1, 0xFF000000);
    blackScreen.scale.set(FlxG.width * 2,FlxG.height * 2);
    blackScreen.updateHitbox();
    blackScreen.scrollFactor.set();
    blackScreen.screenCenter();
    blackScreen.cameras = [/*camOther*/camHUD];
    add(blackScreen);

    divider = '-';

    var removes = [healthBar, healthBarBG, iconP1, iconP2];
    for(obj in removes){ remove(obj); }
    comboOffsetCustom = [500, 300, 500, 450];
    
    var newWidth:Float = 1100;
    var newHeight:Float = 800; 

    for(camera in cameras){
        camera.width = newWidth;
        camera.height = newHeight;
    }
    FlxG.resizeWindow(newWidth, newHeight);
    FlxG.scaleMode.width = newWidth;
    FlxG.scaleMode.height = newHeight;

    var bars:FlxSprite = new FlxSprite(0, 0);
    bars.loadGraphic(Paths.image("stages/ffsonic/ui/baroverlay"));
    bars.antialiasing = false;
    bars.cameras = [camHUD];
    bars.scale.set(2, 2);
    bars.updateHitbox();
    insert(0, bars);
	add(bars); 
 
    actualBar = new FlxBar(0, PlayState.downscroll ? 95 : 740, 'LEFT_TO_RIGHT', 908, 18);
    actualBar.cameras = [camHUD];
    actualBar.createGradientBar([0xFFFFFFFF, 0xFFFF0000], [0xFF48FF48, 0xFFFFFFFF], 1, 0);
    actualBar.updateBar();
    actualBar.screenCenter(FlxAxes.X);
    insert(members.indexOf(camHUD), actualBar);
    add(actualBar); 

    var barbg:FlxSprite = new FlxSprite(actualBar.x - 4, actualBar.y - 4);
    barbg.loadGraphic(Paths.image("stages/ffsonic/ui/healthbar_BG"));
    barbg.antialiasing = false;
    barbg.cameras = [camHUD];
    barbg.scale.set(2, 2);
    barbg.updateHitbox();
	insert(members.indexOf(camHUD), barbg);
    add(barbg);

    var sonic_icon:FlxSprite = new FlxSprite(6, PlayState.downscroll ? 8 : 654);
    sonic_icon.loadGraphic(Paths.image("stages/ffsonic/ui/sonic_icon"));
    sonic_icon.antialiasing = true;
    sonic_icon.camera = camHUD;
    sonic_icon.scale.set(2, 2);
    sonic_icon.updateHitbox();
	insert(members.indexOf(camHUD), sonic_icon);
    add(sonic_icon); 

    var aeon_icon:FlxSprite = new FlxSprite(966, PlayState.downscroll ? 8 : 654);
    aeon_icon.loadGraphic(Paths.image("stages/ffsonic/ui/aeon_icon"));
    aeon_icon.antialiasing = true;
    aeon_icon.cameras = [camHUD];
    aeon_icon.scale.set(2, 2);
    aeon_icon.updateHitbox();
	insert(members.indexOf(camHUD), aeon_icon);
    add(aeon_icon); 

}

function create()
{   
//    scoreTxt.screenCenter(FlxAxes.X);
    scoreAllowedToBop = false;
//    scoreTxt.y = PlayState.downscroll ? 50 : 700;
  //  scoreTxt.font = Paths.font('maverick.ttf');
    //scoreTxt.antialiasing = false;
  //  scoreTxt.borderSize = 0;
//    game.timeBar.y = -999;
  //  game.timeTxt.y = -999;

 //   modManager.setValue("opponentSwap", 1);


 /*   modManager.setValue("transform0X", -25, 0);
    modManager.setValue("transform1X", -25, 0);
    modManager.setValue("transform2X", -25, 0);
    modManager.setValue("transform3X", -25, 0);
    modManager.setValue("transform0X", 25, 1);
    modManager.setValue("transform1X", 25, 1);
    modManager.setValue("transform2X", 25, 1);
    modManager.setValue("transform3X", 25, 1);*/
}

var s:Float = 1;
override function update(elapsed:Float){
    actualBar.percent = (health / 2) * 100;
    FlxG.watch.addQuick('percent', actualBar.percent);
    camZooming = false;
    s += elapsed;
    if(supersonic)
    {
        boyfriend.y = FlxMath.lerp(boyfriend.y, -180 + (Math.cos(s) * 35), FlxMath.bound(1, 0, elapsed * 4));
    }
}

function Postupdate(elapsed:Float){
    scoreTxt.text = scoreTxt.text.toUpperCase();
}

/*function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Sonic Events':
        switch(value1)
        {
            case 'transform':
                boyfriend.playAnim('transform', true);
                boyfriend.specialAnim = true;
                FlxTween.tween(game.boyfriendGroup, {y: game.boyfriendGroup.y - 90}, 0.35, {ease: FlxEase.quartOut}); 
            case 'super sonic':
                game.camGame.flash(0xFFFFFFFF, 1.0);
                game.triggerEventNote('Change Character', 'BF', 'supersonic');
                supersonic = true;
            case 'blackscreen fade':
                FlxTween.tween(blackScreen, {alpha: 0}, 10, {ease: FlxEase.linear}); 
            case 'blackscreen in':
                game.camGame.alpha = 0;
            case 'blackscreen out':
                game.camGame.alpha = 1;
            case 'black':
                blackScreen.alpha = 1;
            case 'middle':
                switch(value2)
                {
                    case 'on':
                        game.camFollow.set(675, 450);
                        game.isCameraOnForcedPos = true;
                    case 'off':
                        game.isCameraOnForcedPos = false;
                }

        }
    }
}
*/

function onGameOverStart() 
{
    setGameOverVideo('FFSonic_Gameover');
}

function onSongStart()
{
FlxTween.tween(blackScreen, {alpha: 0}, 10, {ease: FlxEase.linear}); 
}