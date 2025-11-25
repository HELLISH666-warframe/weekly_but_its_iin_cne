import openfl.display.BlendMode;

function postCreate() {
    cameoDistant.antialiasing = false;

    light.blend = BlendMode.ADD;

    cameoFG.antialiasing = false;

    /*
    rainShader = newShader('rain');
    rainShader.setFloatArray('uScreenResolution', [FlxG.width, FlxG.height]);
    rainShader.setFloat('uTime', 0);
    rainShader.setFloat('uScale', FlxG.height / 200);
    rainShader.setFloat('uIntensity', rainIntensity);
    ExUtils.addShader(rainShader, game.camGame);
    */

    black.camera = camOther;
    add(black);
}