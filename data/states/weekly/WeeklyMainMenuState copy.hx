import Xml;
//import meta.states.substate.FadeTransitionSubstate;
import flixel.addons.transition.FlxTransitionableState;
import funkin.backend.MusicBeatState;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
var weeklogo:FlxSprite;
var norbertcanIdle:Bool = false;
public static var fcMode:Bool;
public static var marathon:Bool = false;
var imagePrefix:String = 'mainmenu/';
var canClick:Bool = true;
var optionGrp:FlxTypedGroup = null;
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
override function create()
{

	FlxG.mouse.visible = true;
	var fakestageBG = new FlxSprite(-1357, -739).loadGraphic(Paths.image('mainmenu/newsSet/bg'));
	fakestageBG.antialiasing = true;
	insert(1, fakestageBG);
	add(fakestageBG);

	var lights = new FlxSprite(-1345.15, -852.55).loadGraphic(Paths.image('mainmenu/newsSet/lights'));
	lights.antialiasing = true;
	insert(2, lights);
	add(lights);

	bg = new FlxSprite(-7, -9).loadGraphic(Paths.image('mainmenu/bg'));
	bg.antialiasing = true;
	insert(29, bg);
	add(bg);

	staticSprite = new FlxSprite(168, 181.2);
	staticSprite.frames = Paths.getSparrowAtlas('mainmenu/logos/static');
	staticSprite.antialiasing = true;
	staticSprite.animation.addByPrefix('static', 'static0', 24, true);
	staticSprite.animation.addByPrefix('change', 'static change0', 24, false);
	staticSprite.animation.addByPrefix('change end', 'static change0', 24, false); //Lazyyyy
	staticSprite.visible = false;
	insert(5, staticSprite);
	add(staticSprite);

	norbert = new FlxSprite(-100, 247);
	norbert.frames = Paths.getSparrowAtlas('mainmenu/norbert');
	norbert.antialiasing = true;
	norbert.updateHitbox();
	norbert.animation.addByPrefix('intro', 'intro', 24, false);
	norbert.animation.addByPrefix('idle', 'idle', 24, false);
	norbert.animation.addByPrefix('idle-alt', 'alt', 24, false);
	norbert.animation.addByPrefix('start', 'start', 24, false);
	norbert.animation.addByPrefix('transition', 'trans', 24, false);
	norbert.visible = false;

	counter = new FlxSprite(223.1, 566.1).loadGraphic(Paths.image('mainmenu/newsSet/counter'));
	counter.antialiasing = true;

	var fakeBF:FlxSprite = new FlxSprite(1300, 700).loadGraphic(Paths.image('mainmenu/newsSet/fakeBF'));
	fakeBF.antialiasing = true;
	add(fakeBF);

	fakegf = new FlxSprite(526, 607).loadGraphic(Paths.image('mainmenu/newsSet/goatGF'));
	fakegf.antialiasing = true;

	fakeEna = new FlxSprite(-175, 375).loadGraphic(Paths.image('mainmenu/newsSet/fakeEna'));
	fakeEna.antialiasing = true;
	fakeEna.alpha = 0;
	add(fakeEna);

	bar = new FlxSprite().makeGraphic(1233, 141);
	bar.color =  FlxColor.BLACK;
	bar.screenCenter(FlxAxes.X);
	bar.y = 553.45;

	newsTxt1 = new FlxText(1060, 562, 0,"BREAKING NEWS!!! BREAKING NEWS!!! ",40);
	newsTxt1.alignment = 'LEFT';
	newsTxt1.font = "VCR OSD Mono";
	newsTxt1.color = 0xffffffff;
	newsTxt1.antialiasing = true;
	FlxTween.tween(newsTxt1, {x: -734}, 4.25, {type: FlxTween.LOOPING}); 

	newsTxt2 = new FlxText(40, 562, 0, "BREAKING NEWS!!! BREAKING NEWS!!! ", 40);
	newsTxt2.alignment = 'LEFT';
	newsTxt2.font = newsTxt1.font;
	newsTxt2.color = 0xffc25656;
	newsTxt2.antialiasing = true;
	newsTxt2.color = newsTxt1.color;
	newsTxt2.x = newsTxt1.x;
	FlxTween.tween(newsTxt2, {x: -734}, 4.25, {startDelay: 2.0, type: FlxTween.LOOPING}); 
			
	border = new FlxSprite(-19, -23);
	border.loadGraphic(Paths.image('mainmenu/border'));
	border.antialiasing = true;

	optionGrp = new FlxTypedGroup();
        for(i in 0...options.length){
            var button = new FlxSprite();

			if (i == 7)
			{
				button.frames = Paths.getSparrowAtlas('mainmenu/button_' + options[i]);
				button.animation.addByPrefix('idleon', 'on0', 24, false);
            	button.animation.addByPrefix('hoveron', 'on hover0', 24, false);
				button.animation.addByPrefix('idleoff', 'off0', 24, false);
            	button.animation.addByPrefix('hoveroff', 'off hover0', 24, false);
			}
			else
			{
				if (i == 8)
				{
					button.frames = Paths.getSparrowAtlas('mainmenu/button_' + options[i]);
				}
				else
				{
					button.frames = Paths.getSparrowAtlas(imagePrefix + 'button_' + options[i]);
				}
				button.animation.addByPrefix('idle', options[i] + '0', 24, false);
           	 	button.animation.addByPrefix('hover', options[i] + 'hover0', 24, false);
			}
            button.x = optionGrp.members[i - 1] != null ? optionGrp.members[i - 1].x + 262 : 44;
			button.y = 41;
            button.antialiasing = true;
            button.ID = i;
			button.updateHitbox();
            optionGrp.add(button);
        }

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
	
}
function postCreate(){
	insert(23, norbert);
	insert(24, counter);
	insert(25, fakegf);
	add(fakegf);
	insert(26, bar);
	insert(27, border);
	add(newsTxt1);
	add(newsTxt2);
	insert(28, norbert);
	add(optionGrp);
	new FlxTimer().start(0.50, function(tmr:FlxTimer)
	{
		norbert.visible = true;
		norbert.animation.play('intro');
	});
	new FlxTimer().start(2, function(tmr:FlxTimer){
		norbertcanIdle = true;
	});
	remove(blackBar);
	remove(weekBG);
	remove(characterSprites);
	remove(weekSprites);
	remove(tracklist);
	remove(leftArrow);
	remove(rightArrow);
	remove(weekTitle);
	remove(scoreText);
	remove(difficultySprites);
//	diffSprite.visible = false;
	tracklist = new FlxText(872, 63, "tracklist", 25,25);
	tracklist.alignment = 'LEFT';
	tracklist.font = "VCR OSD Mono";
	tracklist.color = 0xffffffff;
	tracklist.antialiasing = true;
	add(tracklist);

	scoreText = new FlxText(872, 63, "", 0, 25);
	scoreText.alignment = 'LEFT';
	scoreText.font = "VCR OSD Mono";
	scoreText.color = 0xffffffff;
	scoreText.antialiasing = true;
	add(scoreText);

	weekTitle = new FlxText(1110, 63, 0, "", 25, 25);
	weekTitle.alignment = 'RIGHT';
	weekTitle.font = "VCR OSD Mono";
	weekTitle.color = 0xffffffff;
	weekTitle.antialiasing = true;
	add(weekTitle);
}
override function beatHit(){

	if(norbertcanIdle)
	{
		norbert.offset.set(-1013, -4);
		norbert.animation.play('idle', true);
	}
}
function changeWeek(onChangeWeek) {
	remove(weeklogo);
	weeklogo = new FlxSprite(170, 180).loadGraphic(Paths.image('mainmenu/logos/' + curWeek ));
	weeklogo.antialiasing = true;
	insert(3, weeklogo);
	add(weeklogo);
}
override function update() {

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
					if (fcMode == true)
						optionGrp.members[7].animation.play('idleon');
					else
						optionGrp.members[7].animation.play('idleoff');
				else //if button is not fc mode
				i.animation.play('idle');
			}
		}
		if (marathon == true)
		{
			optionGrp.members[1].animation.play('hover');
		}
	}
	scoreText.y = tracklist.height + 60;
	changeWeek((controls.LEFT_P ? -1 : 0) + (controls.RIGHT_P ? 1 : 0));
	if (FlxG.keys.justPressed.P){
		tweak10Select();}
	if (curWeek == 10 && controls.ACCEPT)
	{
		canSelect = false;
		tweak10Select();
	}
	else if (controls.ACCEPT)
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		FlxG.mouse.visible = false;
		norbertcanIdle = false;
		norbert.offset.set(-970, -9);
		norbert.animation.play('start', true);
	}
	if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		persistentDraw = true;
		import funkin.editors.EditorPicker;
		openSubState(new EditorPicker());
	}
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = false;
		persistentDraw = true;
	}
}
override function tweak10Select()
	{
	//	FadeTransitionSubstate.tweak10 = true;
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
		new FlxTimer().start(0.35, function(tmr:FlxTimer)
		{
			norbertcanIdle = false;
			norbert.offset.set(-983, 9);
			norbert.animation.play('transition', true);
		});
		FlxTween.tween(FlxG.camera, {zoom: 0.35}, 2.25, {ease: FlxEase.expoInOut, startDelay: 2.5});   
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
		FlxTween.tween(tracklist, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		FlxTween.tween(fakeEna, {alpha: 1}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5}); 
		new FlxTimer().start(4.75, function(tmr:FlxTimer)
		{
			staticSprite.animation.play('change end', true);
		});
		new FlxTimer().start(5.0, function(tmr:FlxTimer)
		{
			selectWeek();
			MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
			skipTransition = true;
		});
	}
function postUpdate() {
	if (curWeek == 10 && controls.ACCEPT){
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
    skipTransition = true;
	}
}
function selectOption(id:Int){
	canClick = false;
	switch(options[id]){
		case 'play':
			if (curWeek == 10)
			{
				tweak10Select();
			}
			else
			{
				selectWeek();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxG.mouse.visible = false;
				norbertcanIdle = false;
				norbert.offset.set(-970, -9);
				norbert.animation.play('start', true);
			}	
		case 'freeplay':
			FlxG.switchState(new FreeplayState());
			marathon = false;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = false;
		case 'options':
			FlxG.switchState(new OptionsMenu());
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = false;
		case 'left':
			changeWeek(-1);
			canClick = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		case 'right':
			changeWeek(1);
			canClick = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		case 'marathon':
			switch(marathon){
				case true:
					updateMarathon(false);
				case false:
					updateMarathon(true);
			}
			updateText();
			canClick = true;
			trace(marathon);
		case 'fc':
			if (optionGrp.members[7].active == true){
				switch(fcMode){
					case true:
						fcMode = false;
					case false:
						fcMode = true;
				}
				trace(fcMode);
			}
			canClick = true;
		case 'reset':
			if (optionGrp.members[8].active == true){
				openSubState(new MarathonButtonsSubstate(0));
			}
			canClick = true;
		case 'more':
			MusicBeatState.switchState(new WeeklyGalleryState()); //FuckingTriangleEffect
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.mouse.visible = true;
	}
}