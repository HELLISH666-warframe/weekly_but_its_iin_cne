var baby:FlxSprite;

function postCreate() {
    baby = new FlxSprite().loadGraphic(Paths.image("stages/tweak0/baby"));
    baby.antialiasing = true;
    baby.x = boyfriend.x;
    baby.y = boyfriend.y + 400;
    baby.alpha = 0.001;
	add(baby); 
}

function baby(val:String){
    switch(val){
        case "baby": baby.alpha = 1; boyfriend.alpha = 0.001;	
        default: baby.alpha = 0.001; boyfriend.alpha = 1;
    }
}