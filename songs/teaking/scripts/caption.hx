import flixel.text.FlxTextBorderStyle;
var text:FlxText;

function postCreate() {
    text = new FlxText(1280, 100);
    text.camera = camHUD;
    text.setFormat(Paths.font("BRLNSDB.ttf"), 50, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    text.text = '';
    text.color = 0xFFFFFFFF;
    text.width = 100;
    text.antialiasing = true;
    text.updateHitbox();
    text.screenCenter(FlxAxes.X);
    text.screenCenter(FlxAxes.Y);
    text.borderSize = 3;
    add(text);
}

function caption(txt:String){
    text.text = txt;
    text.screenCenter(FlxAxes.X);
    text.screenCenter(FlxAxes.Y);
}