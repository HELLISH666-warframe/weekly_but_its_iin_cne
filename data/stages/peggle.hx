var fakeP1:HealthIcon;
var ba:FlxSprite;
var p:Float;
var shower:FlxSprite;
var ttt:FlxSprite;
var bg:FlxSprite;

var ga:FlxText;
var ha:FlxText;
var poppedPegs = false;

var pls:FlxTypedGroup<FlxSprite>;
var redPegs = 25;
var ogComboOffset:Array<Int> = [0, 0, 0, 0];
introLength = 0;
function onCountdown(event) event.cancel();
function create(){
    var b = new FlxSprite(0, 0);
    b.loadGraphic(Paths.image("stages/peggle/katiscrackedbro"));
    insert(1, b);
	add(b);

    bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image("stages/peggle/susPegle"));
    insert(5, bg);
	add(bg);

    ba = new FlxSprite(0, 562);
    ba.loadGraphic(Paths.image("stages/peggle/basket"));
    ba.scale.set(1.2,1.2);
    ba.updateHitbox();
    insert(6, ba);
    add(ba);

    ttt= new FlxSprite(249,300);
    ttt.scrollFactor.set(0,0);
    ttt.loadGraphic(Paths.image('stages/peggle/title'));
    ttt.cameras = [camHUD];
   
    ttt.alpha = 0;
    insert(7, ttt);
    add(ttt);

    /*
    var helpText:FlxText = new FlxText(0,0,1280,'Only way of gaining health is by Opponent notes');
    helpText.cameras = [game.camHUD];
    helpText.screenCenter();
    add(helpText);*/

    shower = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);

    var pegCount = 70;
 
    //pls = new FlxTypedGroup<FlxSprite>();

    for(i in 0...pegCount) {
        var pegp = 'blue';
        if(redPegs>0)  { pegp = 'red'; redPegs--; }
        var peg:FlxSprite = new FlxSprite(FlxG.random.int(100, 700), FlxG.random.int(200, 500));
        peg.loadGraphic(Paths.image('stages/peggle/' + pegp + 'Peg'));
        peg.ID = [i, pegp];
        add(peg);
    }

    var ball = new FlxSprite(500, 500);
    ball.loadGraphic(Paths.image('stages/peggle/ball'));
    add(ball);

    ga = new FlxText(300,3,-1,'whwer', 16);
    ga.color = 0xFF65F5F9;
   
    add(ga);

    ha = new FlxText(700,13,-1,'whener', 16);
    ha.color = 0xFF65F5F9;
   
    add(ha);
    // ga.setFormat(Paths.font("liberbold.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
   
//    PlayState.instance.healthGain = 0;


    add(shower);

   
    trace("DICK");
}

function postCreate() {
    // Wow.
    healthBarBG.alpha = 0;
    healthBar.alpha = 0;

    
    healthBar.angle = 90; healthBar.setPosition(-80,400); healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
    //timeBar.y = -900;
    for(i in [dad, iconP1, iconP2, scoreTxt]) {
        i.visible = false;
    }
    for (i in 0...cpuStrums.members.length) {
		cpuStrums.members[i].visible = false;
	}
}
function opponentNoteHit() {
    game.health+=0.03;
}
function onGameOverStart() 
{
    setGameOverVideo('bfdeath');
}

function onUpdate(elapsed){
    game.camZooming = false;
    ha.text = game.songScore;
    ha.x = 670 - ha.width;

    ga.text = Math.fround(game.ratingPercent * 100) + '%\n' + game.songMisses;
    ga.x = 300 - ga.width;
    //FlxG.camera.zoom = 1.2;
    //camHUD.zoom = 1;
   
    p++;//FlxG.elapsed;
    ba.x = 300 + (Math.sin(p/50 / (FlxG.updateFramerate / 60)) * 180);
}
function goodNoteHit(note) {
    if(note.isSustainNote) return;
    var n = boyfriend.animation.curAnim.name;
    if(n == 'singLEFT' && boyfriend.scale.x == -1) {
        boyfriend.playAnim('turn', true);
        boyfriend.specialAnim = true;
        boyfriend.scale.x = 1;
        boyfriend.updateHitbox();
        boyfriend.heyTimer = 0.05;
        new FlxTimer().start(0.05, function(tmr:FlxTimer)
            {
                onComplete: function() {
                    if(boyfriend.animation.curAnim.name == 'turn')
                    boyfriend.playAnim('singLEFT', true);
                }
            });
    }
    if(n == 'singRIGHT' && boyfriend.scale.x == 1) {
        boyfriend.scale.x = -1;
        boyfriend.updateHitbox();
        boyfriend.playAnim('turn', true);
        boyfriend.specialAnim = true;
        boyfriend.heyTimer = 0.05;
        new FlxTimer().start(0.05, function(tmr:FlxTimer)
            {
                onComplete: function() {
                    if(boyfriend.animation.curAnim.name == 'turn')
                    boyfriend.playAnim('singRIGHT', true);
                }
            });
    }
}
function onSpawnNotePost(note:Note)
    {
        note.visible = note.mustPress;
    }
function beatHit() {
    switch(curBeat) {
        // You gonna make me cry
        case 1:
            

        FlxTween.tween(healthBar, {alpha: 1},1, {
            ease: FlxEase.linear
        });
        FlxTween.tween(healthBarBG, {alpha: 1},1, {
            ease: FlxEase.linear
        });
        FlxTween.tween(shower, {alpha: 0},1, {
            ease: FlxEase.linear,
            onComplete: function(twn:FlxTween) {
                remove(shower);
            }
        });
        FlxTween.tween(ttt, {alpha: 1},1, {
            ease: FlxEase.linear
        });

        case 4:
            FlxTween.tween(ttt, {alpha: 0},1, {
                ease: FlxEase.linear,
                onComplete: function(twn:FlxTween) {
                    remove(ttt);
                }
            });
    }
}