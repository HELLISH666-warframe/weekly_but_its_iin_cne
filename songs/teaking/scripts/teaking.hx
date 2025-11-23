var jump:FlxSprite;

function postCreate() {
    jump = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/jumpscare!"));
    jump.setGraphicSize(1280, 720);
    jump.screenCenter();
    jump.alpha = 0.000001;
    jump.antialiasing = true;
    jump.camera = camOther;
    add(jump);
}

function jumpscare(val:String){
    switch(val){
        case "true": jump.alpha = 1;
        default: jump.alpha = 0.000001;	
    }
}