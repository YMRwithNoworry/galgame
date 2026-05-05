@tool
class_name FloatEffect
extends RichTextEffect

var bbcode := "float"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed: float = char_fx.env.get("speed", 2.0)
	var amplitude: float = char_fx.env.get("amplitude", 5.0)
	var t: float = char_fx.elapsed_time * speed + char_fx.relative_index * 0.8
	var offset := Vector2(
		sin(t * 2.0) * amplitude * 0.3,
		sin(t * 1.5) * amplitude
	)
	char_fx.offset = offset
	return true
