extends Control

const GRID_COLS: int = 4
const THUMB_SIZE: Vector2 = Vector2(320, 180)

func _ready() -> void:
	$Panel/VBoxContainer/CloseButton.pressed.connect(_on_close_pressed)
	var grid: GridContainer = $Panel/VBoxContainer/ScrollContainer/GridContainer
	grid.columns = GRID_COLS
	VNTheme.style_panel($Panel, VNTheme.SURFACE_DARK)
	VNTheme.style_label($Panel/VBoxContainer/Title, VNTheme.PRIMARY, VNTheme.FONT_TITLE)
	VNTheme.style_button_secondary($Panel/VBoxContainer/CloseButton)

func refresh_gallery() -> void:
	var grid: GridContainer = $Panel/VBoxContainer/ScrollContainer/GridContainer
	for child in grid.get_children():
		child.queue_free()

	for cg_id in GameManager.ALL_CGS:
		var btn := Button.new()
		btn.custom_minimum_size = THUMB_SIZE

		var tex: Texture2D = GameManager.load_cg_texture(cg_id, true)
		if GameManager.is_cg_unlocked(cg_id):
			btn.icon = tex
			btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			btn.expand_icon = true
			btn.pressed.connect(_on_cg_selected.bind(cg_id))
		else:
			btn.text = "???"
			btn.disabled = true
			btn.icon = tex
			btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			btn.expand_icon = true
			btn.modulate = Color(0.3, 0.3, 0.3, 1.0)

		VNTheme.style_button_secondary(btn)
		grid.add_child(btn)

func _on_cg_selected(cg_id: String) -> void:
	var viewer: Control = load("res://CGViewer.tscn").instantiate()
	get_tree().current_scene.add_child(viewer)
	viewer.open_with(cg_id)

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
