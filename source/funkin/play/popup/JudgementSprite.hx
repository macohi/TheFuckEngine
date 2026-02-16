package funkin.play.popup;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import funkin.util.RhythmUtil;

/**
 * An `FlxSprite` used as a judgement popup.
 * 
 * TODO: Make a base popup class.
 */
class JudgementSprite extends FlxSprite
{
    public function new()
    {
        super();

        scrollFactor.set();
        acceleration.y = 600;
        moves = true;

        loadGraphic(Paths.image('play/ui/judgements'), true, 192, 96);
        setGraphicSize(Std.int(width * Constants.ZOOM));
        updateHitbox();

        animation.add(Judgement.SICK, [0]);
        animation.add(Judgement.GOOD, [1]);
        animation.add(Judgement.BAD, [2]);
        animation.add(Judgement.SHIT, [3]);
    }

    public function popup(judgement:Judgement)
    {
        acceleration.x = FlxG.random.int(-10, 10);
        velocity.y = -250;
        alpha = 1;

        animation.play(judgement);

        new FlxTimer().start(0.5, _ -> {
            FlxTween.tween(this, { alpha: 0 }, 0.5, { ease: FlxEase.quadOut, onComplete: _ -> kill() });
        }); 
    }
}