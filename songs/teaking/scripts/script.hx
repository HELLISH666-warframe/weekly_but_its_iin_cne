var barleft:FlxSprite; 
var barRight:FlxSprite; 
var tik:FlxSprite; 
var pee:FlxSprite;
var bee:FlxSprite;

var jump:FlxSprite;

import flixel.text.FlxTextBorderStyle;
var text:FlxText;

var baby:FlxSprite;

var hudshits;

function postCreate() {
    baby = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/baby"));
    baby.antialiasing = true;
    baby.x = boyfriend.x;
    baby.y = boyfriend.y+400;
    baby.alpha = 0.01;
	add(baby); 

    barleft = new FlxSprite(0,0).loadGraphic(Paths.image('stages/tweak0/YALLGONNAHATEMEFORTHIS'));
    barleft.camera = camOther;
    barleft.alpha = 0.0001;
	add(barleft); 
    
    barRight = new FlxSprite(843,0).loadGraphic(Paths.image('stages/tweak0/YALLGONNAHATEMEFORTHIS'));
    barRight.camera = camOther;
    barRight.alpha = 0.0001;
	add(barRight); 

    tik = new FlxSprite(683, 655).loadGraphic(Paths.image('stages/tweak0/sussyfunk'));
    tik.camera = camOther;
    tik.alpha = 0.0001;
    tik.antialiasing = true;
	add(tik); 

    pee = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/tweak0/fuck'));
    pee.camera = camOther;
    pee.alpha = 0.0001;
    pee.setGraphicSize(1280, 720);
    pee.updateHitbox();
    pee.antialiasing = true;
	add(pee); 

    bee = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/tweak0/quote'));
    bee.camera = camOther;
    bee.alpha = 0.0001;
    bee.setGraphicSize(1280, 720);
    bee.updateHitbox();
    bee.antialiasing = true;
	add(bee); 

    jump = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/jumpscare!"));
    jump.setGraphicSize(1280, 720);
    jump.screenCenter();
    jump.alpha = 0.000001;
    jump.antialiasing = true;
    jump.camera = camOther;
    add(jump);

    text = new FlxText(1280, 100);
    text.camera = camHUD;
    text.setFormat(Paths.font("BRLNSDB.ttf"), 50, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    text.text = '';
    text.color = 0xFFFFFFFF;
    text.width = 100;
    text.antialiasing = true;
    text.updateHitbox();
    text.screenCenter(FlxAxes.X);
    text.screenCenter(FlxAxes.Y);
    text.borderSize = 3;
    add(text);
    hudshits=[timeBar,timeBarBG,timeTxt,healthBarBG,healthBar,iconP1,iconP2,scoreTxt,accuracyTxt,missesTxt];
}

function stepHit(curStep:Int)
    switch(curStep) {
        case 130: middleshit(true);
        case 176: middleshit(false);
        case 510: pee.alpha = 1;
        case 517: FlxTween.tween(bee, {alpha: 1}, 2);	
    }


function middleshit(mid:Bool = false){
    if(mid) {
        cameraSpeed = 15;
        tik.alpha = 1;
        barleft.alpha = 1;
        barRight.alpha = 1;
        for(s in hudshits)s.alpha=0.001;
        for (i in 0...4){
		playerStrums.members[i].x -= 325;
        cpuStrums.members[i].x -= 500;
	    }
    } else {
        FlxG.camera.flash(FlxColor.WHITE, 1);
        cameraSpeed = 1;
        tik.alpha = 0;
        barleft.alpha = 0;
        barRight.alpha = 0;
        for(s in hudshits)s.alpha=1;
        for (i in 0...4){
		playerStrums.members[i].x += 325;
        cpuStrums.members[i].x += 500;
	    }
    }
}

function jumpscare(val:String){
    switch(val){
        case "on": jump.alpha = 1;
        default: jump.alpha = 0.000001;	
    }
}

function caption(txt:String){
    text.text = txt;
    text.screenCenter(FlxAxes.X);
    text.screenCenter(FlxAxes.Y);
}

function baby_thang(val:String){
    switch(val){
        case "baby": baby.alpha = 1; boyfriend.alpha = 0.001; iconP1.setIcon('tweak0/fatassbabybruh');
        default: baby.alpha = 0.001; boyfriend.alpha = 1; iconP1.setIcon('bf');
    }
}