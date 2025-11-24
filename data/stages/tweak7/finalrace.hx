var domo:FlxSprite;
var domo1:FlxSprite;
var isDomo:Bool = false;
var isDomo1:Bool = false;

function postCreate() {
    domo.antialiasing = true;
    domo.animation.addByPrefix('idle', 'domo', 24, false);
    domo.animation.play("idle");

    domo1.antialiasing = true;
    domo1.animation.addByPrefix('idle', 'domo', 24, false);
    domo1.animation.play("idle");
    
    domojet.antialiasing = true;
    domojet.animation.addByPrefix('idle', 'flyingdomo', 24, true);
    domojet.animation.play("idle");
    domojet.updateHitbox();

    domojet1.antialiasing = true;
    domojet1.animation.addByPrefix('idle', 'flyingdomo', 24, true);
    domojet1.animation.play("idle");
}

function beatHit(curBeat:Int){
    if(curBeat % 2 == 0){
        domo.animation.play('idle', true);
        if(curBeat % 2 == 0) domo1.animation.play('idle', true);
    }
    switch(curBeat){
        case 336: FlxTween.tween(domojet, {y: 250}, 1.5, {ease: FlxEase.expoOut, onComplete: function(tween:FlxTween) {isDomo = true;}});
        case 352: FlxTween.tween(domojet1, {y: 250}, 1.5, {ease: FlxEase.expoOut, onComplete: function(tween:FlxTween) {isDomo1 = true;}});
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
function update(elapsed:Float) {
    s += elapsed;
    if(isDomo) domojet.y = FlxMath.lerp(domojet.y, skY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));
    if(isDomo1) domojet1.y = FlxMath.lerp(domojet1.y, skY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));
}