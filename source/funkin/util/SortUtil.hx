package funkin.util;

import flixel.util.FlxSort;
import funkin.play.note.NoteSprite;

/**
 * A utility class for array sorting.
 */
class SortUtil
{
    public static inline function byTime(order:Int, note1:NoteSprite, note2:NoteSprite):Int
        return FlxSort.byValues(order, note1.time, note2.time);
}