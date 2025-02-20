	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.P)
			FlxG.switchState(new ModState('WeeklyGalleryState'));
	}