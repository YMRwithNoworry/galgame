extends Control

@onready var content: VBoxContainer = $Content
@onready var title_label: Label = $Content/Title
@onready var divider: HSeparator = $Content/Divider
@onready var subtitle_label: Label = $Content/Subtitle
@onready var record_container: HBoxContainer = $Content/RecordContainer
@onready var back_btn: Button = $Content/BackButton
@onready var top_line: ColorRect = $Content/TopLine
@onready var bottom_line: ColorRect = $BottomLine

const STORIES: Array[Dictionary] = [
	{
		"id": "moonlit_whispers",
		"title": "月下水语",
		"subtitle": "MOONLIT WHISPERS",
		"desc": "深夜的莱茵生命中庭\n月光、水元素，与一位古老的精灵",
		"color": Color(0.2, 0.35, 0.5),
		"start_label": "",
	},
	{
		"id": "coming_soon",
		"title": "？？？",
		"subtitle": "COMING SOON",
		"desc": "尚未解锁的乐曲\n敬请期待",
		"color": Color(0.6, 0.6, 0.6),
		"start_label": "",
		"locked": true,
	},
]

func _ready() -> void:
	var sep := StyleBoxLine.new()
	sep.color = Color(0, 0, 0, 0.1)
	sep.thickness = 1
	divider.add_theme_stylebox_override("separator", sep)

	var sb := StyleBoxEmpty.new()
	back_btn.add_theme_stylebox_override("normal", sb)
	back_btn.add_theme_stylebox_override("hover", sb)
	back_btn.add_theme_stylebox_override("pressed", sb)
	back_btn.add_theme_stylebox_override("disabled", sb)
	back_btn.pressed.connect(_on_back_pressed)

	_build_records()
	_hide_all()
	_play_entrance()

func _build_records() -> void:
	for story in STORIES:
		var card := _create_record_card(story)
		record_container.add_child(card)

func _create_record_card(story: Dictionary) -> VBoxContainer:
	var card := VBoxContainer.new()
	card.custom_minimum_size = Vector2(200, 0)
	card.add_theme_constant_override("separation", 12)
	card.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var locked: bool = story.get("locked", false)
	var accent: Color = story.get("color", Color(0.3, 0.3, 0.3))

	# Vinyl disc — drawn with _draw
	var disc := Control.new()
	disc.custom_minimum_size = Vector2(160, 160)
	disc.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	disc.set_meta("color", accent)
	disc.set_meta("locked", locked)
	disc.draw.connect(_draw_disc.bind(disc))
	card.add_child(disc)

	# Title
	var lbl_title := Label.new()
	lbl_title.text = story.get("title", "")
	lbl_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl_title.add_theme_font_size_override("font_size", 20)
	lbl_title.add_theme_color_override("font_color", Color(0.05, 0.05, 0.05) if not locked else Color(0.6, 0.6, 0.6))
	var title_font := SystemFont.new()
	title_font.font_names = PackedStringArray(["Noto Serif CJK SC", "思源宋体", "SimSun", "宋体"])
	title_font.font_weight = 300
	lbl_title.add_theme_font_override("font", title_font)
	card.add_child(lbl_title)

	# Subtitle
	var lbl_sub := Label.new()
	lbl_sub.text = story.get("subtitle", "")
	lbl_sub.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl_sub.add_theme_font_size_override("font_size", 11)
	lbl_sub.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5) if not locked else Color(0.75, 0.75, 0.75))
	var sub_font := SystemFont.new()
	sub_font.font_names = PackedStringArray(["Noto Sans CJK SC", "Microsoft YaHei UI", "微软雅黑", "Arial"])
	sub_font.font_weight = 300
	lbl_sub.add_theme_font_override("font", sub_font)
	card.add_child(lbl_sub)

	# Description
	var lbl_desc := Label.new()
	lbl_desc.text = story.get("desc", "")
	lbl_desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl_desc.add_theme_font_size_override("font_size", 12)
	lbl_desc.add_theme_color_override("font_color", Color(0.45, 0.45, 0.45) if not locked else Color(0.78, 0.78, 0.78))
	lbl_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	var desc_font := SystemFont.new()
	desc_font.font_names = PackedStringArray(["Noto Sans CJK SC", "Microsoft YaHei UI", "微软雅黑", "Arial"])
	desc_font.font_weight = 300
	lbl_desc.add_theme_font_override("font", desc_font)
	card.add_child(lbl_desc)

	if not locked:
		# Make the whole card clickable
		var click_area := Button.new()
		click_area.custom_minimum_size = Vector2(0, 0)
		click_area.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		click_area.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		click_area.text = "开始"
		click_area.add_theme_font_size_override("font_size", 13)
		click_area.add_theme_color_override("font_color", accent)
		click_area.add_theme_color_override("font_hover_color", accent.lightened(0.3))
		click_area.add_theme_color_override("font_pressed_color", accent.darkened(0.2))
		var btn_sb := StyleBoxEmpty.new()
		click_area.add_theme_stylebox_override("normal", btn_sb)
		click_area.add_theme_stylebox_override("hover", btn_sb)
		click_area.add_theme_stylebox_override("pressed", btn_sb)
		click_area.pressed.connect(_on_record_selected.bind(story))
		card.add_child(click_area)
		card.set_meta("click_area", click_area)

	card.set_meta("story", story)
	card.modulate.a = 0.0
	return card

func _draw_disc(ctrl: Control) -> void:
	var c: Color = ctrl.get_meta("color", Color(0.3, 0.3, 0.3))
	var locked: bool = ctrl.get_meta("locked", false)
	var center := ctrl.size * 0.5
	var radius := minf(ctrl.size.x, ctrl.size.y) * 0.45

	if locked:
		# Greyed out disc
		c = Color(0.75, 0.75, 0.75)

	# Outer ring
	ctrl.draw_arc(center, radius, 0, TAU, 64, c.darkened(0.2), 2.0)
	# Fill
	ctrl.draw_circle(center, radius - 1.0, c if not locked else Color(0.85, 0.85, 0.85))
	# Grooves
	for i in range(3, 8):
		var r := radius * float(i) / 10.0
		var groove_color := c.darkened(0.15) if not locked else Color(0.8, 0.8, 0.8)
		ctrl.draw_arc(center, r, 0, TAU, 48, groove_color, 0.5)
	# Center label
	var label_r := radius * 0.22
	ctrl.draw_circle(center, label_r, Color(1, 1, 1) if not locked else Color(0.9, 0.9, 0.9))
	ctrl.draw_arc(center, label_r, 0, TAU, 32, c.darkened(0.1) if not locked else Color(0.8, 0.8, 0.8), 1.0)
	# Spindle hole
	ctrl.draw_circle(center, 3.0, c.darkened(0.3) if not locked else Color(0.7, 0.7, 0.7))

func _hide_all() -> void:
	for node: CanvasItem in [top_line, title_label, divider, subtitle_label, back_btn, bottom_line]:
		node.modulate.a = 0.0
	for card in record_container.get_children():
		card.modulate.a = 0.0
	content.position.y = 20.0

func _play_entrance() -> void:
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)

	tw.tween_property(bottom_line, "modulate:a", 1.0, 0.4).set_delay(0.1)
	tw.parallel().tween_property(content, "position:y", 0.0, 0.5)
	tw.tween_property(top_line, "modulate:a", 1.0, 0.3)
	tw.tween_property(title_label, "modulate:a", 1.0, 0.4).set_delay(0.1)
	tw.tween_property(divider, "modulate:a", 1.0, 0.3).set_delay(0.1)
	tw.tween_property(subtitle_label, "modulate:a", 1.0, 0.3).set_delay(0.05)

	# Stagger record cards
	var delay := 0.2
	for card in record_container.get_children():
		tw.tween_property(card, "modulate:a", 1.0, 0.4).set_delay(delay)
		delay += 0.15

	tw.tween_property(back_btn, "modulate:a", 1.0, 0.3).set_delay(0.1)

func _on_record_selected(story: Dictionary) -> void:
	var start_label: String = story.get("start_label", "")
	if not start_label.is_empty():
		GameManager.start_from_label(start_label)
	else:
		GameManager.reset_game()

	# Fade out and transition
	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(content, "modulate:a", 0.0, 0.3)
	tw.parallel().tween_property(content, "position:y", -15.0, 0.3)
	tw.tween_property(bottom_line, "modulate:a", 0.0, 0.2)
	tw.tween_callback(func() -> void: get_tree().change_scene_to_file("res://Main.tscn"))

func _on_back_pressed() -> void:
	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(content, "modulate:a", 0.0, 0.25)
	tw.parallel().tween_property(content, "position:y", -15.0, 0.25)
	tw.tween_property(bottom_line, "modulate:a", 0.0, 0.15)
	tw.tween_callback(func() -> void: get_tree().change_scene_to_file("res://TitleScreen.tscn"))
