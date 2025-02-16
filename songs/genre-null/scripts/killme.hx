import flixel.text.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;

var camCanZoom:Bool = true;
var camZoomOveride:Bool = false;

var mosaicStrength:Float = 1;

var shit = null; //array of stuff from da HUD

var bossTweak:Float = 0;
var bfTweak:Float = 0;
var iconCanTweak:Bool = true;
var isSpinning:Bool = false;

function Create() {}
introLength = 0;
function onCountdown(event) event.cancel();
function postCreate(){
    lyrics = new FlxText(0,0,600, "", 32);
    lyrics.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics.cameras = [camHUD];
    lyrics.screenCenter(FlxAxes.X);
    lyrics.y = FlxG.height - 100;
    lyrics.alpha = 1;
    add(lyrics);
}

function onMoveCamera(){ 
}

function onUpdate(elapsed:Float)
{
}
function beatHit()
{
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 40:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = 'In your heart you feel';
            lyrics.screenCenter(FlxAxes.X);
        case 59:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = 'a voice thats crying out';
            lyrics.screenCenter(FlxAxes.X);
        case 88:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = 'lets end all conflict';
            lyrics.screenCenter(FlxAxes.X);
        case 112:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = 'here and';
            lyrics.screenCenter(FlxAxes.X);
        case 128:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = 'now';
            lyrics.screenCenter(FlxAxes.X);
        case 176 | 208:
            FlxTween.tween(lyrics, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
        case 188:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = "Let's ";
            lyrics.screenCenter(FlxAxes.X);
        case 192:
            lyrics.visible = true;
            lyrics.alpha = 0;
            lyrics.y = FlxG.height - 125;
            FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
            lyrics.text = "DANCE";
            lyrics.screenCenter(FlxAxes.X);
        case 288:
            isCameraOnForcedPos = true;
            camFollow.x = 5050;
            camFollow.y = 3400;
            camZooming = true;
            defaultCamZoom = 0.325;
        case 320:
            isCameraOnForcedPos = false
            defaultCamZoom = 0.5;

    }
}
function onSongStart(){
    lyrics.visible = true;
    lyrics.alpha = 0;
    lyrics.y = FlxG.height - 125;
    FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});
    lyrics.text = 'Constellations fall apart';
    lyrics.screenCenter(FlxAxes.X);
}