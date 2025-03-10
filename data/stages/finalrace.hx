var domo:FlxSprite;
var domo1:FlxSprite;
var isDomo:Bool = false;
var isDomo1:Bool = false;

function postCreate() {
    var galaxy:FlxSprite = new FlxSprite(-900, -400);
    galaxy.loadGraphic(Paths.image("stages/ducklife/galaxy"));
    galaxy.antialiasing = true;
    galaxy.scrollFactor.set(0.5, 0.5);
    insert(1, galaxy);
	add(galaxy);

    var stage:FlxSprite = new FlxSprite(-300, 1050);
    stage.loadGraphic(Paths.image("stages/ducklife/stage"));
    stage.antialiasing = true;
    stage.scrollFactor.set(1, 1);
    insert(2, stage);
	add(stage);

    domo = new FlxSprite(2200, 850);
    domo.frames = Paths.getSparrowAtlas("stages/ducklife/domo");
    domo.antialiasing = true;
    domo.animation.addByPrefix('idle', 'domo', 24, false);
    domo.animation.play("idle");
    domo.scrollFactor.set(1, 1);
    insert(3, domo);
	add(domo); 

    domo1 = new FlxSprite(0, 850);
    domo1.frames = Paths.getSparrowAtlas("stages/ducklife/domo");
    domo1.antialiasing = true;
    domo1.animation.addByPrefix('idle', 'domo', 24, false);
    domo1.animation.play("idle");
    domo1.scrollFactor.set(1, 1);
    domo1.flipX =true;
    insert(4, domo1);
	add(domo1); 

    domojet = new FlxSprite(275, -300);
    domojet.frames = Paths.getSparrowAtlas("stages/ducklife/domojet");
    domojet.antialiasing = true;
    domojet.animation.addByPrefix('idle', 'flyingdomo', 24, true);
    domojet.animation.play("idle");
    domojet.scrollFactor.set(1, 1);
    domojet.updateHitbox();
    insert(5, domojet);
	add(domojet); 

    domojet1 = new FlxSprite(1850, -300);
    domojet1.frames = Paths.getSparrowAtlas("stages/ducklife/domojet");
    domojet1.antialiasing = true;
    domojet1.animation.addByPrefix('idle', 'flyingdomo', 24, true);
    domojet1.animation.play("idle");
    domojet1.scrollFactor.set(1, 1);
    domojet1.flipX =true;
    insert(6, domojet1);
	add(domojet1);
}

function onCreatePost() {
    game.snapCamFollowToPos(1200, 900);
}

function beatHit()
{
    if(curBeat % 2 == 0){
        domo.animation.play('idle', true);
        trace('POOPP)PPP');

        if(curBeat % 2 == 0){
            domo1.animation.play('idle', true);
        }
    }
} 

function onSongStart(){
    domo.animation.play('idle', true);
    domo1.animation.play('idle', true);
}

function onCountdownTick(swagCounter){
    if(swagCounter % 2 == 0) domo.animation.play('idle', true);
    if(swagCounter % 2 == 0) domo1.animation.play('idle', true);
}
var s:Float = 1;
var skY:Float = 280;
override function update(elapsed:Float){
    s += elapsed;
    if(isDomo)
    {
        domojet.y = FlxMath.lerp(domojet.y, skY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));
    }
    if(isDomo1)
    {
        domojet1.y = FlxMath.lerp(domojet1.y, skY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));
    }
}

function onGameOverStart() 
{
    setGameOverVideo('duck_life_gameover');
}
 function SHIT(){  
    isDomo = true;
    FlxTween.tween(domojet, {y: 250}, 1.5, {ease: FlxEase.expoOut, onComplete: function(tween:FlxTween) {
    }});
}
function domojet1(){  
    isDomo1 = true;
    FlxTween.tween(domojet1, {y: 250}, 1.5, {ease: FlxEase.expoOut, onComplete: function(tween:FlxTween) {
    }});
}