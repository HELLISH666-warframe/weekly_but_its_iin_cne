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
}

function onMoveCamera(){ 
}

function onUpdate(elapsed:Float)
{
}
function beatHit()
{
}
function onDestroy() {
}
function stepHit(curStep)
{
    switch (curStep)
    {
    }
}