//import gameObjects.shader.Shaders.FuckingTriangleEffect;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
//import meta.states.substate.FadeTransitionSubstate;
import flixel.addons.transition.FlxTransitionableState;
//import flixel.addons.ui.FlxUIInputText;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import funkin.backend.scripting.events.WeekSelectEvent;
import meta.data.WeekData;
// I'm ngl this whole state is kind of a mess since i had to do it in a day and a half so sorry if this shit is weird
import StringTools;


{
	public var weeks:Array<WeekData> = [];
	// This is our current version dont forget to change it when compiling releases
	public static var psychEngineVersion:String = 'Tweak 10.1.1'; //MAKE SURE THIS IS UP TO DATE SINCE IT MATTERS FOR AUTO UPDATING !!!!
	//public static var curSelected:Int = 0;
	var canClick:Bool = true;
	var inTransiton:Bool = false;

	var optionGrp:FlxTypedGroup<FlxSprite> = null;
	var coins:Null<FlxTypedGroup<FlxSprite>> = null;
	var options:Array<String> = [
		'freeplay',
		'more', // Gallery + Credits
		'left', // arrows that change the week you have selected
		'right',
		'play', // basically story mode
		'options',
	];

	//var debugKeys:Array<FlxKey>;
	var norbert:FlxSprite;
	var coin:FlxSprite;
	var staticSprite:FlxSprite;
	var border:FlxSprite;
	var bar:FlxSprite;
	var bg:FlxSprite;
	var fakeEna:FlxSprite;

	var curWeek:Int = 0;
	public var loadedWeeks:Array<WeekData> = [];
	var weeklogo:FlxSprite;
	 static var lastDifficultyName:String = '';
	// Text
	var txtTracklist:FlxText;
	var scoreText:FlxText;
	var newsTxt1:FlxText;
	var newsTxt2:FlxText;
	var tweakTxt:FlxText;

	var imagePrefix:String = 'mainmenu/'; // Gets changed to 'mainmenu/gold/' when gold mode is on. Just makes it so we dont need to check everytime we change an image for a gold version

	override function create()
	{
		weekArray = [];
		FlxG.mouse.visible = true;

//		WeekData.loadTheFirstEnabledMod();

		PlayState.isStoryMode = true;
//		WeekData.reloadWeekFiles(true);
	//	if(curWeek >= WeekData.weeksList.length) curWeek = 0;

		//debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		persistentUpdate = persistentDraw = true;

		var num:Int = 0;
	/*	for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			loadedWeeks.push(weekFile);
			WeekData.setDirectoryFromWeek(weekFile);
			num++;
		}
*/
	//	WeekData.setDirectoryFromWeek(loadedWeeks[0]);
	//	CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		
		var lights = new FlxSprite(-1345.15, -852.55).loadGraphic(Paths.image('mainmenu/newsSet/lights'));
        lights.antialiasing = true;
        add(lights);

		bg = new FlxSprite(-7, -9).loadGraphic(Paths.image(imagePrefix + 'bg'));
        bg.antialiasing = true;
        add(bg);

	//	coins = new FlxTypedGroup<FlxSprite>();
		coins = new FlxTypedGroup();
		add(coins);

		txtTracklist = new FlxText(872, 63, "", 25);
        txtTracklist.alignment = 'LEFT';
		txtTracklist.font = "VCR OSD Mono";
		txtTracklist.color = 0xffffffff;
		txtTracklist.antialiasing = true;
		add(txtTracklist);

		tweakTxt = new FlxText(1110, 63, "TWEAK 0", 25);
        tweakTxt.alignment = 'RIGHT';
		tweakTxt.font = "VCR OSD Mono";
		tweakTxt.color = 0xffffffff;
		tweakTxt.antialiasing = true;
		add(tweakTxt);

		scoreText = new FlxText(872, 63, "", 25);
		scoreText.alignment = 'LEFT';
		scoreText.font = "VCR OSD Mono";
		scoreText.color = 0xffffffff;
		scoreText.antialiasing = true;
		add(scoreText);

		weeklogo = new FlxSprite(170, 180).loadGraphic(Paths.image('mainmenu/logos/weeklogo'));
        weeklogo.antialiasing = true;
        add(weeklogo);

		staticSprite = new FlxSprite(168, 181.2);
		staticSprite.frames = Paths.getSparrowAtlas('mainmenu/logos/static');
        staticSprite.antialiasing = true;
		staticSprite.animation.addByPrefix('static', 'static0', 24, true);
		staticSprite.animation.addByPrefix('change', 'static change0', 24, false);
		staticSprite.animation.addByPrefix('change end', 'static change0', 24, false); //Lazyyyy
		staticSprite.visible = false;
		add(staticSprite);

	//	optionGrp = new FlxTypedGroup<FlxSprite>();
		optionGrp = new FlxTypedGroup();
        for(i in 0...options.length){
            var button = new FlxSprite();

			if (i == 7)
			{
				button.frames = Paths.getSparrowAtlas('mainmenu/button_' +i);
				button.animation.addByPrefix('idleon', 'on0', 24, false);
            	button.animation.addByPrefix('hoveron', 'on hover0', 24, false);
				button.animation.addByPrefix('idleoff', 'off0', 24, false);
            	button.animation.addByPrefix('hoveroff', 'off hover0', 24, false);
			}
			else
			{
				if (i == 8)
				{
					button.frames = Paths.getSparrowAtlas('mainmenu/button_' +options[i]);
				}
				else
				{
					button.frames = Paths.getSparrowAtlas(imagePrefix + 'button_' +options[i]);
				}
				button.animation.addByPrefix('idle', '' +options[i] +'0', 24, false);
           	 	button.animation.addByPrefix('hover', '${options[i]} hover0', 24, false);
			}
            button.x = optionGrp.members[i - 1] != null ? optionGrp.members[i - 1].x + 262 : 44;
			button.y = 41;
            button.antialiasing = true;
            button.ID = i;
			button.updateHitbox();
            optionGrp.add(button);
        }
        add(optionGrp);

		optionGrp.members[3].x = 60; //left arrow
		optionGrp.members[3].y = 224;
		optionGrp.members[4].x = 729; //right arrow
		optionGrp.members[4].y = optionGrp.members[3].y;
		optionGrp.members[5].x = 1046; //play
		optionGrp.members[5].y = 491;

		changeWeek();

		Conductor.changeBPM(102);
		Conductor.bpmChangeMap = []; //So the BPMChangeMap is never fucking cleared after a song is over for what god damn reason i have no idea but it seems thats the case
	}

	var lastBeatHit:Int = -1;
	override function beatHit()
	{

		if(lastBeatHit >= curBeat) {
			//trace('BEAT HIT: ' + curBeat + ', LAST HIT: ' + lastBeatHit);
			return;
		}

		lastBeatHit = curBeat;
	}

	override public function update(elapsed:Float)
	{

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;

		@:Access
		if (FlxG.sound.music.volume < 0.8 && inTransiton == false)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (controls.BACK && inTransiton == false)
		{
			if (!seedInput.hasFocus){
				canClick = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}
		}
	}
	
	function selectOption(id:Int){
		canClick = false;
		switch(options[id]){
			case 'play':
				if (curWeek == 10)
				{
					tweak10Select();
					inTransiton = true;
				}
				else
				{
					normalSelect();
					selectWeek();
				}	
			case 'freeplay':
				MusicBeatState.switchState(new FreeplayState());
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.mouse.visible = false;
			case 'options':
				LoadingState.loadAndSwitchState(new meta.data.options.OptionsState());
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.mouse.visible = false;
				OptionsState.onPlayState = false;
			case 'left':
				changeWeek(-1);
				canClick = true;
				FlxG.sound.play(Paths.sound('scrollMenu'));
			case 'right':
				changeWeek(1);
				canClick = true;
				FlxG.sound.play(Paths.sound('scrollMenu'));
			case 'more':
	//			MusicBeatState.switchState(new WeeklyGalleryState()); //FuckingTriangleEffect
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.mouse.visible = true;
		}
	}

	function normalSelect()
	{
			FlxG.sound.play(Paths.sound('confirmMenu'));
		FlxG.mouse.visible = false;
		norbertcanIdle = false;
		norbert.offset.set(-970, -9);
		norbert.animation.play('start', true);
	}

	function tweak10Select()
	{
	//	FadeTransitionSubstate.tweak10 = true;
		FlxG.sound.play(Paths.sound('tweak10intro'));
		staticSprite.visible = true;
		FlxG.mouse.visible = false;
		weeklogo.visible = false;
		FlxG.sound.music.volume = 0;
		staticSprite.animation.play('change', true);
		/*staticSprite.animation.finishCallback = (name:String = 'intro')->{
		if(staticSprite.animation.curAnim.name == 'change') //If theres a better way to handle this lmk but i think this is better than checking on every beat hit
			{
				staticSprite.animation.play('static', true);
			}	
		else if(staticSprite.animation.curAnim.name == 'change end') //If theres a better way to handle this lmk but i think this is better than checking on every beat hit
			{
				staticSprite.visible = false;
			}	
		}*/
		new FlxTimer().start(0.35, function(tmr:FlxTimer)
		{
			norbertcanIdle = false;
			norbert.offset.set(-983, 9);
			norbert.animation.play('transition', true);
		});
		FlxTween.tween(FlxG.camera, {zoom: 0.35}, 2.25, {ease: FlxEase.expoInOut, startDelay: 2.5});   
		optionGrp.forEach(function(obj:FlxSprite)
		{
			FlxTween.tween(obj, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5});  
		});
		FlxTween.tween(border, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(bar, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(bg, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(newsTxt1, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(newsTxt2, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(scoreText, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(tweakTxt, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(txtTracklist, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(fakeEna, {alpha: 1}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		new FlxTimer().start(4.75, function(tmr:FlxTimer)
		{
			staticSprite.animation.play('change end', true);
		});
		new FlxTimer().start(5.0, function(tmr:FlxTimer)
		{
			selectWeek();
		});
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	
	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length - 1)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 2;

		trace(curWeek);		

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var bullShit:Int = 0;

		weeklogo.visible = true;
		var assetName:String = leWeek.weeklogo;
		if(assetName == null || assetName.length < 1) {
			weeklogo.visible = false;
		}
		PlayState.storyWeek = curWeek;
	}

	var selectedWeek:Bool = false;

	function selectWeek()
	{
		var songArray:Array<String> = [];
		var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
		for (i in 0...leWeek.length) {
			songArray.push(leWeek[i][0]);
		}

		// Nevermind that's stupid lmao
		PlayState.storyPlaylist = songArray;
		PlayState.isStoryMode = true;
		selectedWeek = true;

	//	PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.campaignScore = 0;
		PlayState.campaignMisses = 0;

		new FlxTimer().start(0.75, function(tmr:FlxTimer)
		{
			LoadingState.loadAndSwitchState(new PlayState(), true);
			FreeplayState.destroyFreeplayVocals();
		});
	}

	/*function updateMarathon(mara:Bool)
	{
		if (mara == true){
			marathon = true;
			weeklogo.loadGraphic(Paths.image('mainmenu/logos/marathon'));
			FlxG.sound.play(Paths.sound('scrollMenu'));
			txtTracklist.size = 21;
			optionGrp.members[7].visible = optionGrp.members[7].active = true;
			optionGrp.members[8].visible = optionGrp.members[8].active = true;
			optionGrp.members[3].visible = optionGrp.members[3].active = false;
			optionGrp.members[4].visible = optionGrp.members[4].active = false;
			newsTxt1.text = "BREAKING NEWS!!! BREAKING NEWS!!! ";
			newsTxt1.text = "OH GOD!!! OH GOD!!! ";
			newsTxt2.text = "LOGGO TOLD ME TO REMOVE THE SWEAR WORDS!!! ";
			updateCoins();
		}
		else{
			marathon = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			txtTracklist.size = 25;
			changeWeek();
			optionGrp.members[7].visible = optionGrp.members[7].active = false;
			optionGrp.members[8].visible = optionGrp.members[8].active = false;
			optionGrp.members[3].visible = optionGrp.members[3].active = true;
			optionGrp.members[4].visible = optionGrp.members[4].active = true;
			newsTxt1.text = "BREAKING NEWS!!! BREAKING NEWS!!! ";
			newsTxt2.text = "BREAKING NEWS!!! BREAKING NEWS!!! ";
			updateCoins();
		}
	}
*/
	function updateText()
	{
		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		stringThing.push('TRACK LIST:');
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		if(curWeek == 6) // So it displays as "666"
		{
			tweakTxt.text = 'TWEAK 666';
			tweakTxt.x = 1110 - 30;
		}
		else
		{
			tweakTxt.text = 'TWEAK $curWeek';
			if(curWeek == 10) // moves the text into the correct spot
			{
				tweakTxt.x = 1110 - 15;
				stringThing.remove('Buds and Bluds'); // fuck my gay baka life
			}
			else
			{
				tweakTxt.x = 1110;
			}
		}
		tweakTxt.updateHitbox();

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text;
		txtTracklist.updateHitbox();

		scoreText.y = txtTracklist.height + 60;
	}
}