package funkin.play;

import funkin.data.song.SongData;

/**
 * A class containing meta and chart data for a song.
 */
class Song
{
    public var id:String;
    public var meta:SongMetadata;
    public var chart:SongChartData;

    public var name(get, never):String;
    public var bpm(get, never):Float;
    public var speed(get, never):Float;

    public function new(id:String, meta:SongMetadata, chart:SongChartData)
    {
        this.id = id;
        this.meta = meta;
        this.chart = chart;
    }

    public function getNotes():Array<SongNoteData>
        return chart.notes ?? [];

    inline function get_name():String
        return meta.name;

    inline function get_bpm():Float
        return meta.bpm;

    inline function get_speed():Float
        return chart.speed;
}