import funkin.menus.StoryMenuState;
public var initialized:Bool = false;
override function create():Void
{
	if(!initialized)
		{
			persistentUpdate = true;
			persistentDraw = true;
		}
		if (skippedIntro) {
		}
}
override function update(elapsed:Float)
	{
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;
		var pressedSkip:Bool = false;
				if(pressedEnter)
				{
				transitioning = true;
				FlxG.switchState(new StoryMenuState());
				skipIntro();
			}
	}
	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			skippedIntro = true;
		}
	}