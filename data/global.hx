//
import funkin.menus.MainMenuState;
import funkin.menus.StoryMenuState;
function update(elapsed:Float)
	if (FlxG.keys.justPressed.F5) FlxG.resetState();
var redirectStates:Map<FlxState, String> = [
    MainMenuState => "TitleState", 
];
function preStateSwitch() {
	for (redirectState in redirectStates.keys())
		if (FlxG.game._requestedState is redirectState)
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}