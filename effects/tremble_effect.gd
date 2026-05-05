@tool
class_name TrembleEffect
extends RichTextEffect

var bbcode := "tremble"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var rate: float = char_fx.env.get("rate", 20.0)
	var level: float = char_fx.env.get("level", 2.0)
	var t: float = char_fx.elapsed_time * rate + char_fx.relative_index * 7.0
	var offset := Vector2(
		sin(t * 31.7) * level,
		cos(t * 23.3) * level
	)
	char_fx.offset = offset
	return true
