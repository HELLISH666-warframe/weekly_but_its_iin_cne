public var camHUDAlphaTween:FlxTween;

function onEvent(_) {
	if (_.event.name == 'hud_fade_SHARED') {
	if (camHUDAlphaTween != null) {
		camHUDAlphaTween.cancel();
		camHUDAlphaTween = null;
	}

	var leAlpha:Float = Std.parseFloat(_.event.params[0]);
	if(Math.isNaN(leAlpha)) leAlpha = 1;

	var duration:Float = Std.parseFloat(_.event.params[2]);
	if(Math.isNaN(duration)) duration = 1;

	if (duration > 0) {
		camHUDAlphaTween = FlxTween.tween(camHUD, {alpha: leAlpha}, duration, {ease: FlxEase.linear, onComplete:
		function (twn:FlxTween) {camHUDAlphaTween = null;}});
	} else camHUD.alpha = leAlpha;
	}
}