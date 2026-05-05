extends Control

var _current_cg_id: String = ""
var _cg_list: Array[String] = []

func _ready() -> void:
	$Buttons/PrevButton.pressed.connect(_on_prev)
	$Buttons/NextButton.pressed.connect(_on_next)
	$Buttons/CloseButton.pressed.connect(_on_close)
	$BGRect.gui_input.connect(_on_bg_input)
	_apply_theme()

func _apply_theme() -> void:
	VNTheme.style_button_primary($Buttons/PrevButton)
	VNTheme.style_button_primary($Buttons/CloseButton)
	VNTheme.style_button_primary($Buttons/NextButton)

func open_with(cg_id: String) -> void:
	_cg_list.clear()
	for id in GameManager.ALL_CGS:
		if GameManager.is_cg_unlocked(id):
			_cg_list.append(id)
	_current_cg_id = cg_id
	_display_current()
	# Entrance animation
	modulate.a = 0.0
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(self, "modulate:a", 1.0, 0.3)

func _display_current() -> void:
	var tex: Texture2D = GameManager.load_cg_texture(_current_cg_id, false)
	$BGRect.texture = tex
	$Buttons/PrevButton.visible = _cg_list.find(_current_cg_id) > 0
	$Buttons/NextButton.visible = _cg_list.find(_current_cg_id) < _cg_list.size() - 1

func _on_prev() -> void:
	var idx: int = _cg_list.find(_current_cg_id)
	if idx > 0:
		_current_cg_id = _cg_list[idx - 1]
		_display_current()

func _on_next() -> void:
	var idx: int = _cg_list.find(_current_cg_id)
	if idx < _cg_list.size() - 1:
		_current_cg_id = _cg_list[idx + 1]
		_display_current()

func _on_bg_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_close()

func _on_close() -> void:
	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(self, "modulate:a", 0.0, 0.25)
	tw.tween_callback(queue_free)
