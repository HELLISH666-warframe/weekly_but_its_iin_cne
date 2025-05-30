var tween1:FlxTween;
var tween2:FlxTween;
var moveTween:FlxTween;
var opTween:FlxTween;
var black:FlxSprite;
var punch:Bool = false;
function beatHit()
{
    if(tween1 != null)
    {
        tween1.cancel();
    }
    if(tween2 != null)
    {
        tween2.cancel();
    }
    if(boyfriend.animation.curAnim.name == 'idle')
    {
        if(boyfriend.x != 950)
        {
            boyfriend.x = 950;
        }   
        boyfriend.y = 635 - 25;
        tween1 = FlxTween.tween(boyfriend, {y: 635}, 0.3, {ease: FlxEase.expoOut});
    }
    if(dad.animation.curAnim.name == 'idle')
    {
        if(dad.x != 220)
        {
            dad.x = 220;
        } 
        dad.y = 560 - 25;
        tween2 = FlxTween.tween(dad, {y: 560}, 0.3, {ease: FlxEase.expoOut});
    }
}
function opponentNoteHit(note){ 
    if(opTween != null)
    {
        opTween.cancel();
        dad.x = 220;
        dad.y = 560;
    }

    switch(note.noteData)
    {
        case 0:
            dad.x = 200;
            dad.y = 560;
            if(!note.isSustainNote)
            {
                opTween = FlxTween.tween(dad, {x: 220}, 0.3, {ease: FlxEase.expoOut});
            }
            else
            {
                dad.x = 220;
            }
        case 1:
            dad.y = 590;
            dad.x = 220;
            if(!note.isSustainNote)
            {
                opTween = FlxTween.tween(dad, {y: 560}, 0.3, {ease: FlxEase.expoOut});
            }
            else
            {
                dad.y = 560;
            }
        case 2:
            dad.y = 540;
            dad.x = 220;
            if(!note.isSustainNote)
            {
                opTween = FlxTween.tween(dad, {y: 560}, 0.3, {ease: FlxEase.expoOut});
            }
            else
            {
                dad.y = 560;
            }
        case 3:
            dad.x = 260;
            dad.y = 560;
            if(!note.isSustainNote)
            {
                opTween = FlxTween.tween(dad, {x: 220}, 0.3, {ease: FlxEase.expoOut});
            }
            else
            {
                dad.x = 220;
            }
    }
}
function goodNoteHit(note){
    if(moveTween != null)
    {
        moveTween.cancel();
        boyfriend.x = 950;
        boyfriend.y = 635;
    }
    if(punch == false)
    {
        switch(note.noteData) // this fucking sucks kill me bro
        {
            case 0:
                boyfriend.x = 880;
                boyfriend.y = 635;
                if(!note.isSustainNote)
                {
                    moveTween = FlxTween.tween(boyfriend, {x: 950}, 0.3, {ease: FlxEase.expoOut});
                }
                else
                {
                    boyfriend.x = 950;
                }
            case 1:
                boyfriend.y = 705;
                boyfriend.x = 950;
                if(!note.isSustainNote)
                {
                    moveTween = FlxTween.tween(boyfriend, {y: 635}, 0.3, {ease: FlxEase.expoOut}); 
                }
                else
                {
                    boyfriend.y = 635;
                }
            case 2:
                boyfriend.y = 605;
                boyfriend.x = 950;
                if(!note.isSustainNote)
                {
                    moveTween = FlxTween.tween(boyfriend, {y: 635}, 0.3, {ease: FlxEase.expoOut}); 
                }
                else
                {
                    boyfriend.y = 635;
                }
            case 3:
                boyfriend.x = 980;
                boyfriend.y = 635;
                if(!note.isSustainNote)
                {
                    moveTween = FlxTween.tween(boyfriend, {x: 950}, 0.3, {ease: FlxEase.expoOut});
                }
                else
                {
                    boyfriend.x = 950;
                }
        }
    }
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 1015:
            punch = true;
            if (!tween1 == null)
            {
                tween1.cancel();
            }
            if (!tween2 == null)
            {
                tween2.cancel();
            }
            if (moveTween != null)
            {
                moveTween.cancel();
            }
           FlxTween.tween(boyfriend, {x: boyfriend.x + 200}, 0.35, {ease: FlxEase.expoOut, 
            onComplete: function(tween:FlxTween) {
                FlxTween.tween(boyfriend, {x: boyfriend.x - 700}, 0.6, {ease: FlxEase.expoIn});
            }});
            case 1023:
            var black:FlxSprite = new FlxSprite(0,0);
            black.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
            black.antialiasing = true;
            black.screenCenter();
            black.cameras = [camHUD];
            add(black);

            var ending:FlxSprite = new FlxSprite(0,0);
            ending.loadGraphic(Paths.image("stages/venom/spidersting"));
            ending.antialiasing = true;
            ending.screenCenter();
            ending.cameras = [camHUD];
            add(ending);

            var flash:FlxSprite = new FlxSprite(0,0);
            flash.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
            flash.antialiasing = true;
            flash.screenCenter();
            flash.cameras = [camHUD];
            flash.alpha = 0.8;
            add(flash);
            FlxTween.tween(flash, {alpha: 0}, 0.6, {ease: FlxEase.expoOut});
            FlxTween.tween(ending, {alpha: 0}, 4);
    }
}