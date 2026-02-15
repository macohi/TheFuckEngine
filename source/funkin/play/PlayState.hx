package funkin.play;

import flixel.FlxG;
import flixel.util.FlxSort;
import funkin.data.song.SongData.SongNoteData;
import funkin.play.note.NoteDirection;
import funkin.play.note.NoteSprite;
import funkin.play.note.Strumline;
import funkin.ui.FunkinState;

/**
 * A state where the gameplay occurs. Kinda like a "play" state. Hah! I said the thing!
 */
class PlayState extends FunkinState
{
	public static var instance:PlayState;
	public static var song:Song;

	var loadedSong:Bool = false;

	var opponentStrumline:Strumline;
	var playerStrumline:Strumline;

	public function new()
	{
		super();

		instance = this;
	}

	override public function create()
	{
		opponentStrumline = new Strumline();
		opponentStrumline.offset = 0.25;
		add(opponentStrumline);

		playerStrumline = new Strumline();
		playerStrumline.offset = 0.75;
		add(playerStrumline);

		loadSong();

		FlxG.camera.bgColor = 0xFF252525;

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
		playerStrumline.process(!Preferences.botplay);

		processInput();

		if (FlxG.keys.justPressed.R) FlxG.resetState();

		super.update(elapsed);
	}

	function loadSong()
	{
		conductor.bpm = song.bpm;
		conductor.time = -conductor.crotchet * 4;

		playerStrumline.speed = song.speed;
		opponentStrumline.speed = playerStrumline.speed;

		var notes:Array<SongNoteData> = song.getNotes();

		// Sorts the notes because yeah uh why not
		// If you want to have messed up note spawning, remove the sort
		notes.sort((note1, note2) -> return FlxSort.byValues(FlxSort.ASCENDING, note1.t, note2.t));
		
		for (noteData in notes)
		{
			if (noteData.d >= Constants.NOTE_COUNT)
				opponentStrumline.data.push(noteData);
			else
				playerStrumline.data.push(noteData);
		}

		loadedSong = true;
	}

	function processInput()
	{
		// Player input
		var directionNotes:Array<Array<NoteSprite>> = [[], [], [], []];

		for (note in playerStrumline.getMayHitNotes()) directionNotes[note.direction].push(note);

		for (i in 0...directionNotes.length)
		{
			var note:NoteSprite = directionNotes[i][0];
			var direction:NoteDirection = NoteDirection.fromInt(i);
			var pressed:Bool = direction.justPressed || Preferences.botplay;

			if (!pressed || note == null) continue;

			playerStrumline.hitNote(note);
			playerStrumline.playSplash(direction);
		}

		// Opponent input
		for (note in opponentStrumline.getMayHitNotes())
			opponentStrumline.hitNote(note);
	}
}
