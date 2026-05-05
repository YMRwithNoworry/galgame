extends Node

# ── Script Data ──────────────────────────────────────────────────────────────
var script_data: Array[Dictionary] = [
	# ═══════════════════════════════════════════════════════════════
	#  第一幕：月下初遇
	# ═══════════════════════════════════════════════════════════════
	{
		"type": "dialogue", "speaker": "", "text": "莱茵生命总部，深夜。走廊的灯光早已熄灭，只有月光透过落地窗洒进来。",
		"bg": "res://bg_rhine_night.png",
		"bgm": {"action": "play", "file": "res://audio/bgm_mystery.ogg", "fade_duration": 2.0},
	},
	{
		"type": "dialogue", "speaker": "", "text": "你因为一份遗落的文件折返，却在中庭的水池边，看到了一个意想不到的身影。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "……嗯？这么晚了，还有人在这里吗？",
		"characters": [
			{ "name": "缪尔赛斯", "expression": "gentle", "position": "center", "action": "show" }
		],
		"unlock_cg": "moonlit_fountain"
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "[float speed=1.2 amplitude=4]不必紧张。我只是……睡不着而已。[/float]",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "月光落在水面上的样子，无论看多少次，都觉得很好看。",
		"sfx": {"file": "res://audio/sfx_water.ogg"}
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "你也是出来散步的？还是……在加班？",
	},
	# ── 选项 1 ──
	{
		"type": "choice",
		"choices": [
			{ "text": "文件忘在办公室了", "next": "ch1_honest" },
			{ "text": "看到你一个人在这里，有些在意", "next": "ch1_concern" },
		]
	},
	# ── 诚实路线 ──
	{ "type": "label", "id": "ch1_honest" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "原来如此。工作认真是好事，不过也别太勉强自己。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "我见过太多人，把有限的生命都耗费在了无尽的加班里。",
	},
	{ "type": "jump", "target": "ch1_merge" },
	# ── 关心路线 ──
	{ "type": "label", "id": "ch1_concern" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "……在意？",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "呵呵，你真是个温柔的人呢。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "不过不用担心，这只是……一个老习惯罢了。独自看月亮的老习惯。",
	},
	# ── 汇合 ──
	{ "type": "label", "id": "ch1_merge" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "既然来了，陪我坐一会儿吧。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "水面上……你看到了吗？",
	},
	{
		"type": "dialogue", "speaker": "", "text": "她轻轻抬起手，指尖触碰水面。涟漪荡开，水面上竟缓缓浮现出一个由水构成的小小人形——透明的、发着微光的水元素生命。",
		"sfx": {"file": "res://audio/sfx_sparkle.ogg"},
		"unlock_cg": "water_elemental"
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "这是我的……怎么说呢，算是朋友吧。虽然它可能并不理解'朋友'这个概念。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "[float speed=1.0 amplitude=3]它存在过，又消散了。然后我再创造一个新的。如此反复。[/float]",
	},
	# ═══════════════════════════════════════════════════════════════
	#  第二幕：漫长的记忆
	# ═══════════════════════════════════════════════════════════════
	{ "type": "label", "id": "ch2_start" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "你有没有想过，如果一个人能活很久很久……会是什么感觉？",
		"bgm": {"action": "fadeout", "fade_duration": 1.0},
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "不是几十年，而是几百年。看着身边的人一个接一个老去、离开。",
		"bgm": {"action": "play", "file": "res://audio/bgm_piano.ogg", "fade_duration": 2.0},
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "我曾经在哥伦比亚的森林里住过很长一段时间。那时候还没有莱茵生命，没有罗德岛，什么都没有。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "只有树、溪流，和偶尔路过的人类旅人。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "我会用水元素跟他们打招呼。他们觉得很神奇，会停下来聊聊天。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "然后第二天，他们就走了。而我……还留在原地。",
	},
	# ── 选项 2 ──
	{
		"type": "choice",
		"choices": [
			{ "text": "那一定很孤独吧", "next": "ch2_lonely" },
			{ "text": "但你遇到了凯尔希，不是吗", "next": "ch2_kaltsit" },
		]
	},
	# ── 孤独路线 ──
	{ "type": "label", "id": "ch2_lonely" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "孤独？",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "也许吧。但当你已经习惯了那种寂静，它就不再是一种痛苦了。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "它变成了……一种背景音。像远处的溪流声一样，永远在那里。",
	},
	{ "type": "jump", "target": "ch2_merge" },
	# ── 凯尔希路线 ──
	{ "type": "label", "id": "ch2_kaltsit" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "……你知道凯尔希？",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "是啊，我遇到了她。那大概是……很久很久以前的事了。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "她是少数几个，能让我觉得'时间过得真快'的人。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "明明是我活得更久，却总觉得她在某些方面……比我更懂得什么是'活着'。",
	},
	# ── 汇合 ──
	{ "type": "label", "id": "ch2_merge" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "不过话说回来——",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "今晚和你聊天，让我想起了很久以前的感觉。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "那种……有人愿意听我说话的感觉。[tremble rate=15 level=1]真好。[/tremble]",
	},
	# ═══════════════════════════════════════════════════════════════
	#  第三幕：黎明将至
	# ═══════════════════════════════════════════════════════════════
	{ "type": "label", "id": "ch3_start" },
	{
		"type": "dialogue", "speaker": "", "text": "不知不觉，东方的天际已经泛起了微光。",
		"bg": "res://bg_rhine_dawn.png",
		"bgm": {"action": "fadeout", "fade_duration": 1.5},
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "啊……天快亮了。",
		"bgm": {"action": "play", "file": "res://audio/bgm_gentle.ogg", "fade_duration": 2.0},
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "每次黎明到来的时候，我都会想——又一个夜晚结束了。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "但今晚……有点不一样。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "谢谢你陪我。真的。",
	},
	# ── 最终选项 ──
	{
		"type": "choice",
		"choices": [
			{ "text": "以后睡不着的时候，随时可以找我", "next": "ending_warm" },
			{ "text": "晚安，缪尔赛斯", "next": "ending_gentle" },
		]
	},
	# ── 温暖结局 ──
	{ "type": "label", "id": "ending_warm" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "……随时？",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "你知道吗，对于一个活了很久的精灵来说，'随时'这个词……是很重的承诺。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "不过——",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "如果是你的话，我愿意相信。",
		"unlock_cg": "muelsyse_smile"
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "[float speed=1.5 amplitude=5]那么，约好了哦。[/float]",
	},
	{ "type": "jump", "target": "ending" },
	# ── 温柔结局 ──
	{ "type": "label", "id": "ending_gentle" },
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "晚安。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "……你知道吗，已经很久很久没有人对我说过'晚安'了。",
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "对于活了太久的人来说，这样简单的一句话……反而最珍贵。",
		"unlock_cg": "muelsyse_dawn"
	},
	{
		"type": "dialogue", "speaker": "缪尔赛斯", "text": "[float speed=1.0 amplitude=3]晚安。做个好梦。[/float]",
	},
	# ── 结束 ──
	{ "type": "label", "id": "ending" },
	{
		"type": "dialogue", "speaker": "", "text": "她转身离去，水元素在她脚边轻轻环绕，像是在道别。",
	},
	{
		"type": "dialogue", "speaker": "", "text": "月光渐渐褪去，黎明的光芒洒满了整个中庭。",
	},
	{
		"type": "dialogue", "speaker": "", "text": "你知道，这个夜晚会成为一段难以忘怀的记忆。",
		"bgm": {"action": "fadeout", "fade_duration": 3.0}
	},
	{
		"type": "dialogue", "speaker": "", "text": "——「月下水语」 完——",
	},
]

# ── State ────────────────────────────────────────────────────────────────────
var current_index: int = 0
var is_typing: bool = false
var _typing_cancelled: bool = false
var _is_transitioning: bool = false
var _current_bg_path: String = ""

# ── Game Variables (for save/load) ───────────────────────────────────────────
var game_vars: Dictionary = {}

# ── History Log ──────────────────────────────────────────────────────────────
var history_log: Array[Dictionary] = []

# ── CG Gallery ───────────────────────────────────────────────────────────────
var unlocked_cgs: Array[String] = []
const CG_DATA_PATH: String = "user://cg_data.cfg"
const CG_FULL_DIR: String = "res://cgs/full_"
const CG_THUMB_DIR: String = "res://cgs/thumb_"
const ALL_CGS: Array[String] = [
	"moonlit_fountain",
	"water_elemental",
	"muelsyse_smile",
	"muelsyse_dawn",
]

# ── Node References ──────────────────────────────────────────────────────────
var speaker_name_label: Label
var dialog_text: RichTextLabel
var next_button: Button
var choice_container: VBoxContainer
var bg_rect: TextureRect
var bg_fade_overlay: ColorRect
var character_layer: Control
var system_menu_button: Button
var backlog_button: Button
var settings_button: Button
var cg_gallery_button: Button

# ── Audio ────────────────────────────────────────────────────────────────────
var _bgm_player: AudioStreamPlayer
var _sfx_player: AudioStreamPlayer
var _current_bgm_path: String = ""
var _bgm_fade_tween: Tween = null

# ── Character Tracking ───────────────────────────────────────────────────────
var _characters: Dictionary = {} # char_name -> TextureRect

# ── Menu ─────────────────────────────────────────────────────────────────────
var _save_load_menu: Control = null
var _backlog_panel: Control = null
var _settings_menu: Control = null
var _cg_gallery: Control = null

# ── Settings ─────────────────────────────────────────────────────────────────
var text_speed: float = 0.03
var auto_mode: bool = false
var auto_delay: float = 2.0
var skip_read: bool = false

const SETTINGS_PATH: String = "user://settings.cfg"
const SETTINGS_DEFAULTS: Dictionary = {
	"master_volume": 1.0,
	"bgm_volume": 1.0,
	"sfx_volume": 1.0,
	"text_speed": 0.03,
	"auto_mode": false,
	"auto_delay": 2.0,
	"skip_read": false,
}

# ── Constants ────────────────────────────────────────────────────────────────
const BG_FADE_DURATION: float = 0.25      # each half of the BG transition
const CHAR_FADE_DURATION: float = 0.3
const SPRITE_WIDTH: float = 400.0
const SPRITE_HEIGHT: float = 600.0
const SPRITE_DIR: String = "res://sprites/"

# Placeholder colors keyed by filename for backgrounds
const BG_PLACEHOLDER_COLORS: Dictionary = {
	"bg_school.png": Color(0.4, 0.6, 0.8),
	"bg_room.png":   Color(0.5, 0.4, 0.3),
}
const DEFAULT_BG_COLOR: Color = Color(0.15, 0.15, 0.2)
const DEFAULT_CHAR_COLOR: Color = Color(0.7, 0.85, 1.0)

# ═════════════════════════════════════════════════════════════════════════════
#  Lifecycle
# ═════════════════════════════════════════════════════════════════════════════
var _main_initialized: bool = false

func _ready() -> void:
	load_settings()
	_load_cg_data()
	get_tree().node_added.connect(_on_node_added)
	call_deferred("_init_references")

func _on_node_added(node: Node) -> void:
	if node.name == "DialogPanel" and not _main_initialized:
		call_deferred("_init_references")

func _init_references() -> void:
	var main = get_tree().current_scene
	if not main.has_node("DialogPanel"):
		return # Title screen — defer until Main.tscn loads
	_do_init(main)

func _do_init(main: Node) -> void:
	if _main_initialized:
		return
	_main_initialized = true
	speaker_name_label = main.get_node("DialogPanel/MarginContainer/VBoxContainer/SpeakerName")
	dialog_text        = main.get_node("DialogPanel/MarginContainer/VBoxContainer/DialogText")

	# Install custom BBCode text effects
	dialog_text.install_effect(ShakeEffect.new())
	dialog_text.install_effect(TrembleEffect.new())
	dialog_text.install_effect(FloatEffect.new())
	next_button        = main.get_node("DialogPanel/MarginContainer/VBoxContainer/NextButton")
	choice_container   = main.get_node("ChoiceContainer")
	bg_rect            = main.get_node("BG")
	bg_fade_overlay    = main.get_node("BGFadeOverlay")
	character_layer    = main.get_node("CharacterLayer")

	next_button.pressed.connect(_on_next_pressed)
	choice_container.visible = false
	bg_fade_overlay.color = Color(0, 0, 0, 0)

	# ── Apply warm-canvas design theme ──
	VNTheme.apply_main_scene(main)

	system_menu_button = main.get_node("SystemMenuButton")
	system_menu_button.pressed.connect(toggle_save_load_menu)

	backlog_button = main.get_node("BacklogButton")
	backlog_button.pressed.connect(toggle_backlog)

	settings_button = main.get_node("SettingsButton")
	settings_button.pressed.connect(toggle_settings)

	cg_gallery_button = main.get_node("CGGalleryButton")
	cg_gallery_button.pressed.connect(toggle_cg_gallery)

	# ── Audio players (created dynamically) ──
	_bgm_player = AudioStreamPlayer.new()
	_bgm_player.name = "BGMPlayer"
	_bgm_player.bus = "BGM"
	_bgm_player.volume_db = 0.0
	add_child(_bgm_player)

	_sfx_player = AudioStreamPlayer.new()
	_sfx_player.name = "SFXPlayer"
	_sfx_player.bus = "SFX"
	_sfx_player.volume_db = 0.0
	add_child(_sfx_player)

	show_dialogue()

# ═════════════════════════════════════════════════════════════════════════════
#  Input & Hotkeys
# ═════════════════════════════════════════════════════════════════════════════
func _input(event: InputEvent) -> void:
	# ── Hotkeys ──
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_F5:
				quick_save()
				return
			KEY_F9:
				quick_load()
				return
			KEY_ESCAPE:
				toggle_save_load_menu()
				return
			KEY_H:
				toggle_backlog()
				return

	if _is_transitioning:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_typing:
			_typing_cancelled = true

# ═════════════════════════════════════════════════════════════════════════════
#  Save / Load Menu Toggle
# ═════════════════════════════════════════════════════════════════════════════
func toggle_save_load_menu(show_save: bool = true, show_load: bool = true) -> void:
	if _save_load_menu == null:
		var menu_scene: PackedScene = load("res://SaveLoadMenu.tscn")
		_save_load_menu = menu_scene.instantiate()
		get_tree().current_scene.add_child(_save_load_menu)
		_save_load_menu.visible = false
	_save_load_menu.set_save_load_mode(show_save, show_load)
	if _save_load_menu.visible:
		_save_load_menu.close_panel()
	else:
		_save_load_menu.open_panel()

# ═════════════════════════════════════════════════════════════════════════════
#  Backlog Panel Toggle
# ═════════════════════════════════════════════════════════════════════════════
func toggle_backlog() -> void:
	if _backlog_panel == null:
		var panel_scene: PackedScene = load("res://BacklogPanel.tscn")
		_backlog_panel = panel_scene.instantiate()
		get_tree().current_scene.add_child(_backlog_panel)
		_backlog_panel.visible = false
	if _backlog_panel.visible:
		_backlog_panel.close_panel()
	else:
		_backlog_panel.open_panel()
		_backlog_panel.update_panel()

# ═════════════════════════════════════════════════════════════════════════════
#  Settings Menu Toggle
# ═════════════════════════════════════════════════════════════════════════════
func toggle_settings() -> void:
	if _settings_menu == null:
		var menu_scene: PackedScene = load("res://SettingsMenu.tscn")
		_settings_menu = menu_scene.instantiate()
		get_tree().current_scene.add_child(_settings_menu)
		_settings_menu.visible = false
	if _settings_menu.visible:
		_settings_menu.close_panel()
	else:
		_settings_menu.open_panel()
		_settings_menu.refresh_ui()

# ═════════════════════════════════════════════════════════════════════════════
#  CG Gallery Toggle
# ═════════════════════════════════════════════════════════════════════════════
func toggle_cg_gallery() -> void:
	if _cg_gallery == null:
		var gallery_scene: PackedScene = load("res://CGallery.tscn")
		_cg_gallery = gallery_scene.instantiate()
		get_tree().current_scene.add_child(_cg_gallery)
		_cg_gallery.visible = false
	if _cg_gallery.visible:
		_cg_gallery.close_panel()
	else:
		_cg_gallery.open_panel()
		_cg_gallery.refresh_gallery()

# ═════════════════════════════════════════════════════════════════════════════
#  Background Management
# ═════════════════════════════════════════════════════════════════════════════
func change_bg(texture_path: String) -> void:
	if texture_path.is_empty():
		return
	_is_transitioning = true
	_current_bg_path = texture_path

	var tex: Texture2D = _load_texture(texture_path, true)

	# Fade overlay to black
	var tw := create_tween()
	tw.tween_property(bg_fade_overlay, "color:a", 1.0, BG_FADE_DURATION)
	await tw.finished

	bg_rect.texture = tex

	# Fade overlay back to transparent
	tw = create_tween()
	tw.tween_property(bg_fade_overlay, "color:a", 0.0, BG_FADE_DURATION)
	await tw.finished

	_is_transitioning = false

# ═════════════════════════════════════════════════════════════════════════════
#  Character Management
# ═════════════════════════════════════════════════════════════════════════════
func show_character(char_name: String, expression: String, pos: String) -> void:
	var tex_path := SPRITE_DIR + char_name + "_" + expression + ".png"
	var tex: Texture2D = _load_texture(tex_path, false, char_name)

	if _characters.has(char_name):
		# Already on screen — cross-fade to new texture
		await _crossfade_texture(_characters[char_name], tex)
	else:
		# New character — create node and fade in
		var rect := _make_character_rect(char_name, tex, pos)
		character_layer.add_child(rect)
		_characters[char_name] = rect
		rect.modulate = Color(1, 1, 1, 0)
		var tw := create_tween()
		tw.tween_property(rect, "modulate:a", 1.0, CHAR_FADE_DURATION)
		await tw.finished

func hide_character(char_name: String) -> void:
	if not _characters.has(char_name):
		return
	var rect: TextureRect = _characters[char_name]
	_characters.erase(char_name)

	var tw := create_tween()
	tw.tween_property(rect, "modulate:a", 0.0, CHAR_FADE_DURATION)
	await tw.finished
	rect.queue_free()

## Immediately set up a character node without animation (used while screen is black).
func _place_character_immediate(char_name: String, expression: String, pos: String) -> void:
	var tex_path := SPRITE_DIR + char_name + "_" + expression + ".png"
	var tex: Texture2D = _load_texture(tex_path, false, char_name)

	if _characters.has(char_name):
		_characters[char_name].texture = tex
	else:
		var rect := _make_character_rect(char_name, tex, pos)
		character_layer.add_child(rect)
		_characters[char_name] = rect

## Immediately remove a character node without animation (used while screen is black).
func _remove_character_immediate(char_name: String) -> void:
	if not _characters.has(char_name):
		return
	_characters[char_name].queue_free()
	_characters.erase(char_name)

func _crossfade_texture(rect: TextureRect, new_tex: Texture2D) -> void:
	var tw := create_tween()
	tw.tween_property(rect, "modulate:a", 0.0, CHAR_FADE_DURATION * 0.5)
	await tw.finished

	rect.texture = new_tex

	tw = create_tween()
	tw.tween_property(rect, "modulate:a", 1.0, CHAR_FADE_DURATION * 0.5)
	await tw.finished

# ═════════════════════════════════════════════════════════════════════════════
#  Audio Management
# ═════════════════════════════════════════════════════════════════════════════
func _handle_bgm(data: Dictionary) -> void:
	var action: String = data.get("action", "play")
	var fade_dur: float = data.get("fade_duration", 0.0)

	match action:
		"play":
			var file_path: String = data.get("file", "")
			if file_path.is_empty():
				return
			# Skip if same track is already playing
			if file_path == _current_bgm_path and _bgm_player.playing:
				return
			if not ResourceLoader.exists(file_path):
				push_warning("BGM 资源未找到: %s" % file_path)
				return
			# Kill any running fade tween
			if _bgm_fade_tween != null and _bgm_fade_tween.is_valid():
				_bgm_fade_tween.kill()
			_current_bgm_path = file_path
			_bgm_player.stream = load(file_path) as AudioStream
			if _bgm_player.stream != null:
				_bgm_player.stream.loop = true
			_bgm_player.volume_db = -80.0 if fade_dur > 0.0 else 0.0
			_bgm_player.play()
			if fade_dur > 0.0:
				_bgm_fade_tween = create_tween()
				_bgm_fade_tween.tween_property(_bgm_player, "volume_db", 0.0, fade_dur)
		"stop":
			_bgm_player.stop()
			_current_bgm_path = ""
		"fadeout":
			if not _bgm_player.playing:
				return
			if fade_dur <= 0.0:
				fade_dur = 1.0
			if _bgm_fade_tween != null and _bgm_fade_tween.is_valid():
				_bgm_fade_tween.kill()
			_bgm_fade_tween = create_tween()
			_bgm_fade_tween.tween_property(_bgm_player, "volume_db", -80.0, fade_dur)
			await _bgm_fade_tween.finished
			_bgm_player.stop()
			_current_bgm_path = ""

func _handle_sfx(data: Dictionary) -> void:
	var file_path: String = data.get("file", "")
	if file_path.is_empty():
		return
	if not ResourceLoader.exists(file_path):
		push_warning("SFX 资源未找到: %s" % file_path)
		return
	_sfx_player.stream = load(file_path) as AudioStream
	_sfx_player.volume_db = 0.0
	_sfx_player.play()

func _make_character_rect(char_name: String, tex: Texture2D, pos: String) -> TextureRect:
	var rect := TextureRect.new()
	rect.name = char_name
	rect.texture = tex
	rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	rect.size = Vector2(SPRITE_WIDTH, SPRITE_HEIGHT)
	rect.anchor_left = 0.0
	rect.anchor_top = 0.0
	rect.anchor_right = 0.0
	rect.anchor_bottom = 0.0

	var vp_w := get_viewport().get_visible_rect().size.x
	var vp_h := get_viewport().get_visible_rect().size.y
	var x: float
	match pos:
		"left":
			x = vp_w * 0.2 - SPRITE_WIDTH * 0.5
		"right":
			x = vp_w * 0.8 - SPRITE_WIDTH * 0.5
		_:  # center
			x = vp_w * 0.5 - SPRITE_WIDTH * 0.5
	rect.position = Vector2(x, vp_h - SPRITE_HEIGHT)
	return rect

# ═════════════════════════════════════════════════════════════════════════════
#  Texture Loading (with placeholder fallback)
# ═════════════════════════════════════════════════════════════════════════════
func _load_texture(path: String, is_bg: bool, fallback_key: String = "") -> Texture2D:
	if ResourceLoader.exists(path):
		return load(path) as Texture2D

	var color: Color
	if is_bg:
		color = BG_PLACEHOLDER_COLORS.get(path.get_file(), DEFAULT_BG_COLOR)
	else:
		color = DEFAULT_CHAR_COLOR

	push_warning("资源未找到: %s — 使用纯色占位" % path)
	return _make_placeholder_tex(color, is_bg)

func _make_placeholder_tex(color: Color, is_bg: bool) -> ImageTexture:
	var w := 1920 if is_bg else int(SPRITE_WIDTH)
	var h := 1080 if is_bg else int(SPRITE_HEIGHT)
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	img.fill(color)
	return ImageTexture.create_from_image(img)

# ═════════════════════════════════════════════════════════════════════════════
#  Label / Jump
# ═════════════════════════════════════════════════════════════════════════════
## Find a label entry by id and set current_index to it.
## The next call to advance_script() will increment past the label entry.
func jump_to_label(label_id: String) -> void:
	for i in script_data.size():
		var entry: Dictionary = script_data[i]
		if entry["type"] == "label" and entry["id"] == label_id:
			current_index = i
			return
	push_error("标签未找到: %s" % label_id)

# ═════════════════════════════════════════════════════════════════════════════
#  Script Execution
# ═════════════════════════════════════════════════════════════════════════════
## Unified advance: move to the next entry and process it.
func advance_script() -> void:
	current_index += 1
	show_dialogue()

func show_dialogue() -> void:
	show_dialogue_internal(false)

func show_dialogue_internal(force_instant: bool = false) -> void:
	if current_index >= script_data.size():
		_end_script()
		return

	var entry: Dictionary = script_data[current_index]

	# ── Handle entry types ──
	match entry["type"]:
		"label":
			advance_script()
			return
		"jump":
			jump_to_label(entry["target"])
			advance_script()
			return
		"choice":
			_show_choices(entry["choices"])
			return
		"dialogue":
			pass # handled below
		_:
			advance_script()
			return

	# ── Dialogue entry ──
	next_button.visible = false
	choice_container.visible = false

	var needs_bg: bool = entry.has("bg") and not entry["bg"].is_empty()
	var has_chars: bool = entry.has("characters") and entry["characters"].size() > 0

	if needs_bg:
		_is_transitioning = true
		_current_bg_path = entry["bg"]
		var tex: Texture2D = _load_texture(entry["bg"], true)

		var tw := create_tween()
		tw.tween_property(bg_fade_overlay, "color:a", 1.0, BG_FADE_DURATION)
		await tw.finished

		bg_rect.texture = tex

		if has_chars:
			for action: Dictionary in entry["characters"]:
				match action["action"]:
					"show":
						_place_character_immediate(action["name"], action["expression"], action["position"])
					"hide":
						_remove_character_immediate(action["name"])

		tw = create_tween()
		tw.tween_property(bg_fade_overlay, "color:a", 0.0, BG_FADE_DURATION)
		await tw.finished
		_is_transitioning = false

	elif has_chars:
		for action: Dictionary in entry["characters"]:
			match action["action"]:
				"show":
					await show_character(action["name"], action["expression"], action["position"])
				"hide":
					await hide_character(action["name"])

	# ── Audio instructions ──
	if entry.has("bgm"):
		_handle_bgm(entry["bgm"])
	if entry.has("sfx"):
		_handle_sfx(entry["sfx"])

	# ── CG unlock ──
	if entry.has("unlock_cg"):
		unlock_cg(entry["unlock_cg"])

	# Show dialogue text
	speaker_name_label.text = entry["speaker"]
	dialog_text.text = ""
	dialog_text.visible_characters = -1

	if force_instant:
		dialog_text.text = entry["text"]
		dialog_text.visible_characters = -1
		is_typing = false
		next_button.visible = true
		_log_history(entry["speaker"], entry["text"])
	else:
		_start_typewriter(entry["speaker"], entry["text"])

# ═════════════════════════════════════════════════════════════════════════════
#  Choice Handling
# ═════════════════════════════════════════════════════════════════════════════
func _show_choices(choices: Array) -> void:
	for child in choice_container.get_children():
		child.queue_free()

	speaker_name_label.text = ""
	dialog_text.text = "（请做出选择）"
	dialog_text.visible_characters = -1
	is_typing = false
	next_button.visible = false

	for choice: Dictionary in choices:
		var btn := Button.new()
		btn.text = choice["text"]
		btn.pressed.connect(_on_choice_selected.bind(choice["next"], btn))
		VNTheme.style_choice_button(btn)
		choice_container.add_child(btn)

	choice_container.visible = true

func _on_choice_selected(next_label: String, _pressed_btn: Button) -> void:
	for child in choice_container.get_children():
		if child is Button:
			child.disabled = true

	choice_container.visible = false

	jump_to_label(next_label)
	advance_script()

# ═════════════════════════════════════════════════════════════════════════════
#  Typewriter
# ═════════════════════════════════════════════════════════════════════════════
func _start_typewriter(speaker: String, full_text: String) -> void:
	is_typing = true
	_typing_cancelled = false

	# Set full BBCode text once, reveal gradually via visible_characters
	dialog_text.text = full_text
	var tag_regex := RegEx.new()
	tag_regex.compile("\\[/?\\w[^\\]]*\\]")
	var visible_len: int = tag_regex.sub(full_text, "", true).length()
	dialog_text.visible_characters = 0

	for i in visible_len:
		if _typing_cancelled:
			dialog_text.visible_characters = -1
			break
		dialog_text.visible_characters += 1
		await get_tree().create_timer(text_speed).timeout

	is_typing = false
	next_button.visible = true
	_log_history(speaker, full_text)

	if auto_mode:
		next_button.visible = false
		await get_tree().create_timer(auto_delay).timeout
		if not is_typing: # still valid (not overridden by new dialogue)
			advance_script()

func _log_history(speaker: String, text: String) -> void:
	history_log.append({"speaker": speaker, "text": text})

func _on_next_pressed() -> void:
	advance_script()

func _end_script() -> void:
	speaker_name_label.text = ""
	dialog_text.text = "[center]—— 剧本结束 ——[/center]"
	dialog_text.visible_characters = -1
	next_button.visible = false
	choice_container.visible = false
	print("剧本结束")

# ═════════════════════════════════════════════════════════════════════════════
#  Save / Load
# ═════════════════════════════════════════════════════════════════════════════
func _build_save_data() -> Dictionary:
	# Collect character state
	var char_list: Array[Dictionary] = []
	for char_name: String in _characters:
		var rect: TextureRect = _characters[char_name]
		var tex_path: String = ""
		if rect.texture is AtlasTexture:
			tex_path = rect.texture.atlas.resource_path
		elif rect.texture != null:
			tex_path = rect.texture.resource_path
		# Derive expression from texture path: "res://sprites/少女_smile.png" -> "smile"
		var expression: String = ""
		var pos: String = "center"
		var base_name: String = tex_path.get_file().get_basename() # "少女_smile"
		var parts: PackedStringArray = base_name.split("_")
		if parts.size() >= 2:
			expression = parts[1]
		# Determine position from x coordinate
		var vp_w := get_viewport().get_visible_rect().size.x
		var center_x := vp_w * 0.5
		var left_x := vp_w * 0.2
		var right_x := vp_w * 0.8
		var sprite_center_x: float = rect.position.x + SPRITE_WIDTH * 0.5
		if absf(sprite_center_x - left_x) < 50.0:
			pos = "left"
		elif absf(sprite_center_x - right_x) < 50.0:
			pos = "right"
		else:
			pos = "center"
		char_list.append({
			"name": char_name,
			"expression": expression,
			"position": pos,
			"alpha": rect.modulate.a,
		})

	# Find dialog summary
	var summary: String = ""
	if current_index < script_data.size():
		var entry: Dictionary = script_data[current_index]
		if entry["type"] == "dialogue":
			summary = entry.get("speaker", "") + "：" + entry.get("text", "")
		elif entry["type"] == "choice":
			summary = "（选择分支）"

	return {
		"current_index": current_index,
		"bg_path": _current_bg_path,
		"characters": char_list,
		"game_vars": game_vars.duplicate(),
		"history_log": history_log.duplicate(),
		"bgm_path": _current_bgm_path,
		"unlocked_cgs": unlocked_cgs.duplicate(),
		"timestamp": Time.get_datetime_string_from_system(),
		"summary": summary,
	}

func save(slot_id: int) -> void:
	var data: Dictionary = _build_save_data()
	var json_str: String = JSON.stringify(data, "\t")
	var path := "user://save_%d.json" % slot_id
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("存档失败: %s (错误: %s)" % [path, error_string(FileAccess.get_open_error())])
		return
	file.store_string(json_str)
	file.close()

	# Save thumbnail
	var img: Image = get_viewport().get_texture().get_image()
	var thumb_path := "user://save_%d.png" % slot_id
	img.save_png(thumb_path)
	print("已存档到槽位 %d" % slot_id)

func load_slot(slot_id: int) -> void:
	var path := "user://save_%d.json" % slot_id
	if not FileAccess.file_exists(path):
		push_error("存档文件不存在: %s" % path)
		return

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("读档失败: %s" % path)
		return
	var json_str := file.get_as_text()
	file.close()

	var parsed: Variant = JSON.parse_string(json_str)
	if parsed == null:
		push_error("存档数据解析失败: %s" % path)
		return
	var data: Dictionary = parsed as Dictionary

	# Restore game vars
	game_vars = data.get("game_vars", {})

	# Restore unlocked CGs (merge save data with persistent CG data)
	var save_cgs: Array = data.get("unlocked_cgs", [])
	for cg_id: String in save_cgs:
		if not unlocked_cgs.has(cg_id):
			unlocked_cgs.append(cg_id)
	_save_cg_data()

	# Restore history log
	history_log.clear()
	var raw_log: Array = data.get("history_log", [])
	for entry: Dictionary in raw_log:
		history_log.append(entry)

	# Restore background
	_current_bg_path = data.get("bg_path", "")
	bg_fade_overlay.color = Color(0, 0, 0, 0)
	if not _current_bg_path.is_empty():
		bg_rect.texture = _load_texture(_current_bg_path, true)
	else:
		bg_rect.texture = null

	# Restore characters
	for child: Node in character_layer.get_children():
		child.queue_free()
	_characters.clear()

	var char_list: Array = data.get("characters", [])
	for char_data: Dictionary in char_list:
		var cname: String = char_data["name"]
		var expr: String = char_data["expression"]
		var pos: String = char_data["position"]
		var alpha: float = char_data.get("alpha", 1.0)
		var tex_path := SPRITE_DIR + cname + "_" + expr + ".png"
		var tex: Texture2D = _load_texture(tex_path, false, cname)
		var rect := _make_character_rect(cname, tex, pos)
		rect.modulate = Color(1, 1, 1, alpha)
		character_layer.add_child(rect)
		_characters[cname] = rect

	# Restore BGM
	var saved_bgm: String = data.get("bgm_path", "")
	if not saved_bgm.is_empty() and ResourceLoader.exists(saved_bgm):
		_current_bgm_path = saved_bgm
		_bgm_player.stream = load(saved_bgm) as AudioStream
		if _bgm_player.stream != null:
			_bgm_player.stream.loop = true
		_bgm_player.volume_db = 0.0
		_bgm_player.play()
	else:
		_bgm_player.stop()
		_current_bgm_path = ""

	# Restore script index and show dialogue (instant, no typewriter)
	current_index = data.get("current_index", 0)
	is_typing = false
	_typing_cancelled = false
	choice_container.visible = false
	show_dialogue_internal(true)
	print("已从槽位 %d 读档" % slot_id)

func quick_save() -> void:
	save(0)
	print("快速存档完成")

func quick_load() -> void:
	load_slot(0)
	print("快速读档完成")

func reset_game() -> void:
	current_index = 0
	is_typing = false
	_typing_cancelled = false
	_is_transitioning = false
	_current_bg_path = ""
	game_vars.clear()
	history_log.clear()
	_characters.clear()
	_main_initialized = false

func start_from_label(label_id: String) -> void:
	reset_game()
	for i in script_data.size():
		var entry: Dictionary = script_data[i]
		if entry.get("type") == "label" and entry.get("id", "") == label_id:
			current_index = i
			return

## Returns save info dict for a slot, or null if empty.
func get_slot_info(slot_id: int) -> Dictionary:
	var path := "user://save_%d.json" % slot_id
	if not FileAccess.file_exists(path):
		return {}
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {}
	var json_str := file.get_as_text()
	file.close()
	var parsed: Variant = JSON.parse_string(json_str)
	if parsed == null:
		return {}
	return parsed as Dictionary

## Returns true if a thumbnail exists for the slot.
func has_thumbnail(slot_id: int) -> bool:
	return FileAccess.file_exists("user://save_%d.png" % slot_id)

## Loads and returns the thumbnail texture for a slot, or null.
func get_thumbnail(slot_id: int) -> Texture2D:
	var path := "user://save_%d.png" % slot_id
	if not FileAccess.file_exists(path):
		return null
	var img: Image = Image.load_from_file(path)
	if img == null:
		return null
	return ImageTexture.create_from_image(img)

# ═════════════════════════════════════════════════════════════════════════════
#  Settings Load / Save
# ═════════════════════════════════════════════════════════════════════════════
func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SETTINGS_PATH) != OK:
		return # no file yet, keep defaults

	text_speed = cfg.get_value("game", "text_speed", SETTINGS_DEFAULTS["text_speed"])
	auto_mode  = cfg.get_value("game", "auto_mode",  SETTINGS_DEFAULTS["auto_mode"])
	auto_delay = cfg.get_value("game", "auto_delay", SETTINGS_DEFAULTS["auto_delay"])
	skip_read  = cfg.get_value("game", "skip_read",  SETTINGS_DEFAULTS["skip_read"])

	_apply_bus_volume("Master", cfg.get_value("audio", "master_volume", SETTINGS_DEFAULTS["master_volume"]))
	_apply_bus_volume("BGM",    cfg.get_value("audio", "bgm_volume",    SETTINGS_DEFAULTS["bgm_volume"]))
	_apply_bus_volume("SFX",    cfg.get_value("audio", "sfx_volume",    SETTINGS_DEFAULTS["sfx_volume"]))

func save_settings() -> void:
	var cfg := ConfigFile.new()

	# Only save values that differ from defaults
	if not is_equal_approx(text_speed, SETTINGS_DEFAULTS["text_speed"]):
		cfg.set_value("game", "text_speed", text_speed)
	if auto_mode != SETTINGS_DEFAULTS["auto_mode"]:
		cfg.set_value("game", "auto_mode", auto_mode)
	if not is_equal_approx(auto_delay, SETTINGS_DEFAULTS["auto_delay"]):
		cfg.set_value("game", "auto_delay", auto_delay)
	if skip_read != SETTINGS_DEFAULTS["skip_read"]:
		cfg.set_value("game", "skip_read", skip_read)

	var master := _get_bus_linear("Master")
	if not is_equal_approx(master, SETTINGS_DEFAULTS["master_volume"]):
		cfg.set_value("audio", "master_volume", master)
	var bgm := _get_bus_linear("BGM")
	if not is_equal_approx(bgm, SETTINGS_DEFAULTS["bgm_volume"]):
		cfg.set_value("audio", "bgm_volume", bgm)
	var sfx := _get_bus_linear("SFX")
	if not is_equal_approx(sfx, SETTINGS_DEFAULTS["sfx_volume"]):
		cfg.set_value("audio", "sfx_volume", sfx)

	cfg.save(SETTINGS_PATH)

func _apply_bus_volume(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return
	AudioServer.set_bus_volume_db(idx, linear_to_db(clampf(linear, 0.0, 1.0)))

func _get_bus_linear(bus_name: String) -> float:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return 1.0
	return db_to_linear(AudioServer.get_bus_volume_db(idx))

# ═════════════════════════════════════════════════════════════════════════════
#  CG Gallery
# ═════════════════════════════════════════════════════════════════════════════
func unlock_cg(cg_id: String) -> void:
	if unlocked_cgs.has(cg_id):
		return
	unlocked_cgs.append(cg_id)
	_save_cg_data()

func is_cg_unlocked(cg_id: String) -> bool:
	return unlocked_cgs.has(cg_id)

func _load_cg_data() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(CG_DATA_PATH) != OK:
		return
	var saved: Array = cfg.get_value("gallery", "unlocked", [])
	for id: String in saved:
		if not unlocked_cgs.has(id):
			unlocked_cgs.append(id)

func _save_cg_data() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("gallery", "unlocked", unlocked_cgs)
	cfg.save(CG_DATA_PATH)

## Returns the full-size image path for a CG.
func get_cg_full_path(cg_id: String) -> String:
	return CG_FULL_DIR + cg_id + ".png"

## Returns the thumbnail image path for a CG.
func get_cg_thumb_path(cg_id: String) -> String:
	return CG_THUMB_DIR + cg_id + ".png"

## Load CG texture with placeholder fallback.  is_thumb=true for thumbnail.
func load_cg_texture(cg_id: String, is_thumb: bool) -> Texture2D:
	var path: String
	if is_thumb:
		path = get_cg_thumb_path(cg_id)
	else:
		path = get_cg_full_path(cg_id)

	if ResourceLoader.exists(path):
		return load(path) as Texture2D

	# Placeholder: colored rect with CG name
	var w := 320 if is_thumb else 1920
	var h := 180 if is_thumb else 1080
	var color := Color(0.25, 0.18, 0.35)
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	img.fill(color)
	var tex := ImageTexture.create_from_image(img)
	tex.set_meta("cg_id", cg_id)
	return tex
