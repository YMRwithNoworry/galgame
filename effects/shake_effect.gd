@tool
class_name ShakeEffect
extends RichTextEffect

var bbcode := "shake"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var rate: float = char_fx.env.get("rate", 5.0)
	var level: float = char_fx.env.get("level", 5.0)
	var t: float = char_fx.elapsed_time * rate
	var offset := Vector2(
		sin(t * 17.0 + char_fx.relative_index * 1.3) * level,
		cos(t * 13.0 + char_fx.relative_index * 2.1) * level * 0.6
	)
	char_fx.offset = offset
	return true
