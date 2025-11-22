var norbert:FlxSprite;
var fakestartTimer:FlxTimer;
var squatBF:FlxAnimate;
var bf:FlxSprite;
var allowEnd:Bool = false;

function create()  {
    var bg = new FlxSprite(-1357, -739).loadGraphic(Paths.image('mainmenu/newsSet/bg'));
    insert(1, bg);

    norbert = new FlxSprite(913, 250.05);
    norbert.frames = Paths.getSparrowAtlas("mainmenu/newsSet/norbert");
    norbert.animation.addByPrefix('idle', 'norbert idlealt0', 24, false);
    norbert.animation.play("idle");
    insert(2, norbert);

    var counter = new FlxSprite(223.1, 566.1).loadGraphic(Paths.image('mainmenu/newsSet/counter'));
    insert(3, counter);

    var lights = new FlxSprite(-1345.15, -852.55).loadGraphic(Paths.image('mainmenu/newsSet/lights'));
    insert(6, lights);

    squatBF = new FlxAnimate(1300, 720, 'images/stages/tweak10/newsSet/squatbf');
    squatBF.showPivot = false;
    squatBF.anim.addBySymbol('Ouch', 'Ouch',24,false,0,0);
    squatBF.antialiasing = true;

    bf = new FlxSprite(1298, 700); 
    bf.frames = Paths.getSparrowAtlas("characters/BoyFriendflow");
    bf.animation.addByPrefix('idle', 'BF idle dance', 24, false);
    bf.animation.play("idle");
    insert(4,bf);
}

function beatHit() {
    if (curBeat % 2 == 0){ norbert.animation.play("idle", true);
    bf.animation.play("idle", true);
    }
}

/*function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Jolly':
        switch(value1)
        {
            case 'jump':
                game.boyfriendGroup.x = 950;
                game.boyfriend.alpha = 1;
                game.boyfriend.playAnim('splat', true);
                game.boyfriend.specialAnim = true;
            case 'para':
                game.boyfriendCameraOffset[0] = -175;
                iconP1.changeIcon('parappa');
                game.healthBar.createFilledBar(FlxColor.fromRGB(54, 107, 255), FlxColor.fromRGB(195, 117, 66));
                game.healthBar.updateBar();
                bf.alpha = 0;
                add(squatBF);
                squatBF.anim.play('Ouch');
                new FlxTimer().start(1.5, function(tmr:FlxTimer)
                {
                    FlxTween.tween(game.camFollow, {x: 239.5, y: 647}, 5, {ease: FlxEase.smootherStepInOut});
                    new FlxTimer().start(2.5, function(tmr:FlxTimer) // this is lazy but whatever
                    {
                        squatBF.visible = false;
                    });
                });
            case 'jova':
                game.camGame.flash(0xFFFFFFFF, 0.5);
                game.triggerEventNote('Change Character', 'dad', 'johnny');
                game.triggerEventNote('Change Character', 'bf', 'siiva');
                //iconP1.changeIcon('siiva');
                //iconP2.changeIcon('john');
                //game.healthBar.createFilledBar(FlxColor.fromRGB(59, 177, 255), FlxColor.fromRGB(70, 70, 70));
            case 'sunko':
                game.camGame.flash(0xFFFFFFFF, 0.5);
                game.triggerEventNote('Change Character', 'dad', 'sunday');
                game.triggerEventNote('Change Character', 'bf', 'retsuko');
                //iconP1.changeIcon('sunday');
                //iconP2.changeIcon('retsuko');
                //game.healthBar.createFilledBar(FlxColor.fromRGB(102, 153, 153), FlxColor.fromRGB(255, 122, 73));
        }
    }
}
*/
function postCreate()
{
    iconP1.setIcon('bf');
    healthBar.createFilledBar(dad.iconColor, FlxColor.fromRGB(54, 107, 255));
    healthBar.updateBar();
    boyfriend.alpha = 0;

    if(!PlayState.isStoryMode)
    {
        defaultCamZoom = 0.7; //idk why its acting weird
        FlxG.camera.zoom = 0.7;
        camFollow.getPosition(639.5, 359.5);
    }
}

function onGameOverStart() 
{
    setGameOverVideo("syncopation_gameover");
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 110:
            boyfriend.x = 950;
            boyfriend.alpha = 1;
            boyfriend.playAnim('splat', true);
   //         boyfriend.altAnim = true;
        case 111:
            iconP1.setIcon('parappa');
            healthBar.createFilledBar(FlxColor.fromRGB(54, 107, 255), FlxColor.fromRGB(195, 117, 66));
            healthBar.updateBar();
            bf.alpha = 0;
            add(squatBF);
            squatBF.anim.play('Ouch');
            new FlxTimer().start(1.5, function(tmr:FlxTimer) {
                FlxTween.tween(camFollow, {x: 239.5, y: 647}, 5, {ease: FlxEase.smootherStepInOut});
                new FlxTimer().start(2.5, function(tmr:FlxTimer) {squatBF.visible = false;});});
        case 633: camGame.flash(0xFFFFFFFF, 0.5);
        case 1407: camGame.flash(0xFFFFFFFF, 0.5);
    }
}