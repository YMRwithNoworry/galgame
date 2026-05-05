extends Control

const SLOT_COUNT: int = 6
const SAVE_BTN_TEXT: String = "保存"
const LOAD_BTN_TEXT: String = "加载"

var _show_save_btns: bool = true
var _show_load_btns: bool = true

func _ready() -> void:
	# Connect close button
	var close_btn := $Panel/VBoxContainer/CloseButton
	close_btn.pressed.connect(_on_close_pressed)
	visibility_changed.connect(_on_visibility_changed)
	_apply_theme()
	_build_slots()

## Set which buttons are visible.  mode=true → both, mode=false → load only.
func set_save_load_mode(show_save: bool = true, show_load: bool = true) -> void:
	_show_save_btns = show_save
	_show_load_btns = show_load
	_refresh_slot_buttons()

func _build_slots() -> void:
	var grid: GridContainer = $Panel/VBoxContainer/GridContainer
	# Clear existing
	for child in grid.get_children():
		child.queue_free()

	for i in SLOT_COUNT:
		var slot := _create_slot(i)
		grid.add_child(slot)
	_refresh_slot_buttons()

func _create_slot(slot_id: int) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(320, 120)
	VNTheme.style_panel_container(panel, VNTheme.SURFACE_CARD)

	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 10)

	# Thumbnail
	var thumb := TextureRect.new()
	thumb.name = "Thumbnail"
	thumb.custom_minimum_size = Vector2(160, 90)
	thumb.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	hbox.add_child(thumb)

	# Right side: info + buttons
	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.add_theme_constant_override("separation", 4)

	var slot_label := Label.new()
	slot_label.name = "SlotLabel"
	slot_label.text = "槽位 %d" % (slot_id + 1) if slot_id > 0 else "快速存档"
	VNTheme.style_label(slot_label, VNTheme.INK, VNTheme.FONT_BODY, true)
	vbox.add_child(slot_label)

	var info_label := Label.new()
	info_label.name = "InfoLabel"
	info_label.text = "—— 空 ——"
	VNTheme.style_label(info_label, VNTheme.MUTED_SOFT, VNTheme.FONT_CAPTION)
	info_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_label.custom_minimum_size = Vector2(120, 0)
	vbox.add_child(info_label)

	var btn_hbox := HBoxContainer.new()
	btn_hbox.add_theme_constant_override("separation", 8)

	var save_btn := Button.new()
	save_btn.name = "SaveBtn"
	save_btn.text = SAVE_BTN_TEXT
	save_btn.pressed.connect(_on_save_pressed.bind(slot_id))
	VNTheme.style_button_primary(save_btn)
	btn_hbox.add_child(save_btn)

	var load_btn := Button.new()
	load_btn.name = "LoadBtn"
	load_btn.text = LOAD_BTN_TEXT
	load_btn.pressed.connect(_on_load_pressed.bind(slot_id))
	VNTheme.style_button_secondary(load_btn)
	btn_hbox.add_child(load_btn)

	vbox.add_child(btn_hbox)
	hbox.add_child(vbox)
	panel.add_child(hbox)

	# Store references
	panel.set_meta("slot_id", slot_id)
	panel.set_meta("save_btn", save_btn)
	panel.set_meta("load_btn", load_btn)
	panel.set_meta("info_label", info_label)
	panel.set_meta("thumb", thumb)

	return panel

func _refresh_slot_buttons() -> void:
	var grid: GridContainer = $Panel/VBoxContainer/GridContainer
	for panel in grid.get_children():
		var save_btn: Button = panel.get_meta("save_btn")
		var load_btn: Button = panel.get_meta("load_btn")
		save_btn.visible = _show_save_btns
		load_btn.visible = _show_load_btns

func _on_visibility_changed() -> void:
	if visible:
		_update_all_slots()

func _update_all_slots() -> void:
	var grid: GridContainer = $Panel/VBoxContainer/GridContainer
	for panel in grid.get_children():
		var slot_id: int = panel.get_meta("slot_id")
		var info_label: Label = panel.get_meta("info_label")
		var thumb_rect: TextureRect = panel.get_meta("thumb")
		var load_btn: Button = panel.get_meta("load_btn")

		var data: Dictionary = GameManager.get_slot_info(slot_id)
		if data.is_empty():
			info_label.text = "—— 空 ——"
			info_label.modulate = Color(0.7, 0.7, 0.7)
			thumb_rect.texture = null
			load_btn.disabled = true
		else:
			var ts: String = data.get("timestamp", "")
			var summary: String = data.get("summary", "")
			info_label.text = "%s\n%s" % [ts, summary]
			info_label.modulate = Color(1, 1, 1)
			load_btn.disabled = false
			# Thumbnail
			var tex: Texture2D = GameManager.get_thumbnail(slot_id)
			thumb_rect.texture = tex

func _on_save_pressed(slot_id: int) -> void:
	GameManager.save(slot_id)
	_update_all_slots()

func _on_load_pressed(slot_id: int) -> void:
	GameManager.load_slot(slot_id)
	close_panel()

func open_panel() -> void:
	visible = true
	var panel: Panel = $Panel
	panel.modulate.a = 0.0
	panel.position.y = 20.0
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(panel, "modulate:a", 1.0, 0.25)
	tw.parallel().tween_property(panel, "position:y", 0.0, 0.3)

func close_panel() -> void:
	var panel: Panel = $Panel
	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(panel, "modulate:a", 0.0, 0.2)
	tw.parallel().tween_property(panel, "position:y", 15.0, 0.2)
	tw.tween_callback(func() -> void: visible = false)

func _on_close_pressed() -> void:
	close_panel()

func _apply_theme() -> void:
	VNTheme.style_panel($Panel, VNTheme.SURFACE_DARK)
	VNTheme.style_label($Panel/VBoxContainer/TitleLabel, VNTheme.PRIMARY, VNTheme.FONT_TITLE)
	VNTheme.style_button_secondary($Panel/VBoxContainer/CloseButton)
