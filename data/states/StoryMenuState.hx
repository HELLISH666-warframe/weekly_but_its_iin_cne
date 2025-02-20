import Xml;
import meta.states.substate.FadeTransitionSubstate;
import flixel.addons.transition.FlxTransitionableState;
var weeklogo:FlxSprite;
var norbertcanIdle:Bool = false;
var imagePrefix:String = 'mainmenu/';
var options:Array<String> = [
	'freeplay',
	'more', // Gallery + Credits
	'left', // arrows that change the week you have selected
	'right',
	'play', // basically story mode
	'options',
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
	insert(3, bg);
	add(bg);

	weeklogo = new FlxSprite(170, 180).loadGraphic(Paths.image('mainmenu/logos/' + curWeek ));
	weeklogo.antialiasing = true;
	insert(4, weeklogo);
	add(weeklogo);

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

	
}
function postCreate(){
	insert(23, norbert);
	add(norbert);
	insert(24, counter);
	add(counter);
	insert(25, fakegf);
	add(fakegf);
	insert(26, bar);
	add(bar);
	insert(27, border);
	add(border);
	add(newsTxt1);
	add(newsTxt2);
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
	tracklist = new FlxText(872, 63, "", 25,25);
	tracklist.alignment = 'LEFT';
	tracklist.font = "VCR OSD Mono";
	tracklist.color = 0xffffffff;
	tracklist.antialiasing = true;
	add(tracklist);

	scoreText = new FlxText(872, 63, "", 25, 25);
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
override function update() {
	changeWeek((controls.LEFT_P ? -1 : 0) + (controls.RIGHT_P ? 1 : 0));
	if (FlxG.keys.justPressed.P){
		tweak10Select();}
	if (curWeek == 10 && controls.ACCEPT)
	{
		tweak10Select();
	}
	else if (controls.ACCEPT)
	{
		selectWeek();
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
	/*	optionGrp.forEach(function(obj:FlxSprite)
		{
			FlxTween.tween(obj, {alpha: 0}, 1, {ease: FlxEase.expoInOut, startDelay: 2.5});  
		});*/
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
		});
	}