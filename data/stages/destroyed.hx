// I'm so exhausted man
var rainIntensity:Float = 0.2;
var rainShader; // ty base game
var rainTime:Float = 0;
var realSongLength:Float = 0;
var uScreenResolution:Array<Float> = [FlxG.width, FlxG.height];
var uCameraBounds:Array<Float> = [camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height];
public var defaultCamZoomAdd:Float = 0;
public var camZooming:Bool = false;
public var camZoomingDecay:Float = 1;

public var defaultHudZoom:Float = 1;
var rainShader:CustomShader = new CustomShader("rain");

//var mosaic = newShader("mosaic");
//var mosaicStrength:Float = 1;

var time:Float = 0;

var camCanZoom:Bool = true;
var camZoomOveride:Bool = false;

var leftpile:FlxSprite;
var rightpile:FlxSprite;

var videoString:String = 'bnb_gameover';

function create() {
    var sky:FlxSprite = new FlxSprite(-491, -800).loadGraphic(Paths.image('stages/bud/sky'));
    sky.antialiasing = true;
    sky.scrollFactor.set(0.5, 0.5);
    insert(0,sky);

    var city:FlxSprite = new FlxSprite(-575, -772).loadGraphic(Paths.image('stages/bud/city'));
    city.antialiasing = true;
    city.scrollFactor.set(0.6, 0.6);
    insert(1,city);

    var fire:FlxSprite = new FlxSprite(-1266, -375);
    fire.antialiasing = true;
    fire.scrollFactor.set(0.95, 0.95);
    fire.frames = Paths.getSparrowAtlas("stages/bud/fire");
    fire.animation.addByPrefix('idle', 'flicker0', 24, true);
    fire.animation.play("idle");
    insert(2,fire);
    
    var mainbg:FlxSprite = new FlxSprite(-1214, -945).loadGraphic(Paths.image('stages/bud/mainbg'));
    mainbg.antialiasing = true;
    insert(3,mainbg);

    leftpile = new FlxSprite(-1350, 126).loadGraphic(Paths.image('stages/bud/leftpile'));
    leftpile.antialiasing = true;
    leftpile.scrollFactor.set(1.1, 1.1);
    insert(4,leftpile);

    rightpile = new FlxSprite(1574, 138).loadGraphic(Paths.image('stages/bud/rightpile'));
    rightpile.antialiasing = true;
    rightpile.scrollFactor.set(1.1, 1.1);
    insert(5,rightpile);

    var addlayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/bud/add'));
    addlayer.antialiasing = true;
    addlayer.blend = 0;
    addlayer.alpha = 0.5;
    insert(5,addlayer);

    var multiplylayer:FlxSprite = new FlxSprite(-1207, -929).loadGraphic(Paths.image('stages/bud/multiply'));
    multiplylayer.antialiasing = true;
    multiplylayer.blend = 9; // ??????????
    insert(6,multiplylayer);

    blackStage = new FlxSprite(-1000, -750).makeGraphic(FlxG.width * 2.5, FlxG.height * 2.5, FlxColor.BLACK); // this is dumb and gay to have two of these but its ok
    blackStage.visible = false;
    blackStage.alpha = 0.5;
    insert(7,blackStage);

    rainShader.data.uScreenResolution.value = [uScreenResolution];
    rainShader.data.uScale.value = [FlxG.height / 300];
   // camGame.addShader(rainShader);

}
override function update(elapsed:Float)
{
    camFollow.x = 710;
    camFollow.y = 175;
    rainTime += elapsed;
    rainTime++; //My stupid way of making da rain faster
	rainShader.data.uCameraBounds.value = ([camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height]);
    rainShader.data.uTime.value = [rainTime];
    rainShader.data.uIntensity.value = [rainIntensity];
    

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