extends Control

var _master_slider: HSlider
var _bgm_slider: HSlider
var _sfx_slider: HSlider
var _master_value_label: Label
var _bgm_value_label: Label
var _sfx_value_label: Label
var _text_speed_slider: HSlider
var _text_speed_label: Label
var _auto_check: CheckButton
var _auto_delay_slider: HSlider
var _auto_delay_label: Label
var _skip_check: CheckButton

func _ready() -> void:
	# ── Cache node references ──
	var panel: PanelContainer = $Panel
	var body: VBoxContainer = panel.get_node("VBoxContainer")

	_master_slider       = body.get_node("MasterRow/Slider")
	_master_value_label  = body.get_node("MasterRow/Value")
	_bgm_slider          = body.get_node("BGMRow/Slider")
	_bgm_value_label     = body.get_node("BGMRow/Value")
	_sfx_slider          = body.get_node("SFXRow/Slider")
	_sfx_value_label     = body.get_node("SFXRow/Value")
	_text_speed_slider   = body.get_node("TextSpeedRow/Slider")
	_text_speed_label    = body.get_node("TextSpeedRow/Value")
	_auto_check          = body.get_node("AutoRow/CheckButton")
	_auto_delay_slider   = body.get_node("AutoDelayRow/Slider")
	_auto_delay_label    = body.get_node("AutoDelayRow/Value")
	_skip_check          = body.get_node("SkipRow/CheckButton")

	# ── Wire signals ──
	_master_slider.value_changed.connect(_on_master_changed)
	_bgm_slider.value_changed.connect(_on_bgm_changed)
	_sfx_slider.value_changed.connect(_on_sfx_changed)
	_text_speed_slider.value_changed.connect(_on_text_speed_changed)
	_auto_check.toggled.connect(_on_auto_toggled)
	_auto_delay_slider.value_changed.connect(_on_auto_delay_changed)

	body.get_node("ButtonRow/ApplyButton").pressed.connect(_on_apply_pressed)
	body.get_node("ButtonRow/CloseButton").pressed.connect(_on_close_pressed)

	_apply_theme(body)
	refresh_ui()

## Called by GameManager when the menu becomes visible.
func refresh_ui() -> void:
	# Audio sliders show 0-100, internally store 0.0-1.0
	_master_slider.value = GameManager._get_bus_linear("Master") * 100.0
	_bgm_slider.value    = GameManager._get_bus_linear("BGM")    * 100.0
	_sfx_slider.value    = GameManager._get_bus_linear("SFX")    * 100.0
	_master_value_label.text = "%d%%" % int(_master_slider.value)
	_bgm_value_label.text    = "%d%%" % int(_bgm_slider.value)
	_sfx_value_label.text    = "%d%%" % int(_sfx_slider.value)

	# Text speed: display in ms (e.g. "30ms"), slider range 1-100 mapped to 0.01-0.10s
	_text_speed_slider.value = GameManager.text_speed * 1000.0
	_text_speed_label.text = "%dms" % int(_text_speed_slider.value)

	_auto_check.button_pressed = GameManager.auto_mode
	_auto_delay_slider.value = GameManager.auto_delay
	_auto_delay_label.text = "%.1fs" % GameManager.auto_delay
	_auto_delay_slider.editable = GameManager.auto_mode

	_skip_check.button_pressed = GameManager.skip_read

# ── Audio callbacks ──────────────────────────────────────────────────────────
func _on_master_changed(value: float) -> void:
	GameManager._apply_bus_volume("Master", value / 100.0)
	_master_value_label.text = "%d%%" % int(value)

func _on_bgm_changed(value: float) -> void:
	GameManager._apply_bus_volume("BGM", value / 100.0)
	_bgm_value_label.text = "%d%%" % int(value)

func _on_sfx_changed(value: float) -> void:
	GameManager._apply_bus_volume("SFX", value / 100.0)
	_sfx_value_label.text = "%d%%" % int(value)

# ── Game callbacks ───────────────────────────────────────────────────────────
func _on_text_speed_changed(value: float) -> void:
	GameManager.text_speed = value / 1000.0
	_text_speed_label.text = "%dms" % int(value)

func _on_auto_toggled(pressed: bool) -> void:
	GameManager.auto_mode = pressed
	_auto_delay_slider.editable = pressed

func _on_auto_delay_changed(value: float) -> void:
	GameManager.auto_delay = value
	_auto_delay_label.text = "%.1fs" % value

# ── Buttons ──────────────────────────────────────────────────────────────────
func _on_apply_pressed() -> void:
	GameManager.skip_read = _skip_check.button_pressed
	GameManager.save_settings()

func open_panel() -> void:
	visible = true
	var panel: PanelContainer = $Panel
	panel.modulate.a = 0.0
	panel.position.y = 20.0
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(panel, "modulate:a", 1.0, 0.25)
	tw.parallel().tween_property(panel, "position:y", 0.0, 0.3)

func close_panel() -> void:
	var panel: PanelContainer = $Panel
	var tw := create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property(panel, "modulate:a", 0.0, 0.2)
	tw.parallel().tween_property(panel, "position:y", 15.0, 0.2)
	tw.tween_callback(func() -> void: visible = false)

func _on_close_pressed() -> void:
	close_panel()

func _apply_theme(body: VBoxContainer) -> void:
	VNTheme.style_panel_container($Panel, VNTheme.SURFACE_DARK)
	VNTheme.style_label(body.get_node("Title"), VNTheme.PRIMARY, VNTheme.FONT_TITLE)

	# Separators
	for sep_name in ["Sep0", "Sep1", "Sep2", "Sep3"]:
		VNTheme.style_separator(body.get_node(sep_name))

	# Row labels
	for row_name in ["MasterRow", "BGMRow", "SFXRow", "TextSpeedRow", "AutoRow", "AutoDelayRow", "SkipRow"]:
		VNTheme.style_label(body.get_node(row_name + "/Label"), VNTheme.ON_DARK, VNTheme.FONT_BODY)

	# Value labels
	for row_name in ["MasterRow", "BGMRow", "SFXRow", "TextSpeedRow", "AutoDelayRow"]:
		VNTheme.style_label(body.get_node(row_name + "/Value"), VNTheme.ON_DARK_SOFT, VNTheme.FONT_BODY_SM)

	# Sliders
	for row_name in ["MasterRow", "BGMRow", "SFXRow", "TextSpeedRow", "AutoDelayRow"]:
		VNTheme.style_slider(body.get_node(row_name + "/Slider"))

	# CheckButtons
	VNTheme.style_checkbutton(body.get_node("AutoRow/CheckButton"))
	VNTheme.style_checkbutton(body.get_node("SkipRow/CheckButton"))

	# Buttons
	VNTheme.style_button_primary(body.get_node("ButtonRow/ApplyButton"))
	VNTheme.style_button_secondary(body.get_node("ButtonRow/CloseButton"))
