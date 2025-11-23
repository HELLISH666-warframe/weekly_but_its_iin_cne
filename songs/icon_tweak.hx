if(SONG.meta.tweak==0||SONG.meta.tweak==11)
function beatHit(curBeat:Int) {
    var targetRotate:Int = curBeat / 2;
    if (curBeat % 2 == 0) targetRotate *= -1;

    for(i in [iconP1,iconP2]){FlxTween.cancelTweensOf(i,['angle']);
        FlxTween.angle(i, targetRotate, 0, 0.3, {ease: FlxEase.quadOut});
    }
}