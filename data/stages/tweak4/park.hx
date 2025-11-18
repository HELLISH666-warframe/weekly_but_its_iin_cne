var crowd:FlxSprite;

//I_no_like_how_stage_xmls_handles_anims_ok?
function create() {
    crowd = new FlxSprite(-650, 480);
    crowd.frames = Paths.getSparrowAtlas("stages/tweak4//minus/crowd");
    crowd.antialiasing = true;
    crowd.animation.addByPrefix('idle', 'crowd', 24, false);
    crowd.animation.play("idle");
    crowd.scrollFactor.set(0.9, 0.9);
    insert(3, crowd);
    trace(boyfriend.x,boyfriend.y);
}

function beatHit() if(curBeat % 2 == 0) crowd.animation.play('idle', true);

function onSongStart() crowd.animation.play('idle', true);

function onCountdownTick(swagCounter) if(swagCounter % 2 == 0) crowd.animation.play('idle', true);

function onGameOverStart() setGameOverVideo('minus');