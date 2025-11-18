import hxvlc.flixel.FlxVideoSprite;
var allowEnd:Bool = false;
var hit:Int = 0;
var oldhit:Int = 1;
var ending:FlxSprite;

//THIS CODE IS REALLY BAD
function postCreate(){
    var venvid = new FlxVideoSprite();
    venvid.load(Assets.getPath(Paths.video("venombg")), ['no-audio']);
    insert(1, venvid);
    venvid.antialiasing = true;
venvid.play();
venvid.x += 130;
venvid.y += 500;

var bars1:FlxSprite = new FlxSprite(0, 0);
bars1.makeGraphic(Std.int(FlxG.width * 2), 68, FlxColor.BLACK);
bars1.antialiasing = true;
bars1.screenCenter();
bars1.x += 217;
bars1.y += (530 - (FlxG.height/2) + 34);
insert(6, bars1);
add(bars1);

var bars2:FlxSprite = new FlxSprite(0, 0);
bars2.makeGraphic(Std.int(FlxG.width * 2), 68, FlxColor.BLACK);
bars2.antialiasing = true;
bars2.screenCenter();
bars2.x += 217;
bars2.y += (530 + (FlxG.height/2) - 33);
insert(7, bars2);
add(bars2);
}
function onSongStart(){
}
/*function onEvent(eventName, value1, value2)
{
    switch (eventName)
    {
        case 'Punch':
            punch = true;
            if (!tween1 == null)
            {
                tween1.cancel();
            }
            if (!tween2 == null)
            {
                tween2.cancel();
            }
            if (moveTween != null)
            {
                moveTween.cancel();
            }
           FlxTween.tween(game.boyfriend, {x: game.boyfriend.x + 200}, 0.35, {ease: FlxEase.expoOut, 
            onComplete: function(tween:FlxTween) {
                FlxTween.tween(game.boyfriend, {x: game.boyfriend.x - 700}, 0.6, {ease: FlxEase.expoIn});
            }});

        case 'Climaxing':
            var black:FlxSprite = new FlxSprite(0,0);
            black.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
            black.antialiasing = true;
            black.screenCenter();
            black.cameras = [game.camOther];
            add(black);

            var ending:FlxSprite = new FlxSprite(0,0);
            ending.loadGraphic(Paths.image("venom/spidersting"));
            ending.antialiasing = true;
            ending.screenCenter();
            ending.cameras = [game.camOther];
            add(ending);

            var flash:FlxSprite = new FlxSprite(0,0);
            flash.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
            flash.antialiasing = true;
            flash.screenCenter();
            flash.cameras = [game.camOther];
            flash.alpha = 0.8;
            add(flash);
            FlxTween.tween(flash, {alpha: 0}, 0.6, {ease: FlxEase.expoOut});
            FlxTween.tween(ending, {alpha: 0}, 4);
    }
}
*/
function onDestroy() 
{
    ClientPrefs.comboOffset[0] =  ogComboOffset[0];
	ClientPrefs.comboOffset[1] =  ogComboOffset[1];
    ClientPrefs.comboOffset[2] =  ogComboOffset[2];
	ClientPrefs.comboOffset[3] =  ogComboOffset[3];
}

function onGameOverStart() 
{
    setGameOverVideo("venom_gameover");
}

function onEndSong()
{
    vicvideo = new PsychVideoSprite();
    vicvideo.addCallback('onFormat',()->{
        vicvideo.setGraphicSize(0,FlxG.height);
        vicvideo.updateHitbox();
        vicvideo.screenCenter();
        vicvideo.cameras = [game.camOther];
        vicvideo.antialiasing = true;
    });
    vicvideo.addCallback('onEnd',()->{
        allowEnd = true;
        game.endSong();
    });
    vicvideo.load(Paths.video("spiderman_victory"));
    
    if(!allowEnd)
    {
        vicvideo.play();
        add(vicvideo);
        return Function_Stop;
    }
}
var time:Float = 0;
override function update(elapsed:Float){
    hit = 0;
}