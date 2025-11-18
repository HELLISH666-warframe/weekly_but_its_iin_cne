function new() {   
    FlxG.save.data.TimeBar ??= "disabled";
    FlxG.save.data.WEEKLYSPLASHSCREEN ??= true;
}
import funkin.backend.system.Flags;
Flags.DISABLE_WARNING_SCREEN=!FlxG.save.data.WEEKLYSPLASHSCREEN;