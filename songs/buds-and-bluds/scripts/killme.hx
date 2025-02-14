// I'm so exhausted man
var bfZoom:Float = 0.6;
var bossZoom:Float = 0.5;

var camCanZoom:Bool = true;
var camZoomOveride:Bool = false;

var mosaic:CustomShader  = new CustomShader("mosaic");
var mosaicStrength:Float = 1;

var shit = null; //array of stuff from da HUD

var bossTweak:Float = 0;
var bfTweak:Float = 0;
var iconCanTweak:Bool = true;
var isSpinning:Bool = false;

function Create() {}
introLength = 0;
function onCountdown(event) event.cancel();
function postCreate(){
    shit = [scoreTxt, healthBarBG, healthBar, iconP1, iconP2];
}

function onMoveCamera(){ 
    if(!camZoomOveride)
    {
        switch(game.whosTurn)
        {
            case 'dad':
                game.defaultCamZoom = bossZoom;
            case 'boyfriend':
                game.defaultCamZoom = bfZoom;
        }
    }
}

function onUpdate(elapsed:Float)
{
    game.camZooming = camCanZoom;

    if (isSpinning) {
        game.iconP2.angle += elapsed * (60 / curBpm) * 12000;
    }
}
function beatHit()
{
    // i love you tweaking icons
    if (iconCanTweak) {
        var degreeMult:Float = ((curBeat % 2) * 2) - 1;

        FlxTween.angle(iconP1, bfTweak * degreeMult, 0, 60 / curBeat, {ease: FlxEase.sineOut});
        FlxTween.angle(iconP2, bossTweak * degreeMult, 0, 60 / curBeat, {ease: FlxEase.sineOut});
    }
}
function onDestroy() {
    if (intro != null) intro.destroy();
    if (emotional != null) emotional.destroy();
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 127:
            bossTweak = 5;
            bfTweak = 0;
        case 176 | 239 | 303 | 1031:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.6, {ease: FlxEase.elasticOut});
        case 184 | 247 | 311 | 767 | 799 | 1047 | 1111 | 1143:
            FlxTween.tween(FlxG.camera, {zoom: 1.4}, 0.6, {ease: FlxEase.elasticOut});
        case 144 | 208 | 271 | 335 | 895:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 1.2, {ease: FlxEase.elasticOut});
        case 367:
            FlxTween.tween(FlxG.camera, {zoom: 0.95}, 0.45, {ease: FlxEase.elasticOut});
        case 373:
            FlxTween.tween(FlxG.camera, {zoom: 1.3}, 0.3, {ease: FlxEase.elasticOut});
        case 382:
            bossTweak = 15;
            bfTweak = 15;
        case 383:
            FlxTween.tween(FlxG.camera, {zoom: 1}, 1.2, {ease: FlxEase.elasticIn});
        case 399 | 415 | 431 | 447 | 463 | 479 | 1215 | 1231 | 1247:
            FlxTween.tween(FlxG.camera, {zoom: 1.15}, 0.6, {ease: FlxEase.elasticIn});
        case 423 | 455 | 487 | 831 | 863:
            FlxTween.tween(FlxG.camera, {zoom: 1.25}, 0.6, {ease: FlxEase.elasticOut});
        case 495 | 1263:
            FlxTween.tween(FlxG.camera, {zoom: 1.15}, 0.3, {ease: FlxEase.elasticIn});
        case 499:
            FlxTween.tween(FlxG.camera, {zoom: 0.86}, 1.2, {ease: FlxEase.elasticOut});
        case 515:
            FlxTween.tween(FlxG.camera, {zoom: 1.1}, 0.3, {ease: FlxEase.elasticIn});
        case 519 | 727 | 1383:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.6, {ease: FlxEase.elasticIn});
        case  527 | 543 | 559 | 575 | 591 | 607 | 719 | 1279 | 1295 | 1311 | 1327 | 1343 | 1359 | 1375:
            FlxTween.tween(FlxG.camera, {zoom: 1.1}, 0.6, {ease: FlxEase.elasticIn});
        case  551 | 583 | 615 | 815 | 1095 | 1287 | 1319 | 1351:
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.6, {ease: FlxEase.elasticOut});
        case 623:
            FlxTween.tween(FlxG.camera, {zoom: 1.45}, 0.6, {ease: FlxEase.elasticIn});
 //       case 623:
//            FlxTween.tween(FlxG.camera, {zoom: 1.6}, 0.6, {ease: FlxEase.elasticIn});
        case 638:
            bossTweak = 20;
            bfTweak = 20;
        case 639:
            FlxTween.tween(FlxG.camera, {zoom: 0.95}, 0.6, {ease: FlxEase.elasticOut});
        case 655 | 687 | 1167 | 1183 | 1199:
            FlxTween.tween(FlxG.camera, {zoom:1.15}, 0.6, {ease: FlxEase.elasticIn});
        case 663 | 696 | 1191 | 1223 | 1255:
            FlxTween.tween(FlxG.camera, {zoom:1.25}, 0.6, {ease: FlxEase.elasticIn});
        case 735:
            FlxTween.tween(FlxG.camera, {zoom:0.85}, 2.1, {ease: FlxEase.elasticIn});
        case 763:
            FlxTween.tween(FlxG.camera, {zoom:1.1}, 0.3, {ease: FlxEase.elasticOut});
        case 766:
            bossTweak = 25;
            bfTweak = 25;
        case 775 | 807:
            FlxTween.tween(FlxG.camera, {zoom:1.6}, 0.6, {ease: FlxEase.elasticOut});
        case 783 | 847:
            FlxTween.tween(FlxG.camera, {zoom:0.95}, 1.2, {ease: FlxEase.elasticOut});
        case 823:
            FlxTween.tween(FlxG.camera, {zoom:1}, 0.6, {ease: FlxEase.elasticOut});
        case 839:
            FlxTween.tween(FlxG.camera, {zoom:1.35}, 0.6, {ease: FlxEase.elasticOut});
        case 871:
            FlxTween.tween(FlxG.camera, {zoom:1.45}, 0.6, {ease: FlxEase.elasticOut});
        case 879:
            FlxTween.tween(FlxG.camera, {zoom:0.825}, 1.2, {ease: FlxEase.elasticOut});
        case 879:
            bossTweak = 8;
            bfTweak = 8;
        case 911:
            FlxTween.tween(FlxG.camera, {zoom:1.1}, 1.2, {ease: FlxEase.elasticOut});
        case 927:
            FlxTween.tween(FlxG.camera, {zoom:1.25}, 1.2, {ease: FlxEase.elasticOut});
        case 943:
            FlxTween.tween(FlxG.camera, {zoom:1.05}, 1.2, {ease: FlxEase.elasticOut});
        case 959:
            FlxTween.tween(FlxG.camera, {zoom:1.22}, 1.2, {ease: FlxEase.elasticOut});
        case 975:
            FlxTween.tween(FlxG.camera, {zoom:1.12}, 1.2, {ease: FlxEase.elasticOut});
        case 991:
            FlxTween.tween(FlxG.camera, {zoom:1.2}, 1.2, {ease: FlxEase.elasticOut});
        case 1007:
            FlxTween.tween(FlxG.camera, {zoom:1.35}, 0.45, {ease: FlxEase.elasticOut});
        case 1013:
            FlxTween.tween(FlxG.camera, {zoom:1.4}, 0.75, {ease: FlxEase.elasticOut});
        case 1039 | 1103:
            FlxTween.tween(FlxG.camera, {zoom:1.3}, 0.6, {ease: FlxEase.elasticOut});
        case 1055:
            FlxTween.tween(FlxG.camera, {zoom:0.95}, 2.4, {ease: FlxEase.elasticOut});
        case 1119:
            FlxTween.tween(FlxG.camera, {zoom:0.85}, 1.8, {ease: FlxEase.elasticOut});
        case 1139:
            FlxTween.tween(FlxG.camera, {zoom:1}, 0.6, {ease: FlxEase.elasticIn});
        case 1150:
            bossTweak = 40;
            bfTweak = 40;
        case 1150:
            bossTweak = 40;
            bfTweak = 40;
        case 1267:
            FlxTween.tween(FlxG.camera, {zoom:0.86}, 0.95, {ease: FlxEase.elasticOut});
        case 1391:
            FlxTween.tween(FlxG.camera, {zoom:1.3}, 0.6, {ease: FlxEase.elasticIn});
        case 1399:
            FlxTween.tween(FlxG.camera, {zoom:1.4}, 0.6, {ease: FlxEase.elasticIn});
        case 1267:
            bossTweak = 45;
            bfTweak = 45;
        case 1407:
            FlxG.camera.addShader(mosaic);camHUD.addShader(mosaic);
            FlxTween.tween(FlxG.camera, {zoom:1.5}, 1.5, {ease: FlxEase.smootherStepInOut});
            FlxTween.num(1, 25, 1.5, {ease: FlxEase.linear, onUpdate: function(strength:FlxTween){
                mosaic.data.uBlocksize.value = [strength.value, strength.value];
            }});
        case 1406:
            bossTweak = 45;
            bfTweak = 45;
        case 1410:
            bossTweak = 50;
            bfTweak = 50;
        case 1414:
            bossTweak = 55;
            bfTweak = 55;
        case 1418:
            bossTweak = 60;
            bfTweak = 60;
        case 1422:
            bossTweak = 60;
            bfTweak = 60;
        case 1423:
            FlxG.camera.removeShader(mosaic);camHUD.removeShader(mosaic);
            for(s in shit){ s.alpha = 0; }
        case 1439:
            defaultCamZoom = 0.65;
        case 1455:
            for(s in shit){ FlxTween.tween(s, {alpha: 1}, 0.25, {ease: FlxEase.quadOut}); }
            FlxTween.num(1, 0, 0.25, {ease: FlxEase.quadOut});
        case 1471:
            for(s in shit){ s.alpha = 1; }
            camGame.alpha = 1;
        //                    ExUtils.addShader(rainShader, game.camGame);
        case 1664:
            FlxTween.tween(FlxG.camera, {zoom:1.3}, 8.4, {ease: FlxEase.elasticIn});
        case 1760:
            FlxTween.tween(FlxG.camera, {zoom:1.2}, 8.4, {ease: FlxEase.elasticIn});
        case 1843:
            bossTweak = 20;
            bfTweak = 5;
        case 1856:
            bossTweak = 20;
            bfTweak = 5;
        case 1901:
            bossTweak = 80;
            bfTweak = 80;
    }
}