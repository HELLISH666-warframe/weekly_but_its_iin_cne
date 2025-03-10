import flixel.addons.transition.TransitionSubstate;
import flixel.addons.transition.FlxTransitionSprite.TransitionStatus;
import flixel.util.FlxGradient;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.util.FlxColor;

class FadeTransitionSubstate extends TransitionSubstate
{
  var _finalDelayTime:Float = 0.0;

  public static var defaultCamera:FlxCamera;
  public static var nextCamera:FlxCamera;
  public static var tweak10:Bool = false;
  public static var firstLoad:Bool = false;

  var curStatus:TransitionStatus;

  var gradient:FlxSprite;
  var gradientFill:FlxSprite;
  public static var backBlack:FlxSprite;

  public function new(){
    super();
  }

  public override function destroy():Void
  {
    super.destroy();
    if(!tweak10){
      if(gradient!=null)
        gradient.destroy();

      if(gradientFill!=null)
        gradientFill.destroy();

      gradient=null;
      gradientFill=null;
    }
    finishCallback = null;  
  }

  function onFinish(f:FlxTimer):Void
  {
    if (finishCallback != null)
    {
      finishCallback();
      finishCallback = null;
    }
  }

  function delayThenFinish():Void
  {
    new FlxTimer().start(_finalDelayTime, onFinish); // force one last render call before exiting
  }

  public override function update(elapsed:Float){
    if(gradientFill!=null && gradient!=null && !tweak10){
      switch(curStatus){
        case IN:
          gradientFill.y = gradient.y - gradient.height;
        case OUT:
          gradientFill.y = gradient.y + gradient.height;
        default:
      }
    }
    super.update(elapsed);
  }


  override public function start(status: TransitionStatus){
    var cam = nextCamera!=null?nextCamera:(defaultCamera!=null?defaultCamera:FlxG.cameras.list[FlxG.cameras.list.length - 1]);
    cameras = [cam];

    nextCamera = null;
    //trace('transitioning $status');
    curStatus=status;
    var yStart:Float = 0;
    var yEnd:Float = 0;
    var duration:Float = .48;
    var angle:Int = 90;
    var zoom:Float = FlxMath.bound(cam.zoom,0.001);
    var width:Int = Math.ceil(cam.width/zoom);
    var height:Int = Math.ceil(cam.height/zoom);

    yStart = -height;
    yEnd = height;

    switch(status){
      case IN:
      case OUT:
        angle=270;
        duration = .8;
      default:
        //trace("bruh");
    }
    if(!tweak10){
      gradient = FlxGradient.createGradientFlxSprite(1, height, [FlxColor.BLACK, FlxColor.TRANSPARENT], 1, angle);
      gradient.scale.x = width;
      gradient.scrollFactor.set();
      gradient.screenCenter(X);
      gradient.y = yStart;

      gradientFill = new FlxSprite().generateGraphic(width,height,FlxColor.BLACK);
      gradientFill.screenCenter(X);
      gradientFill.scrollFactor.set();
      add(gradientFill);
      add(gradient);

      FlxTween.tween(gradient,{y: yEnd}, duration,{
        onComplete: function(t:FlxTween){
          //trace("done");
          delayThenFinish();
        }
      });
    }
    else
    {
      delayThenFinish();
    }
  }
}
