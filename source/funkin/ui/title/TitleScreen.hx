package funkin.ui.title;

import flixel.FlxG;
import funkin.data.character.CharacterRegistry;
import funkin.play.Character;

class TitleScreen extends FunkinState
{
	var titleGF:Character;
	
	var camZoom:Float = 1.15;

	override function create()
	{
		super.create();

		titleGF = CharacterRegistry.instance.fetchCharacter('title-gf');
		add(titleGF);

		titleGF.dance();
		titleGF.updateHitbox();
		 
		titleGF.screenCenter();

		conductor.bpm = 102;
		conductor.time = 0;
		FlxG.sound.playMusic(Paths.sound('music/freakyMenu'), 1, true);

		FlxG.camera.zoom = camZoom;
	}

	override function beatHit(beat:Int)
	{
		super.beatHit(beat);

		titleGF.dance();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		conductor.time += elapsed * Constants.MS_PER_SEC;
		conductor.update();
	}
}
