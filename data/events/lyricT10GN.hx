import flixel.text.FlxTextBorderStyle;
var lyrics:FlxText;
function postCreate() {
	lyrics = new FlxText(0,0,600, "").setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics.camera = camOther;
    lyrics.screenCenter(FlxAxes.X);
    lyrics.y = FlxG.height - 100;
    lyrics.alpha = 1;
    add(lyrics);
}

function onEvent(_) {
	if (_.event.name == 'lyricT10GN') {
		if(_.event.params[0]!=null){
			lyrics.visible = true;
			lyrics.alpha = 0;
			lyrics.y = FlxG.height - 125;
			FlxTween.tween(lyrics, {alpha: 1, y: FlxG.height - 100}, 0.25, {ease: FlxEase.expoOut});

			lyrics.text = _.event.params[0];
			lyrics.screenCenter(FlxAxes.X);
		}
		else FlxTween.tween(lyrics, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
	}
}