function onEvent(_) {
	if (_.event.name == 'tweenStrumAlpha') {
		trace("Oh_my_lag_spike.","\n",_.event.params[0],'\n',_.event.params[1],cpuStrums.members[1].alpha);
		for (i in 0...4) { 
			for (noteOPP in strumLines.members[0].notes)
			for(oppFUCK in _.event.params[5] ? [cpuStrums.members[i],noteOPP] : [cpuStrums.members[i]]){
				FlxTween.cancelTweensOf(oppFUCK,['alpha']);
				_.event.params[4] ?
			FlxTween.tween(oppFUCK, {alpha: _.event.params[0]}, _.event.params[2],
				{ease:CoolUtil.flxeaseFromString( _.event.params[3])}) : oppFUCK.alpha=_.event.params[0];
			}
			for (notePLAYER in strumLines.members[1].notes)
			for(playerFUCK in _.event.params[5] ? [playerStrums.members[i],notePLAYER]:[playerStrums.members[i]]){
				FlxTween.cancelTweensOf(playerFUCK,['alpha']);
				_.event.params[4] ?
			FlxTween.tween(playerFUCK, {alpha: _.event.params[1]}, _.event.params[2],
				{ease:CoolUtil.flxeaseFromString( _.event.params[3])}) : playerFUCK.alpha=_.event.params[1];
			}
		}
	}
}