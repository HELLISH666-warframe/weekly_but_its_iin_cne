import haxe.io.Bytes;
import funkin.backend.utils.DiscordUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import funkin.backend.MusicBeatState;
// I'm ngl this whole state is kind of a mess since i had to do it in a day and a half so sorry if this shit is weird
import funkin.menus.StoryMenuState.StoryWeeklist;

var canClick:Bool = true;
var norbertcanIdle:Bool = false; // dumb and gay my b
var inTransiton:Bool = false;

var optionGrp:FlxTypedGroup<FlxSprite> = null;
var coins:Null<FlxTypedGroup<FlxSprite>> = null;
var options:Array<String> = [
	'freeplay',
	'marathon',
	'more', // Gallery + Credits
	'left', // arrows that change the week you have selected
	'right',
	'play', // basically story mode
	'options',
	'fc', // For marathon mode
	'reset' // For marathon mode
];

var norbert:FlxSprite;
var coin:FlxSprite;
var staticSprite:FlxSprite;
var border:FlxSprite;
var bar:FlxSprite;
var bg:FlxSprite;
var fakeEna:FlxSprite;

static var curWeek:Int = 0;
public var weekList:StoryWeeklist;
var loadedWeeks:Array<WeekData> = [];
var weeklogo:FlxSprite;
// Text
var txtTracklist,scoreText,newsTxt1,newsTxt2,tweakTxt;

var imagePrefix:String = 'mainmenu/'; // Gets changed to 'mainmenu/gold/' when gold mode is on. Just makes it so we dont need to check everytime we change an image for a gold version
	// Marathon mode stuff
var easterSeeds:Array<String> = ['weekly', 'goodluck', 'abc', 'cba', 'johnny', 'communitygame', 'lore', 'cloverderus', 'jammy', 'ito', 'maddie', 'krea', 'leth', 'crossknife', 'niffirg', 'kloogy', 'kat', 'dtwo', 'jam', 'kino', 'mocha', 'alpha', 'star', 'dollie', 'basil', 'biddle', 'scrumbo', 'loggo', 'ava', 'kye', 'srife', 'flag', 'cee', 'shittly', '909189', 'penkaru'];
public static var marathon:Bool = false;
public static var fcMode:Bool;
public static var weekArray:Array<Int> = [];
public static var marathonWeek:Int = 0;
public static var marathonArray:Array<String> = [];
public static var songAmount:Int = 63;

function create() {
	CoolUtil.playMenuSong(true);
	weeklist = StoryWeeklist.get(true, false);
	trace(weeklist.weeks[1].songs);
	marathon = false;
	weekArray = [];
	marathonWeek = 0;
	marathonArray = [];
	FlxG.mouse.visible = true;

	PlayState.isStoryMode = true;
	if(curWeek >= weeklist.weeks.length) curWeek = 0;

	DiscordUtil.changePresenceSince("In the Menus", null);

	persistentUpdate = persistentDraw = true;

	var num:Int = 0;

	//if(ClientPrefs.gold == true) imagePrefix = 'mainmenu/gold/';
		
	var fakestageBG = new FlxSprite(-1357, -739).loadGraphic(Paths.image('mainmenu/newsSet/bg'));
    fakestageBG.antialiasing = options.antialiasing;
    add(fakestageBG);

	var lights = new FlxSprite(-1345.15, -852.55).loadGraphic(Paths.image('mainmenu/newsSet/lights'));
    lights.antialiasing = options.antialiasing;
    add(lights);

	bg = new FlxSprite(-7, -9).loadGraphic(Paths.image(imagePrefix + 'bg'));
    bg.antialiasing = options.antialiasing;
    add(bg);

	coins = new FlxTypedGroup<FlxSprite>();
	add(coins);

	txtTracklist = new FlxText(872, 63,0, "", 25);
    txtTracklist.alignment = 'left';
	txtTracklist.font = "VCR OSD Mono";
	txtTracklist.color = 0xffffffff;
	txtTracklist.antialiasing = options.antialiasing;
	add(txtTracklist);

	tweakTxt = new FlxText(1110, 63,0, "TWEAK 0", 25);
    tweakTxt.alignment = 'right';
	tweakTxt.font = "VCR OSD Mono";
	tweakTxt.color = 0xffffffff;
	tweakTxt.antialiasing = options.antialiasing;
	add(tweakTxt);

	scoreText = new FlxText(872, 63,0, "", 25);
	scoreText.alignment = 'left';
	scoreText.font = "VCR OSD Mono";
	scoreText.color = 0xffffffff;
	scoreText.antialiasing = options.antialiasing;
	add(scoreText);

	weeklogo = new FlxSprite(170, 180).loadGraphic(Paths.image('mainmenu/logos/weeklogo'));
    weeklogo.antialiasing = options.antialiasing;
    add(weeklogo);

	staticSprite = new FlxSprite(168, 181.2);
	staticSprite.frames = Paths.getSparrowAtlas('mainmenu/logos/static');
    staticSprite.antialiasing = options.antialiasing;
	staticSprite.animation.addByPrefix('static', 'static0', 24, true);
	staticSprite.animation.addByPrefix('change', 'static change0', 24, false);
	staticSprite.animation.addByPrefix('change end', 'static change0', 24, false); //Lazyyyy
	staticSprite.visible = false;
	add(staticSprite);

	norbert = new FlxSprite(-100, 247);
	norbert.frames = Paths.getSparrowAtlas(imagePrefix + 'norbert');
    norbert.antialiasing = options.antialiasing;
	norbert.updateHitbox();
	norbert.animation.addByPrefix('intro', 'intro', 24, false);
	norbert.animation.addByPrefix('idle', 'idle', 24, false);
	norbert.animation.addByPrefix('idle-alt', 'alt', 24, false);
	norbert.animation.addByPrefix('start', 'start', 24, false);
	norbert.animation.addByPrefix('transition', 'trans', 24, false);
	norbert.visible = false;
	add(norbert);
	new FlxTimer().start(0.50, function(tmr:FlxTimer)
	{
		norbert.visible = true;
		norbert.animation.play('intro');
	});
	new FlxTimer().start(2, function(tmr:FlxTimer){
		norbertcanIdle = true;
	});

	var counter = new FlxSprite(223.1, 566.1).loadGraphic(Paths.image('mainmenu/newsSet/counter'));
    counter.antialiasing = options.antialiasing;
    add(counter);

	var fakeBF:FlxSprite = new FlxSprite(1300, 700).loadGraphic(Paths.image('mainmenu/newsSet/fakeBF'));
    fakeBF.antialiasing = options.antialiasing;
    add(fakeBF);

	var fakegf:FlxSprite = new FlxSprite(526, 607).loadGraphic(Paths.image('mainmenu/newsSet/goatGF'));
	fakegf.antialiasing = options.antialiasing;
	add(fakegf);

	fakeEna = new FlxSprite(-175, 375).loadGraphic(Paths.image('mainmenu/newsSet/fakeEna'));
    fakeEna.antialiasing = options.antialiasing;
	fakeEna.alpha = 0;
    add(fakeEna);

	bar = new FlxSprite().makeGraphic(1233, 141);
	bar.color = /*ClientPrefs.gold ? 0xFFC05B1B :*/ FlxColor.BLACK;
	bar.screenCenter(FlxAxes.X);
	bar.y = 553.45;
	add(bar);

	newsTxt1 = new FlxText(1060, 562,0, "BREAKING NEWS!!! BREAKING NEWS!!! ", 40);
	newsTxt1.alignment = 'left';
	newsTxt1.font = "VCR OSD Mono";
	newsTxt1.color = 0xffffffff;
	newsTxt1.antialiasing = options.antialiasing;
	add(newsTxt1);
	FlxTween.tween(newsTxt1, {x: -734}, 4.25, {type: FlxTween.LOOPING}); 

	newsTxt2 = new FlxText(40, 562,0, "BREAKING NEWS!!! BREAKING NEWS!!! ", 40);
	newsTxt2.alignment = 'left';
	newsTxt2.font = newsTxt1.font;
	newsTxt2.color = 0xffc25656;
	newsTxt2.antialiasing = options.antialiasing;
	newsTxt2.color = newsTxt1.color;
	newsTxt2.x = newsTxt1.x;
	add(newsTxt2);
	FlxTween.tween(newsTxt2, {x: -734}, 4.25, {startDelay: 2.0, type: FlxTween.LOOPING}); 
		
	border = new FlxSprite(-19, -23);
	border.loadGraphic(Paths.image(imagePrefix + 'border'));
    border.antialiasing = options.antialiasing;
    add(border);

	optionGrp = new FlxTypedGroup<FlxSprite>();
    for(i in 0...options.length){
        var button = new FlxSprite();

		if (i == 7) {
			button.frames = Paths.getSparrowAtlas('mainmenu/button_'+options[i]);
			button.animation.addByPrefix('idleon', 'on0', 24, false);
        	button.animation.addByPrefix('hoveron', 'on hover0', 24, false);
			button.animation.addByPrefix('idleoff', 'off0', 24, false);
            button.animation.addByPrefix('hoveroff', 'off hover0', 24, false);
		}
		else {
			if (i == 8) button.frames = Paths.getSparrowAtlas('mainmenu/button_'+options[i]);
			else button.frames = Paths.getSparrowAtlas(imagePrefix + 'button_'+options[i]);
			button.animation.addByPrefix('idle', options[i]+'0', 24, false);
           	button.animation.addByPrefix('hover', options[i]+ ' hover0', 24, false);
		}
        button.x = optionGrp.members[i - 1] != null ? optionGrp.members[i - 1].x + 262 : 44;
		button.y = 41;
        button.antialiasing = options.antialiasing;
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
	optionGrp.members[6].x = -70; //options
	optionGrp.members[6].y = 550;
	optionGrp.members[7].x = 220; //fc
	optionGrp.members[7].y = 605;
	optionGrp.members[8].x = optionGrp.members[7].x + 262; //reset
	optionGrp.members[8].y = optionGrp.members[7].y;

	optionGrp.members[7].visible = optionGrp.members[7].active = false;
	optionGrp.members[8].visible = optionGrp.members[8].active = false;

	changeWeek(0);
	Conductor.changeBPM(102);
}

function beatHit() {
	if(norbertcanIdle) {
		norbert.offset.set(-1013, -4);
		norbert.animation.play('idle', true);
	}
}
function update(elapsed:Float) {
	/*

	lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
	if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

	lerpMarathonScore = Math.floor(FlxMath.lerp(lerpMarathonScore, intendedMarathonScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
	if(Math.abs(intendedMarathonScore - lerpMarathonScore) < 10) lerpMarathonScore = intendedMarathonScore;

	if (!marathon) scoreText.text = "SCORE:" + lerpScore;

	if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;

	*/
	//@:privateAccess
	if (FlxG.sound.music.volume < 0.8 && inTransiton == false) {
		FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
	}

	if (optionGrp != null) {
		for(i in optionGrp.members){ 
			if(FlxG.mouse.overlaps(i) && canClick){ //if hovering over a button
				if (i == optionGrp.members[7]){ //if button is fc mode
					if (fcMode == true)
						optionGrp.members[7].animation.play('hoveron');
					else
						optionGrp.members[7].animation.play('hoveroff');
					if(FlxG.mouse.justPressed && canClick) selectOption(i.ID);
				}
				else{ //if button is not fc mode
				i.animation.play('hover');
				if(FlxG.mouse.justPressed && canClick) selectOption(i.ID);
				}
			}else{ //if not hovering over a button
				if (i == optionGrp.members[7]) //if button is fc mode
					if (fcMode == true) optionGrp.members[7].animation.play('idleon');
					else optionGrp.members[7].animation.play('idleoff');
				else //if button is not fc mode
				i.animation.play('idle');
			}
		}
	}
	if (controls.SWITCHMOD||FlxG.keys.justPressed.SEVEN) {
		import funkin.menus.ModSwitchMenu; import funkin.editors.EditorPicker;
		controls.SWITCHMOD ? openSubState(new ModSwitchMenu()) :openSubState(new EditorPicker());
		persistentUpdate = !persistentDraw;
	}
	if (controls.BACK) {
		CoolUtil.playMenuSFX('CANCEL', 0.7);
		FlxG.switchState(new ModState('weekly/FreeplayState'));
	}
}
	
function selectOption(id:Int){
	canClick = false;
	switch(options[id]){
		case 'play':
			if (curWeek == 10) {
				tweak10Select();
				inTransiton = true;
			} else {
				normalSelect();
				selectWeek();
			}	
		case 'freeplay':
			FlxG.switchState(new FreeplayState());
			marathon = false;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = false;
		case 'options':
			import funkin.options.OptionsMenu;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = false;
			FlxG.switchState(new OptionsMenu());
		case 'left': changeWeek(-1);
			canClick = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		case 'right': changeWeek(1);
			canClick = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		case 'marathon':
			switch(marathon){
				case true: updateMarathon(false);
				case false: updateMarathon(true);
			}
			updateText();
			canClick = true;
		case 'fc':
			if (optionGrp.members[7].active == true){
				switch(fcMode){
					case true: fcMode = false;
					case false: fcMode = true;
				}
			}
			canClick = true;
		case 'more':
			MusicBeatState.switchState(new WeeklyGalleryState());
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = true;
	}
}

function normalSelect() {
	FlxG.sound.play(Paths.sound('confirmMenu'));
	FlxG.mouse.visible = false;
	norbertcanIdle = false;
	norbert.offset.set(-970, -9);
	norbert.animation.play('start', true);
}

function tweak10Select() {
	//FadeTransitionSubstate.tweak10 = true;
	FlxG.sound.play(Paths.sound('tweak10intro'));
	staticSprite.visible = true;
	FlxG.mouse.visible = false;
	weeklogo.visible = false;
	FlxG.sound.music.volume = 0;
	staticSprite.animation.play('change', true);
	if(staticSprite.animation.curAnim.name == 'change') //If theres a better way to handle this lmk but i think this is better than checking on every beat hit
			{
				staticSprite.animation.play('static', true);
			}	
		else if(staticSprite.animation.curAnim.name == 'change end') //If theres a better way to handle this lmk but i think this is better than checking on every beat hit
			{
				staticSprite.visible = false;
			}	
	new FlxTimer().start(0.35, function(tmr:FlxTimer) {
		norbertcanIdle = false;
		norbert.offset.set(-983, 9);
		norbert.animation.play('transition', true);
	});
	FlxTween.tween(FlxG.camera, {zoom: 0.35}, 2.25, {ease: FlxEase.expoInOut, startDelay: 2.5});   
	optionGrp.forEach(function(obj:FlxSprite) {
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
	new FlxTimer().start(4.75, function(tmr:FlxTimer) {
		staticSprite.animation.play('change end', true);
	});
		new FlxTimer().start(5.0, function(tmr:FlxTimer) {
			selectWeek();
			MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
			skipTransition = true;
	});
}

var lerpScore:Int = 0;
var lerpMarathonScore:Int = 0;
var intendedScore:Int = 0;
var intendedMarathonScore:Int = 0;
	
function changeWeek(change:Int = 0):Void {
	curWeek += change;

	if (curWeek >= weeklist.weeks.length) curWeek = 0;
	if (curWeek < 0) curWeek = weeklist.weeks.length - 1;

	var leWeek = weeklist.weeks[curWeek];
	var bullShit:Int = 0;

	weeklogo.visible = true;
	var assetName:String = weeklist.weeks[curWeek];
	if(assetName == null || assetName.length < 1) {
		weeklogo.visible = false;
	} else {
		if (!marathon) weeklogo.loadGraphic(Paths.image('mainmenu/logos/' + curWeek));
	}
	if (!marathon) updateText();
}

var selectedWeek:Bool = false;

function selectWeek() {
	selectedWeek = true;

	new FlxTimer().start(0.75, function(tmr:FlxTimer) {
		PlayState.loadWeek(weeklist.weeks[curWeek], 'hard');
		FlxG.switchState(new PlayState());
	});
}

public function updateCoins() {
	if (coins != null){
		if (Highscore.getMarathonWins() > 0 && marathon == true){
			for (i in 0...Highscore.getMarathonWins()){
				coin = new FlxSprite(1150, 60).loadGraphic(Paths.image('mainmenu/bosscoin'));
				weeklogo.antialiasing = options.antialiasing;
				coin.x -= (7 * i);
				coins.add(coin);
			}
		}
		else if (coins.countLiving() != -1){
			for (i in coins) i.destroy();
			coins.clear();
		}
	}
}

function updateMarathon(mara:Bool) {
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
		changeWeek(0);
		optionGrp.members[7].visible = optionGrp.members[7].active = false;
		optionGrp.members[8].visible = optionGrp.members[8].active = false;
		optionGrp.members[3].visible = optionGrp.members[3].active = true;
		optionGrp.members[4].visible = optionGrp.members[4].active = true;
		newsTxt1.text = "BREAKING NEWS!!! BREAKING NEWS!!! ";
		newsTxt2.text = "BREAKING NEWS!!! BREAKING NEWS!!! ";
		updateCoins();
	}
}
function updateText() {
	var leWeek = weeklist.weeks[curWeek];
	var stringThing:Array<String> = [];
	stringThing.push('TRACK LIST:');
	for (i in 0...weeklist.weeks[curWeek].songs.length) stringThing.push(weeklist.weeks[curWeek].songs[i].name);
	if(curWeek == 6) // So it displays as "666"
	{
		tweakTxt.text = 'TWEAK 666';
		tweakTxt.x = 1110 - 30;
	}
	else
	{
		tweakTxt.text = 'TWEAK '+curWeek;
		if(curWeek == 10) // moves the text into the correct spot
		{
			tweakTxt.x = 1110 - 15;
			stringThing.remove('Buds and Bluds'); // fuck my gay baka life
		}
		else tweakTxt.x = 1110;
	}
	tweakTxt.updateHitbox();

	txtTracklist.text = '';
	for (i in 0...stringThing.length) txtTracklist.text += stringThing[i] + '\n';

	txtTracklist.text = txtTracklist.text;
	txtTracklist.updateHitbox();

	scoreText.y = txtTracklist.height + 60;

	/*#if !switch
	intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, 'hard');
	intendedMarathonScore = Highscore.getMarathonScore();
	#end*/
}