import hxvlc.flixel.FlxVideoSprite;
var Bud:Bool = false;
var intro:PsychVideoSprite;
var watchingCutscene:Bool = false;
var hasWatchedCutscene:Bool = false;
var skip:FlxText;
var pac:Bool = true;
var mike:Bool = false;
var tazer:Bool = false;
//var ogNotes:String = ClientPrefs.noteSkin;
//var ogQuants:Array<Array<Int>> = ClientPrefs.quantHSV;
var gold:Bool = false;

introLength = 0;
function onCountdown(event) event.cancel();

function Create()
{//  game.addCharacterToList('herocam');

    bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image('stages/Legend/BG'));
    bg.antialiasing = true;
    insert(1, bg);
    add(bg);

    bgcam = new FlxSprite(0, 0);
    bgcam.loadGraphic(Paths.image('stages/Legend/BG2'));
    bgcam.antialiasing = true;
    bgcam.visible = false;
    insert(2, bgcam);
    add(bgcam);

    overlay = new FlxSprite(0, 0);
    overlay.loadGraphic(Paths.image('stages/Legend/overlay'));
    overlay.antialiasing = true;
    overlay.visible = false;
    insert(3, overlay);
    add(overlay);

    blueoverlay = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF30B3FF);
    blueoverlay.cameras = [/*camOther*/camHUD];
    blueoverlay.visible = false;
    blueoverlay.alpha = 0.14;
    add(blueoverlay);

    friends = new FlxSprite(130, 590);
    friends.loadGraphic(Paths.image('stages/Legend/FG'));
    friends.antialiasing = true;
    insert(7, friends);
    add(friends);

    skip = new FlxText(10, 10).setFormat(Paths.font('vcr.ttf'), 24, 0xFF000000, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    skip.text = 'Click to skip';
    skip.alpha = 0.75;
    skip.cameras = [/*camOther*/camHUD];

    var meme:CustomShader  = new CustomShader("meme");
    defaultCamZoom = 1.8;
}

function postCreate()
{
    camFollow.getPosition(1280 / 2 - 1, 720 / 2 - 1);
    isCameraOnForcedPos = true;

    if (!PlayState.isStoryMode)
    {
        for (i in 0...cpuStrums.members.length) {
            cpuStrums.members[i].visible = false;
        }
    
 //       modManager.setValue("opponentSwap", 0.5, 0);
        comboOffsetCustom = [30, 20, 30, 70];
    }
}

function onUpdatePost(elapsed)
{
    //game.camZooming = false;
}

/*function onSpawnNotePost(note:Note)
{
    note.visible = note.mustPress;
    if(ClientPrefs.noteSkin == 'Quants' && gold == true)
    {
        note.colorSwap.hue = ClientPrefs.quantHSV[note.noteData][0] / 360;
        note.colorSwap.saturation = ClientPrefs.quantHSV[note.noteData][1] / 100;
        note.colorSwap.brightness = ClientPrefs.quantHSV[note.noteData][2] / 100;
        note.reloadNote();
    }
}
*/
function goodNoteHit(note){
    if(note.noteType == 'GF Sing')
    {
        if(!mike)
        {
            iconP1.changeIcon('mike');
            healthBar.createFilledBar(FlxColor.fromRGB(10, 170, 210), FlxColor.fromRGB(119, 221, 34));
            healthBar.updateBar();
            mike = true;
        }
        pac = false;
        tazer = false;
    }
    else if(note.noteType == 'Duet')
    {
        gf.playAnim(singAnimations[note.noteData], true);
        gf.holdTimer = 0;
        if(!tazer)
        {
            iconP1.setIcon('tazercraft');
            healthBar.createFilledBar(FlxColor.fromRGB(10, 170, 210), FlxColor.fromRGB(254, 206, 53));
            healthBar.updateBar();
            tazer = true;
        }
        mike = false;
        pac = false;
    }
    else 
    {
        if(!pac)
        {
            iconP1.setIcon('pac');
            healthBar.createFilledBar(FlxColor.fromRGB(10, 170, 210), FlxColor.fromRGB(35, 62, 206));
            healthBar.updateBar();
            trace('mum');
            pac = true;
        }
        mike = false;
        tazer = false;
    }
}

/*function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Hero':
        switch(value1)
        {
            case 'main':
                Bud = false;
                bg.visible = true;
                bgcam.visible = false;
                game.boyfriend.visible = true;
                game.gf.visible = true;
                friends.visible = true;
                overlay.visible = false;
                blueoverlay.visible = false;
                modManager.setValue("opponentSwap", 0.5, 0);
                game.comboOffsetCustom = [30, 20, 30, 70];
                ExUtils.removeShader(meme, game.camGame);
            case 'cam':
                Bud = true;
                bg.visible = false;
                bgcam.visible = true;
                game.boyfriend.visible = false;
                game.gf.visible = false;
                friends.visible = false;
                overlay.visible = true;
                blueoverlay.visible = true;
                modManager.setValue("opponentSwap", 1, 0);
                game.comboOffsetCustom = [1000, 20, 1000, 70];
                ExUtils.addShader(meme, game.camGame);
            case 'gold':
                gold = true;
                ClientPrefs.noteSkin = 'Quants';
                ClientPrefs.quantHSV = [
                    [41, 0, 0],
                    [30, -20, -20],
                    [41, 0, 0],
                    [30, -20, -20],
                    [41, 0, 0],
                    [41, 0, 0],
                    [41, 0, 0],
                    [41, 0, 0],
                    [41, 0, 0],
                    [41, 0, 0],
                    [41, 0, 0]
                ];

        }
    }
}
*/
var s:Float = 1;
var skY:Float = 170;
override function update(elapsed:Float)
{
    defaultCamZoom = 1;
    s += elapsed;
    if (Bud == false)
    {
        dad.y = FlxMath.lerp(dad.y, skY + (Math.cos(s)* 10), FlxMath.bound(1, 0, elapsed * 2));
    }
}

function onGameOverStart() 
{
    setGameOverVideo('tazin');
}

if (PlayState.isStoryMode == true)
{
    function presongCutscene()
    {
        watchingCutscene = true;
        inCutscene = true;
        //camHUD.visible = false;
        intro = new PsychVideoSprite();
        intro.addCallback('onFormat',()->{
            intro.setGraphicSize(FlxG.width,FlxG.height);
            intro.updateHitbox();
            intro.screenCenter();
            intro.antialiasing = true;
            intro.cameras = [/*camOther*/camHUD];
        });
        intro.addCallback('onEnd',()->{
            endIntro();
        });
        intro.load(Paths.video('tazerintro'));
        intro.play();
        add(intro);

        add(skip);
    }
}

function endIntro() {
    intro.stop();
    intro.destroy();
    watchingCutscene = false;
    inCutscene = false;
    camHUD.visible = true;
    hasWatchedCutscene = true;
    startCountdown();
    skip.destroy();
    
    for (i in 0...cpuStrums.members.length) {
        cpuStrums.members[i].visible = false;
    }

 //   modManager.setValue("opponentSwap", 0.5, 0);
 //   comboOffsetCustom = [30, 20, 30, 70];
}

function onUpdatePost(elapsed:Float)
{
    if (FlxG.mouse.justPressed) endIntro();
}

function doStartCountdown()
{
    if (PlayState.isStoryMode == true)
    {
        return Function_Stop;
    }
}

function onDestroy() 
{
 //   ClientPrefs.quantHSV = ogQuants;
   // ClientPrefs.noteSkin = ogNotes;
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 267:
    }
}