import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;
var lightning = new FlxSprite(-400,-750);
var lightningActive:Bool = false;
var lightningTimer:Float = 3.0;

introLength = 0;
function onCountdown(event) event.cancel();

var rainShader = new CustomShader("rain");
var rainIntensity:Float = 0.15;
var intro;
var ending;
function postCreate() {
    FlxG.camera.addShader(rainShader);
    rainShader.data.uScreenResolution.value=[FlxG.width, FlxG.height];
    rainShader.data.uScale.value=[FlxG.height / 200];
    rainShader.data.uIntensity.value=[rainIntensity];

    lightning.frames = Paths.getSparrowAtlas('stages/tweak10/tenkaichi/lightning');
    lightning.animation.addByPrefix('strike', 'lightning0', 24, false);
    //lightning.antialiasing = ClientPrefs.globalAntialiasing;
    lightning.blend = BlendMode.ADD;
    lightning.scrollFactor.set(0.5, 0.5);
    lightning.scale.set(3, 3);
    insert(1,lightning);
    lightning.animation.play('strike');
    strumLines.members[3].characters[0].flipX = false;
    strumLines.members[3].characters[0].setPosition(1900,225);

    intro = new FlxVideoSprite();
    intro.bitmap.onFormatSetup.add(function():Void {
        intro.camera = camOther;
        intro.setGraphicSize(FlxG.width);
        intro.screenCenter();
	});

    intro.bitmap.onEndReached.add(function() {
        camGame.alpha = 1;
        camHUD.alpha = 1;
        camGame.flash(0xFFFFFFFF, 1.0);
        intro.kill();
        stage.getSprite("black").alpha=0;
        lightningActive = true;
    });
    intro.load(Paths.video("tweak10/tenkaichi_intro"), ['no-audio']);
    intro.antialiasing = true;
    insert(0,intro);


    ending = new FlxVideoSprite();
    ending.bitmap.onFormatSetup.add(function():Void {
        ending.camera = camOther;
        ending.setGraphicSize(FlxG.width);
        ending.screenCenter();
	});
    ending.load(Paths.video("tweak10/tenkaichi_end"), ['no-audio']);
    ending.antialiasing = true;
    //ending.pauseOverride = true;
    add(ending);
}

function onSongStart() {
    intro.play();
    ending.visible = false; // Justtt incase
    camGame.alpha = 0;
}

var s:Float = 1;
var shaggyY:Float = -325;
var gokuY:Float = -275;
var zeroY:Float = -400;
var rainTime:Float = 0;
function update(elapsed:Float) {s += elapsed;
    dad.y = FlxMath.lerp(dad.y, shaggyY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));
    boyfriend.y = FlxMath.lerp(boyfriend.y, gokuY + (Math.cos(s) * 65), FlxMath.bound(1, 0, elapsed * 4));

    rainShader.data.uCameraBounds.value=[camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height];
    rainTime += elapsed;
    rainTime++;
    rainShader.uTime = rainTime;

    if (lightningActive) {
        lightningTimer -= elapsed;
        if (lightningTimer < 0) {
            strikeLightning();
            lightningTimer = FlxG.random.float(10, 20);
        }
    }
}

function strikeLightning():Void {
    if (!FlxG.save.data.WEEKLY_FLASHING) return;

    lightning.x = FlxG.random.float(-500, 1900);
    lightning.animation.play('strike');

    FlxTween.color(boyfriend, 1.5, 0xFF606060, 0xFFFFFFFF);
    FlxTween.color(dad, 1.5, 0xFF606060, 0xFFFFFFFF);
    FlxTween.color(gf, 1.5, 0xFF606060, 0xFFFFFFFF);
    FlxTween.color(strumLines.members[3].characters[0], 1.5, 0xFF606060, 0xFFFFFFFF);
    FlxTween.color(stage.getSprite("cameoFG"), 1.5, 0xFF606060, 0xFFFFFFFF);
    stage.getSprite("light").alpha = 0.3;
    FlxTween.tween(stage.getSprite("light"), {alpha: 0.001}, 1.5);

    FlxG.sound.play(Paths.soundRandom('tweak10/Lightning', 1, 3), 1.0);
}


function stepHit(curStep:Int) {
    switch(curStep){
        case 1024/*256*/: FlxG.camera.removeShader(rainShader);
        lightningActive = false;

        dad.shader = new CustomShader("tweak10/silhouette");
        dad.shader.data.col.value=[73 / 255, 179 / 255, 84 / 255];
        dad.shader.amount=1;

        gf.shader = new CustomShader("tweak10/silhouette");
        gf.shader.data.col.value=[175 / 255, 6 / 255, 46 / 255];
        gf.shader.amount=1;

        boyfriend.shader = new CustomShader("tweak10/silhouette");
        boyfriend.shader.data.col.value=[59 / 255, 177 / 255, 255 / 255];
        boyfriend.shader.amount=1;

        strumLines.members[3].characters[0].shader = new CustomShader("tweak10/silhouette");
        strumLines.members[3].characters[0].shader.data.col.value=[0 / 255, 0 / 255, 0 / 255];
        strumLines.members[3].characters[0].shader.amount=1;

        stage.getSprite("black").alpha=1;
        stage.getSprite("white").alpha=1;
        defaultCamZoom = 0.6;
        new FlxTimer().start(0.75, ()->{
            FlxTween.tween(stage.getSprite("black"), {alpha: 0}, 1);
        });
        case 1552/*388*/: FlxG.camera.addShader(rainShader);
        lightningActive = true;
        camGame.flash(0xFFFFFFFF, 1.0);
        defaultCamZoom = 0.45;
        for(i in [dad,gf,boyfriend,strumLines.members[3].characters[0]]) i.shader=null;
        stage.getSprite("white").alpha = 0;
        case 1788/*447*/: lightningActive = false;
        ending.play(['no-audio']);
        ending.visible = true;
        //ending.pauseOverride = false;
        camHUD.alpha = 0;
        stage.getSprite("black").alpha = 1;
    }
}

function onNoteHit(e) if (e.noteType == "Spidey Note"){
    e.cancelAnim();
    strumLines.members[3].characters[0].playSingAnim(e.direction, e.animSuffix);
}

function onSubstateOpen() {
if (intro != null && paused) intro.pause();
if (ending != null && paused) ending.pause();}
function onSubstateClose(){
if (intro != null && paused) intro.resume();
if (ending != null && paused) ending.resume();}



function lyric(txt:String) {
    text.text = txt;
    text.updateHitbox();
    text.screenCenter(FlxAxes.X);
}

function destroy() {
    if (intro != null) intro.destroy();
    if (ending != null) ending.destroy();
}