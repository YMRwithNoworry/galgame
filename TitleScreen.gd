extends Control

@onready var content: VBoxContainer = $Content
@onready var title: Label = $Content/Title
@onready var subtitle: Label = $Content/Subtitle
@onready var start_btn: Button = $Content/StartButton
@onready var sub_buttons: HBoxContainer = $Content/SubButtons
@onready var load_btn: Button = $Content/SubButtons/LoadButton
@onready var settings_btn: Button = $Content/SubButtons/SettingsButton
@onready var top_line: ColorRect = $Content/TopLine
@onready var divider: HSeparator = $Content/Divider
@onready var bottom_line: ColorRect = $BottomLine
@onready var version_label: Label = $VersionLabel

var _pulse_tween: Tween
var _ghost_timer: Timer

# Atmospheric lines from the story
const GHOST_LINES: Array[String] = [
	"月光落在水面上的样子，无论看多少次，都觉得很好看。",
	"只是……睡不着而已。",
	"你有没有想过，如果一个人能活很久很久……会是什么感觉？",
	"它存在过，又消散了。然后我再创造一个新的。如此反复。",
	"它变成了……一种背景音。像远处的溪流声一样，永远在那里。",
	"只有树、溪流，和偶尔路过的人类旅人。",
	"然后第二天，他们就走了。而我……还留在原地。",
	"也许吧。但当你已经习惯了那种寂静，它就不再是一种痛苦了。",
	"我曾经在哥伦比亚的森林里住过很长一段时间。",
	"既然来了，陪我坐一会儿吧。",
	"又一个夜晚结束了。",
	"但今晚……有点不一样。",
	"谢谢你陪我。真的。",
	"月光渐渐褪去，黎明的光芒洒满了整个中庭。",
]

func _ready() -> void:
	# Button style — transparent text-only
	var sb := StyleBoxEmpty.new()
	start_btn.add_theme_stylebox_override("normal", sb)
	start_btn.add_theme_stylebox_override("hover", sb)
	start_btn.add_theme_stylebox_override("pressed", sb)
	start_btn.add_theme_stylebox_override("disabled", sb)
	for btn: Button in [load_btn, settings_btn]:
		btn.add_theme_stylebox_override("normal", sb)
		btn.add_theme_stylebox_override("hover", sb)
		btn.add_theme_stylebox_override("pressed", sb)
		btn.add_theme_stylebox_override("disabled", sb)
	start_btn.pressed.connect(_on_start_pressed)
	load_btn.pressed.connect(_on_load_pressed)
	settings_btn.pressed.connect(_on_settings_pressed)

	# Divider style — thin subtle line
	var sep := StyleBoxLine.new()
	sep.color = Color(0, 0, 0, 0.1)
	sep.thickness = 1
	divider.add_theme_stylebox_override("separator", sep)

	# Start invisible for entrance animation
	_hide_all()
	_setup_particles()
	_play_entrance()
	_start_ghost_text()

func _hide_all() -> void:
	for node: CanvasItem in [top_line, title, divider, subtitle, start_btn, sub_buttons, bottom_line, version_label]:
		node.modulate.a = 0.0
	content.position.y = 20.0

func _play_entrance() -> void:
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)

	tw.tween_property(bottom_line, "modulate:a", 1.0, 0.4).set_delay(0.2)
	tw.parallel().tween_property(version_label, "modulate:a", 1.0, 0.4)
	tw.parallel().tween_property(content, "position:y", 0.0, 0.6)
	tw.tween_property(top_line, "modulate:a", 1.0, 0.3)
	tw.tween_property(title, "modulate:a", 1.0, 0.5).set_delay(0.1)
	tw.tween_property(divider, "modulate:a", 1.0, 0.3).set_delay(0.15)
	tw.tween_property(subtitle, "modulate:a", 1.0, 0.4).set_delay(0.1)
	tw.tween_property(start_btn, "modulate:a", 1.0, 0.5).set_delay(0.3)
	tw.tween_property(sub_buttons, "modulate:a", 1.0, 0.4).set_delay(0.15)
	tw.tween_callback(_start_pulse)

func _start_pulse() -> void:
	_pulse_tween = create_tween()
	_pulse_tween.set_loops()
	_pulse_tween.set_ease(Tween.EASE_IN_OUT)
	_pulse_tween.set_trans(Tween.TRANS_SINE)
	_pulse_tween.tween_property(start_btn, "modulate:a", 0.4, 1.2)
	_pulse_tween.tween_property(start_btn, "modulate:a", 1.0, 1.2)

# ── Particles: subtle floating dust motes ──

func _setup_particles() -> void:
	var shader_code := """
shader_type canvas_item;

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void fragment() {
	vec2 uv = UV;
	vec3 col = vec3(1.0);

	for (int i = 0; i < 60; i++) {
		float fi = float(i);
		vec2 seed = vec2(fi * 3.71, fi * 7.13);
		float h0 = hash(seed);
		float h1 = hash(seed + vec2(1.0, 0.0));
		float h2 = hash(seed + vec2(0.0, 1.0));
		float h3 = hash(seed + vec2(1.0, 1.0));

		// Position: drifts upward, wraps
		float speed = 0.02 + h1 * 0.03;
		float y = mod(1.0 - TIME * speed + h0, 1.0);
		float x = h2 + sin(TIME * 0.3 + fi * 2.0) * 0.03;

		vec2 pos = vec2(x, y);
		vec2 diff = uv - pos;

		// Fix wrapping for x
		diff.x = diff.x - round(diff.x);

		float dist = length(diff * vec2(1.0, 1.78));
		float r = 0.002 + h3 * 0.004;
		float a = smoothstep(r, r * 0.3, dist);
		col -= a * (0.06 + h0 * 0.1);
	}

	COLOR = vec4(clamp(col, vec3(0.0), vec3(1.0)), 1.0);
}
"""
	var shader := Shader.new()
	shader.code = shader_code
	var mat := ShaderMaterial.new()
	mat.shader = shader
	$BG.material = mat

# ── Ghost text: floating dialogue lines in the background ──

func _start_ghost_text() -> void:
	_ghost_timer = Timer.new()
	_ghost_timer.wait_time = 3.0
	_ghost_timer.one_shot = false
	_ghost_timer.autostart = true
	_ghost_timer.timeout.connect(_spawn_ghost)
	add_child(_ghost_timer)
	# Spawn one immediately after a short delay
	get_tree().create_timer(2.5).timeout.connect(_spawn_ghost)

func _spawn_ghost() -> void:
	var text := GHOST_LINES[randi() % GHOST_LINES.size()]

	var lbl := Label.new()
	lbl.text = text
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.add_theme_font_size_override("font_size", randi_range(12, 15))
	lbl.add_theme_color_override("font_color", Color(0, 0, 0, 1))
	lbl.modulate.a = 0.0

	# Random position — spread across the screen
	var vp := get_viewport_rect().size
	var x := randf_range(vp.x * 0.1, vp.x * 0.9)
	var y := randf_range(vp.y * 0.15, vp.y * 0.85)
	lbl.position = Vector2(x, y)

	# Slight random rotation for organic feel
	lbl.rotation = randf_range(-0.06, 0.06)

	# Set max width so text wraps
	lbl.autowrap_mode = TextServer.AUTOWRAP_WORD
	lbl.custom_minimum_size = Vector2(280, 0)
	lbl.size = Vector2(280, 0)

	add_child(lbl)

	# Animation: fade in → hold → fade out → free
	var duration := randf_range(6.0, 10.0)
	var fade_in := 1.5
	var fade_out := 2.0
	var hold := duration - fade_in - fade_out

	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_SINE)

	# Fade in
	tw.tween_property(lbl, "modulate:a", randf_range(0.12, 0.22), fade_in)
	# Drift upward gently
	tw.parallel().tween_property(lbl, "position:y", y - randf_range(15.0, 40.0), duration)
	# Hold
	tw.tween_interval(hold)
	# Fade out
	tw.tween_property(lbl, "modulate:a", 0.0, fade_out).set_ease(Tween.EASE_IN)
	tw.tween_callback(lbl.queue_free)

func _on_load_pressed() -> void:
	GameManager.toggle_save_load_menu(false, true)

func _on_settings_pressed() -> void:
	GameManager.toggle_settings()

func _on_start_pressed() -> void:
	if _pulse_tween:
		_pulse_tween.kill()
	if _ghost_timer:
		_ghost_timer.stop()

	# Fade out all ghost texts
	for child in get_children():
		if child is Label and child != title and child != subtitle and child != version_label:
			var tw := create_tween()
			tw.tween_property(child, "modulate:a", 0.0, 0.4).set_ease(Tween.EASE_IN)
			tw.tween_callback(child.queue_free)

	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(content, "modulate:a", 0.0, 0.3)
	tw.parallel().tween_property(content, "position:y", -15.0, 0.3)
	tw.tween_property(bottom_line, "modulate:a", 0.0, 0.2)
	tw.parallel().tween_property(version_label, "modulate:a", 0.0, 0.2)
	tw.tween_callback(func() -> void: get_tree().change_scene_to_file("res://RecordSelect.tscn"))
