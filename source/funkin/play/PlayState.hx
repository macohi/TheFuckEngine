package funkin.play;

import funkin.play.note.Strumline;
import funkin.ui.FunkinState;

/**
 * A state where the gameplay occurs. Kinda like a "play" state. Hah! I said the thing!
 */
class PlayState extends FunkinState
{
	var loadedSong:Bool = false;

	var opponentStrumline:Strumline;
	var playerStrumline:Strumline;

	override public function create()
	{
		opponentStrumline = new Strumline();
		opponentStrumline.offset = 0.25;
		add(opponentStrumline);

		playerStrumline = new Strumline();
		playerStrumline.offset = 0.75;
		add(playerStrumline);

		loadSong();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (loadedSong)
		{
			conductor.time += elapsed * Constants.MS_PER_SEC;
			conductor.update();
		}

		opponentStrumline.process(false);
		playerStrumline.process(true);

		processInput();

		super.update(elapsed);
	}

	function loadSong()
	{
		conductor.bpm = 100;
		conductor.time = -conductor.crotchet * 4;

		playerStrumline.data = [{ t: 0, d: 0 }, { t: 1000, d: 1 }, { t: 2000, d: 2 }, { t: 3000, d: 3 }];
		playerStrumline.speed = 1;

		loadedSong = true;
	}

	function processInput()
	{
		// Player input
		playerStrumline.strums.forEach(strum -> {
			if (strum.direction.pressed)
				strum.animation.play('press');
			else
				strum.animation.play('static');
		});
	}
}
