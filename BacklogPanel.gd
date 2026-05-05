extends Control

const MAX_DISPLAY: int = 200

func _ready() -> void:
	$Panel/VBoxContainer/CloseButton.pressed.connect(_on_close_pressed)
	VNTheme.style_panel($Panel, VNTheme.SURFACE_DARK)
	VNTheme.style_label($Panel/VBoxContainer/TitleBar/Title, VNTheme.PRIMARY, VNTheme.FONT_TITLE)
	VNTheme.style_button_secondary($Panel/VBoxContainer/CloseButton)

func update_panel() -> void:
	var vbox: VBoxContainer = $Panel/VBoxContainer/ScrollContainer/VBoxContainer
	# Clear existing entries
	for child in vbox.get_children():
		child.queue_free()

	var log: Array[Dictionary] = GameManager.history_log
	var start: int = maxi(0, log.size() - MAX_DISPLAY)

	for i in range(start, log.size()):
		var entry: Dictionary = log[i]
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 12)

		var speaker: String = entry.get("speaker", "")
		if not speaker.is_empty():
			var speaker_label := Label.new()
			speaker_label.text = speaker
			VNTheme.style_label(speaker_label, VNTheme.PRIMARY, VNTheme.FONT_BODY)
			speaker_label.custom_minimum_size.x = 80
			hbox.add_child(speaker_label)

		var text_label := Label.new()
		text_label.text = entry.get("text", "")
		VNTheme.style_label(text_label, VNTheme.ON_DARK, VNTheme.FONT_BODY_SM)
		text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		hbox.add_child(text_label)

		vbox.add_child(hbox)

	# Scroll to bottom
	await get_tree().process_frame
	var scroll: ScrollContainer = $Panel/VBoxContainer/ScrollContainer
	scroll.scroll_vertical = scroll.get_v_scroll_bar().max_value

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
