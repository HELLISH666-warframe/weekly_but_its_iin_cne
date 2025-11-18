//Code_this_later_to_NOT_be_partly_stolen_shit.
import funkin.backend.utils.FlxInterpolateColor;
import funkin.backend.utils.MathUtil;
import flixel.graphics.FlxGraphic;
import funkin.backend.chart.Chart;

var grpSongs = new FlxTypedGroup();
var iconArray:Array<HealthIcon> = [];

static var curSelectedFPCat:Int=0;
static var curSelectedFP:Int = 0;

songs = [];
songRealList = [
	['boss-tweaks-in-brasil','teaking','goo','visiosubrideophobia'],
	['chef-blasting','pegging-arent-i-hilarious','joink','fruity','johnny-round'],
	['dustloop','pirate-indie-games','undead','termina','luminary-clock','koopa-karnage'],
	['mental-temple','spaceblasterz','crimson-fog'],
	['plectrum','parched','mischief','philly-mice','champions-ring','haystack'],
	['chorale','funky-flow','off-the-cuff','transient-tribulation','love-groove'],
	["devil's-ditty",'jeff-the-kill-you','box24','7OF8','good-will','can-you-hear-me'],
	['brilliance','lifeless','doodlequest','kb5k','evolution','legend'],
	['dangerous-to-go-alone','frauduccine','circus-(weekly-mix)','rock-bottom','silence-is-death','simul4crum'],
	['perfect-girl','busy-work','motivation','popular','beyond'],
	['syncopation','scarefull','genre-null','tenkaichi-battleworld','friends-and-fellas','buds-and-bluds'],
	['Teaking-Pico','Goo-Pico','Teaking-Weekly-Mix','Goo-Weekly-Mix',"There's-Always-Next-Week!"]];

static var prevSong:String = "balls";

var bg:FlxSprite = new FlxSprite();

var interpColor:FlxInterpolateColor;

var leftButton:FlxSprite;
var rightButton:FlxSprite;
 
function create() {
	CoolUtil.playMenuSong();

	bg = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
	if (songs.length > 0) bg.color = songs[0].color;
	bg.antialiasing = true;
	add(bg);
		
	add(grpSongs);
	birth();
	//if (curSelectedFP >= songs.length) curSelectedFP = 0;

	leftButton = new FlxSprite();
	leftButton.frames = Paths.getSparrowAtlas("mainmenu/button_left");
	leftButton.animation.addByPrefix("idle", "left0", 10, true);
	leftButton.animation.addByPrefix("hover", "left hover0", 10, true);
	leftButton.animation.play("idle");
	leftButton.screenCenter(FlxAxes.Y);
	add(leftButton);

	rightButton = new FlxSprite();
	rightButton.frames = Paths.getSparrowAtlas("mainmenu/button_right");
	rightButton.animation.addByPrefix("idle", "right0", 10, true);
	rightButton.animation.addByPrefix("hover", "right hover0", 10, true);
	rightButton.animation.play("idle");
	rightButton.screenCenter(FlxAxes.Y);
	rightButton.x = FlxG.width - rightButton.width;
	add(rightButton);

	interpColor = new FlxInterpolateColor(bg.color);
}
function birth(){
	//curSelectedFP = 0;
	songs = [];
	grpSongs.clear();
	if(iconArray.length > 0) for(icon in iconArray) icon.destroy();
	iconArray = [];
	for(s in songRealList[curSelectedFPCat]) songs.push(Chart.loadChartMeta(s, "hard", true));
	for (i in 0...songs.length){
		var songText = new Alphabet(0, (70 * i) + 30, songs[i].displayName, true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		songText.ID = i;
		grpSongs.add(songText);
		var icon = new HealthIcon(songs[i].icon);
		icon.sprTracker = songText;
		iconArray.push(icon);
		add(icon);
	}
	changeSelection(0);
}

//static var curPlayingInst = Paths.inst(songs[curSelectedFP].name, 'hard');

function update(elapsed:Float) {
	if (controls.UP_P||controls.DOWN_P) changeSelection(controls.DOWN_P ? 1 : -1);
	if (controls.BACK) {
		CoolUtil.playMenuSFX('CANCEL', 0.7);
		FlxG.switchState(new ModState('weekly/WeeklyMainMenuState'));
	}
	//if (controls.LEFT_P||controls.RIGHT_P) changeCat(controls.LEFT_P ? -1 : 1);
	if (controls.ACCEPT){
		prevSong="FUCK";
		PlayState.loadSong(songs[curSelectedFP].name, 'normal');
		FlxG.switchState(new PlayState());
	}
	interpColor.fpsLerpTo(songs[curSelectedFP].color, 0.0625);
	bg.color = interpColor.color;
	if(controls.LEFT_P||controls.RIGHT_P) {
		controls.LEFT_P ? leftButton.animation.play("hover") : rightButton.animation.play("hover");
		new FlxTimer().start(0.125, ()->{
			controls.LEFT_P ? leftButton.animation.play("idle") : rightButton.animation.play("idle");});
		changeCat(controls.LEFT_P ? -1 : 1);
	}
}

function changeSelection(change:Int = 0, playSound:Bool = true){
	if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	curSelectedFP = FlxMath.wrap(curSelectedFP + change, 0, songs.length-1);

	var bullShit:Int = 0;
	for (i in grpSongs){
		i.targetY = bullShit - curSelectedFP;
		bullShit++;
		i.alpha = 0.6;
		if (i.targetY == 0) i.alpha = 1;
	}
	for (i in 0...iconArray.length) iconArray[i].alpha = 0.6;
		iconArray[curSelectedFP].alpha = 1;

	curPlayingInst = Paths.inst(songs[curSelectedFP].name, 'normal');
	trace(prevSong);
	if(curPlayingInst!=prevSong){
		FlxG.sound.playMusic(curPlayingInst, 1);
		prevSong=curPlayingInst;
	}
}

function changeCat(change:Int = 0){
	curSelectedFPCat = FlxMath.wrap(curSelectedFPCat + change, 0, songRealList.length-1);
	birth();
}