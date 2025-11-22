import flixel.effects.FlxFlicker;
introLength = 0;
function postCreate() {
    /*grunt = new FlxAnimate(-225, 258, 'content/W03_CHECK_NEWGROUNDS/images/nevada/grunt');
    grunt.showPivot = false;
    grunt.anim.addBySymbol('gruntwalking', 'gruntwalking',24,true,0,0);
    grunt.anim.addBySymbol('grunthi', 'grunthi',24,true,0,0);
    grunt.anim.addBySymbol('gruntwalkingfast', 'gruntwalkingfast',24,true,0,0);
    grunt.antialiasing = true;
    insert(4,grunt);*/

    blackScreen = new FlxSprite().makeGraphic(1, 1, 0xFF000000);
    blackScreen.scale.set(FlxG.width * 2,FlxG.height * 2);
    blackScreen.updateHitbox();
    blackScreen.scrollFactor.set();
    blackScreen.screenCenter();
    blackScreen.camera = camOther;
    add(blackScreen);

    somewhere = new FlxSprite(0, 0);
    somewhere.loadGraphic(Paths.image("stages/tweak3/nevada/somewhere"));
    somewhere.antialiasing = true;
    somewhere.screenCenter();
    somewhere.camera = camOther;
    somewhere.alpha = 0.00001;
	add(somewhere);

    intropico = new FlxSprite(1280, 0);
    intropico.loadGraphic(Paths.image("stages/tweak3/nevada/Intro_Pico"));
    intropico.antialiasing = true;
    intropico.camera = camHUD;
	insert(3,intropico);

    introhank = new FlxSprite(-1280, 0);
    introhank.loadGraphic(Paths.image("stages/tweak3/nevada/Intro_Hank"));
    introhank.antialiasing = true;
    introhank.camera = camHUD;
	insert(3,introhank);

    play = new FlxSprite(0, 0);
    play.loadGraphic(Paths.image("stages/tweak3/nevada/play"));
    play.antialiasing = true;
    play.camera = camOther;
    play.visible = false;
	add(play);

    camera.zoom = 0.6;
    camHUD.alpha = 0;
}

function stepHit(curStep:Int) {
    switch(curStep){
        case 48: play.visible = true;
        FlxFlicker.flicker(play, 8, 1.0, false);
        FlxTween.tween(blackScreen, {alpha: 0}, 5.0, {ease: FlxEase.expoOut, startDelay: 1.75});   
        case 64: 
            FlxTween.tween(somewhere, {alpha: 1}, 1.0, {ease: FlxEase.linear, 
            onComplete: function(tween:FlxTween) {
                new FlxTimer().start(6, function(tmr:FlxTimer) {
                    FlxTween.tween(somewhere, {alpha: 0}, 1.0, {ease: FlxEase.linear});
                });
            }});
        case 128: 
        FlxTween.tween(camFollow, {y: 200}, 5.5, {ease: FlxEase.smootherStepInOut, 
            onComplete: function(tween:FlxTween) {
                FlxTween.tween(camHUD, {alpha: 1.0}, 2.0, {ease: FlxEase.expoOut});
                FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2.0, {ease: FlxEase.expoOut});
            }});
        case 320: coolPart('hank');
        case 336: coolPart('pico');
        case 352: coolPart('flash');
    }
}
function coolPart(ok:String) {
    switch(ok){
        case 'hank': FlxTween.tween(introhank, {x: 0}, 1.5, {ease: FlxEase.expoOut});
        case 'pico': FlxTween.tween(intropico, {x: 0}, 1.5, {ease: FlxEase.expoOut});
        case 'flash': camHUD.flash(0xFFFFFFFF, 1.0);
        FlxTween.tween(intropico, {x: 1280}, 1.5, {ease: FlxEase.expoOut});
        FlxTween.tween(introhank, {x: -1280}, 1.5, {ease: FlxEase.expoOut});
    }
}

/*
function onEvent(eventName, value1, value2){
    if(eventName == 'crimsonfogevents'){
        switch(value1){       
            case 'triggergrunt':
                switch(value2){
                    case 'Left':
                    grunt.x = 2000;
                    grunt.flipX = true;
                    grunt.anim.play('gruntwalkingfast');
                    FlxTween.tween(grunt, {x: -225}, 2.0, {ease: FlxEase.linear});
                    case 'Right':
                    grunt.x = -225;
                    grunt.flipX = false;
                    grunt.anim.play('gruntwalking');
                    FlxTween.tween(grunt, {x: 640}, 3.5, {ease: FlxEase.linear, 
                    onComplete: function(tween:FlxTween) {
                        grunt.anim.play('grunthi');
                        new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            FlxTween.tween(grunt, {x: 2000}, 1.5, {ease: FlxEase.linear});
                            grunt.anim.play('gruntwalkingfast');
                        });
                    }});
                }
            case 'duet':
                game.isCameraOnForcedPos = true;
                game.camFollow.set(675, 300);
            case 'duet off':
                game.isCameraOnForcedPos = false;
        }
    }
}*/