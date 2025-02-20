function stepHit(curStep)
{
    switch (curStep)
    {
        case 128 | 704:
            FlxTween.tween(FlxG.camera, {zoom: 1.1}, 0.5);
        case 218:
            FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1);
        case 224 | 736:
            FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.5);
        case 433 | 560:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 1);
        case 445:
            FlxTween.tween(FlxG.camera, {zoom: 0.75}, 0.5);
        case 574:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.5);
        case 764:
            FlxTween.tween(camHUD, {alpha: 0}, 0.3);
        case 184:
            FlxTween.tween(camHUD, {alpha: 1}, 0);
    }
}