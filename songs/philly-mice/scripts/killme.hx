
function stepHit(curStep)
{
    switch (curStep)
    {
        case 0:
            FlxTween.tween(FlxG.camera, {zoom: 1.02}, 0.001);
        case 3:
            FlxTween.tween(FlxG.camera, {zoom: 1.04}, 0.001);
        case 7:
            FlxTween.tween(FlxG.camera, {zoom: 1.06}, 0.001);
        case 11:
            FlxTween.tween(FlxG.camera, {zoom: 1.08}, 0.001);
        case 144:
            FlxTween.tween(FlxG.camera, {zoom: 1.8});
        case 400 | 431 | 463 | 495 | 527 | 559 | 591 | 623 | 1200 | 1264 | 1296 | 1328 | 1360 | 1392:
            FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.3);
        case 406 | 437 | 469 | 501 | 533 | 565 | 597 | 629 | 1174 | 1206| 1238 | 1270 | 1302 | 1334 | 1366 | 1398:
            FlxTween.tween(FlxG.camera, {zoom: 1.07}, 0.3);
        case 413 | 445 | 477 | 509 | 541 | 573 | 605 | 637 | 1042| 1182 | 1214 | 1246 | 1278 | 1310 | 1342 | 1374 | 1406:
            FlxTween.tween(FlxG.camera, {zoom: 0.9});
        case 647 | 1074 | 1088:
            FlxTween.tween(FlxG.camera, {zoom: 1.1});
        case 655:
            FlxTween.tween(FlxG.camera, {zoom: 0.85});
        case 911 | 917 | 943 | 949 | 967 | 971 | 975 | 981 | 1007 | 1013 | 1032 | 1036 | 1104 | 1110 | 1136 | 1142 | 1148 | 1152 | 1156 | 1160 | 1164:
            FlxTween.tween(FlxG.camera, {zoom: 1.05});
        case 927 | 933 | 959 | 963 | 991 | 997 | 1024 | 1028 | 1120 | 1126:
            FlxTween.tween(FlxG.camera, {zoom: 0.95});
        case 1096:
            FlxTween.tween(FlxG.camera, {zoom: 0.8});
        case 1168:
            FlxTween.tween(FlxG.camera, {zoom: 0.7});
        case 1424:
            FlxTween.tween(FlxG.camera, {zoom: 1.2});
    }
}