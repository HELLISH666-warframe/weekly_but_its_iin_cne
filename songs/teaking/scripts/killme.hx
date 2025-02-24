import flixel.text.FlxTextBorderStyle;
function postCreate(){
    text = new FlxText(1280, 100);
    text.cameras = [camHUD];
    text.setFormat(Paths.font("BRLNSDB.ttf"), 50, FlxColor.WHITE, 'CENTER', FlxTextBorderStyle.OUTLINE, 0xFF000000);
    text.text = '';
    text.color = 0xFFFFFFFF;
    text.width = 100;
    text.antialiasing = true;
    text.updateHitbox();
    text.screenCenter(FlxAxes.X);
    text.screenCenter(FlxAxes.Y);
    text.borderSize = 3;
    add(text);
}
function beatHit() {
    switch(curBeat) {
 //       case 191:
   //     isCameraOnForcedPos = false;
        case 192:
        iconP2.visible = true;
        dad.visible = true;
    }
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 130:
            text.text = 'i';
            text.screenCenter(FlxAxes.X);
        case 132:
            text.text = 'think';
            text.screenCenter(FlxAxes.X);
        case 133:
            text.text = 'this';
            text.screenCenter(FlxAxes.X);
        case 134:
            text.text = 'is';
            text.screenCenter(FlxAxes.X);
            //shit_isnt_dead_on_ill_fix_it_later
        case 135:
            text.text = 'worthy';
            text.screenCenter(FlxAxes.X);
//grrr
        case 137:
            text.text = 'of a';
            text.screenCenter(FlxAxes.X);
        case 139:
            text.text = 'jersey';
            text.screenCenter(FlxAxes.X);
        case 141:
            text.text = 'club';
            text.screenCenter(FlxAxes.X);
        case 143:
            text.text = 'beat';
            text.screenCenter(FlxAxes.X);
        case 146:
            text.text = 'i';
            text.screenCenter(FlxAxes.X);
            //FUCKER_18456.25,
        case 147:
            text.text = 'agree';
            text.screenCenter(FlxAxes.X);
        case 152:
            text.text = 'check';
            text.screenCenter(FlxAxes.X);
            //GRRRR_ 19212.5,
        case 153:
            text.text = 'this';
            text.screenCenter(FlxAxes.X);
            //AHHHH_9434.375,
        case 155:
            text.text = 'out';
            text.screenCenter(FlxAxes.X);
        case 159:
            text.text = 'hit it';
            text.screenCenter(FlxAxes.X);
        case 161:
            text.text = 'teaking';
            text.screenCenter(FlxAxes.X);
        case 163:
            text.text = 'boss';
            text.screenCenter(FlxAxes.X);
        case 166:
            text.text = 'fuck';
            text.screenCenter(FlxAxes.X);
            //FUCK_YOU_20937.5,
        case 167:
            text.text = 'i';
            text.screenCenter(FlxAxes.X);
            //WHY_WHY_WHY_21062.5,
        case 168:
            text.text = 'mean';
            text.screenCenter(FlxAxes.X);
        case 170:
            text.text = 'tweaking';
            text.screenCenter(FlxAxes.X);
            //AGGGGGGGGGHHGHGG_21590.625,
        case 172:
            text.text = 'boss';
            text.screenCenter(FlxAxes.X);
        case 176:
            text.text = '';
            text.screenCenter(FlxAxes.X);
        case 192:
            text.text = 'oh';
            text.screenCenter(FlxAxes.X);
    }
}
function flag1()
{
    br.alpha = 1;
    FlxTween.tween(br, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});
}
function flag2()
{
    port.alpha = 1;
    FlxTween.tween(port, {alpha: 0.000001}, 1, {ease: FlxEase.sineIn});	
}