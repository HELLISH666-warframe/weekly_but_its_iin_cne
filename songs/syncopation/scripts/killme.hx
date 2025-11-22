function create() {
    if(PlayState.isStoryMode){
        defaultCamZoom=0.35;
        introLength = 0;
        function onCountdown(event) event.cancel();
    }
    else{
        game.defaultCamZoom = 0.7; //idk why its acting weird
        FlxG.camera.zoom = 0.7;
    }
}
function postCreate() {
    black = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    black.alpha = 0.001;
    black.camera = camHUD;
    add(black);
}
if(PlayState.isStoryMode)
function onSongStart() {
    inCutscene = true;
    camHUD.alpha = 0;
    defaultCamZoom = 0.7;
    FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2, {ease: FlxEase.smootherStepInOut});
    FlxTween.tween(camFollow, {x: 239.5, y: 647}, 1, {ease: FlxEase.smootherStepInOut});
    new FlxTimer().start(2, function(tmr:FlxTimer) {
        FlxTween.tween(camHUD, {alpha : 1}, 1);
        inCutscene = false;
        startCountdown();
    });
}
var allowEnd:Bool=false;
if(PlayState.isStoryMode)
function onSongEnd(e){
    if (PlayState.isStoryMode) {
        e.cancel();
        black.alpha = 0.5;
        new FlxTimer().start(0.1, ()->{black.alpha = 0.1;});
        new FlxTimer().start(0.2, ()->{black.alpha = 0.5;});
        new FlxTimer().start(0.3, ()->{black.alpha = 0;});
        new FlxTimer().start(0.5, ()->{black.alpha = 1;
        camGame.alpha = 0;});

        new FlxTimer().start(4, ()-> {allowEnd = true;
        camGame.alpha = 0;
        camHUD.alpha = 0;
        nextSong();});

        if(!allowEnd){
        FlxG.sound.play(Paths.sound('poweroutage'));
        }

    }
}