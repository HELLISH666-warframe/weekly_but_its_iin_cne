import flixel.text.FlxTextBorderStyle;
if(SONG.meta.card==null)return;
function postCreate() {
    SONG.meta.card.font ==null ? 'vcr.ttf' : SONG.meta.card.font;
	text = new FlxText(10, 10).setFormat(Paths.font(SONG.meta.card.font), 24, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    //text.antialiasing = ClientPrefs.globalAntialiasing;

	text.text = SONG.meta.card.name+'\n\nSong: '+SONG.meta.credits.music.join(', ')+'\nChart: '+SONG.meta.credits.chart.join(', ');

	bg = new FlxSprite().makeGraphic(Std.int(text.width + (10 * 2)), Std.int(text.height + (10 * 2)), FlxColor.BLACK);
    bg.alpha = 0.8;

	for(i in [bg,text]){
	i.screenCenter(FlxAxes.Y);
	//card.x = -card.width;
	i.x = -i.width;
	//add(card);
	}
}

function beatHit(curBeat:Int) {
	if (SONG.meta.card.expandBeat == curBeat && SONG.meta.card.expandBeat >= 0) display();
}

public function display() {
	add(bg);
    add(text);
	for(i in [bg,text]){
    var initX:Float = i.x;
	i.camera=camOther;

    FlxTween.tween(i, {x: initX + i.width}, 0.65, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) {
        FlxTween.tween(i, {x: initX}, 0.65, {ease: FlxEase.cubeInOut, startDelay: SONG.meta.card.duration, onComplete: function(twn:FlxTween) {
            i.destroy();
        }});
    }});
}
}