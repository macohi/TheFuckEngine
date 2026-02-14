package funkin.util;

import flixel.util.FlxSort;
import funkin.play.note.NoteSprite;

/**
 * A utility class for array sorting.
 */
class SortUtil
{
    public static inline function sortNotes(notes:Array<NoteSprite>):Array<NoteSprite>
    {
        notes.sort((note1, note2) -> return FlxSort.byValues(FlxSort.ASCENDING, note1.time, note2.time));
        return notes;
    }
}