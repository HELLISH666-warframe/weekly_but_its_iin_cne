import flixel.text.FlxTextBorderStyle;
var lyrics:FlxText;
var isLooking:Bool = false;
var fade:FlxSprite;
var intro:PsychVideoSprite;
var watchingCutscene:Bool = false;
var hasWatchedCutscene:Bool = false;
var skip:FlxText;

introLength=0;
function create() {
    lyrics = new FlxText().setFormat(Paths.font('vcr.ttf'), 32, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    lyrics.text = '';
    lyrics.antialiasing = true;
    lyrics.borderSize = 2;
    lyrics.camera = camHUD;
    lyrics.screenCenter();
    lyrics.y += 200;
    lyrics.updateHitbox();

    skip = new FlxText(10, 10).setFormat(Paths.font('vcr.ttf'), 24, 0xFFFFFFFF, 'left', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    skip.text = 'Click to skip';
    skip.alpha = 0.75;

    fade = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    add(fade);
}

function postCreate() {
    add(lyrics);
    skip.camera = camOther;
    fade.camera = camOther;

    //comboOffsetCustom = [200, 300, 250, 420];

    for (i in [timeTxt, timeBar, timeBarBG]) i.visible = false;
    scoreTxt.y =timeTxt.y;

    dad.scrollFactor.set(0.7, 0.7);
    dad.visible = false;
    iconP2.alpha = 0.001;
    
}

function presongCutscene() // didn't know nv had this, neat
{
    FlxG.mouse.visible = true;

    watchingCutscene = true;
    inCutscene = true;
    camHUD.visible = false;
    intro = new PsychVideoSprite();
    intro.addCallback('onFormat',()->{
        intro.setGraphicSize(FlxG.width,FlxG.height);
        intro.updateHitbox();
        intro.screenCenter();
        intro.antialiasing = true;
        intro.cameras = [game.camOther];
    });
    intro.addCallback('onEnd',()->{
        endIntro();
    });
    intro.load(Paths.video('trade'));
    intro.play();
    add(intro);

    game.add(skip);
}

function endIntro() {
    trace('hi friend');
    intro.stop();
    intro.destroy();
    watchingCutscene = false;
    game.inCutscene = false;
    game.camHUD.visible = true;
    hasWatchedCutscene = true;
    FlxG.mouse.visible = false;
    skip.destroy();
    game.startCountdown();
}

function onUpdatePost(elapsed:Float)
{
    if (FlxG.mouse.justPressed) endIntro();
}
function lyrics_cyhm(textt:String,color){
    lyrics.text = textt;
    lyrics.screenCenter(FlxAxes.X);
    lyrics.updateHitbox();

    lyrics.color = FlxColor.fromString(color);
}
//Pokepasta Events

function hey_there_friend(){
    dad.playAnim('intro');
    dad.visible = true;
    dad.animTimer = 0.6;
    FlxTween.tween(game.iconP2, {alpha: 1}, 0.6);
}

function sad_gold(){
    dad.playAnim('tweak');
    dad.animTimer = 999;
}

function no_More(){
    dad.animTimer = 0;
    dad.playAnim('no more');
    dad.animTimer = 999;
}

function reset_to_idle(){
    dad.animTimer = 0;
    dad.dance();
}

function look_Up(){
    triggerEventNote('Change Character', 'bf', 'disabled-looking');
    boyfriend.playAnim('look');
    boyfriend.animTimer = 1.25;
}

function stepHit(curStep:Int) {
    switch(curStep){
        case 63|1824:fade.visible = !fade.visible;
    }
}

/*

function onMoveCamera() 
{
    switch (game.whosTurn)
    {
        case 'dad':
            game.defaultCamZoom = 1.3;
        default:
            game.defaultCamZoom = 1;
    }
}*/

function onGameOverStart()
{
    setGameOverVideo('bisabled');
}