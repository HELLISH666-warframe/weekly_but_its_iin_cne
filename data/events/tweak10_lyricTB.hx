import flixel.text.FlxTextBorderStyle;
var text:FlxText;
function postCreate() {
	text = new FlxText();
    text.camera = camOther;
    text.setFormat(Paths.font("vcr.ttf"), 32, 0xFFcfa92d, 'center', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    text.text = '';
    text.color = 0xFFFFFFFF;
    text.antialiasing = true;
    text.screenCenter(FlxAxes.X);
    text.borderSize = 2;
    text.updateHitbox();
    text.y = 625;
    add(text);
}

function onEvent(_)
	if (_.event.name == 'tweak10_lyricTB') {
		text.text = _.event.params[0];
        text.updateHitbox();
        text.screenCenter(FlxAxes.X);
	}