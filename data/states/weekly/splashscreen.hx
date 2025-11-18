import hxvlc.flixel.FlxVideoSprite;
var video = new FlxVideoSprite();

function create()
	new FlxTimer().start(1, ()->{
		add(video).load(Paths.video("intro"));
		video.play();
		video.bitmap.onEndReached.add(()-> destroy());
	});

function update(elapsed:Float) if (controls.ACCEPT && video != null) destroy();
function destroy() {
	video.stop();
	video.destroy();
	FlxG.switchState(new TitleState());
}