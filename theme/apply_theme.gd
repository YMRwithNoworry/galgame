class_name VNTheme
## Warm-canvas editorial design system for the visual novel engine.
## Call VNTheme.apply(root_node) after _init_references to restyle the entire UI.

# ── Color Palette ────────────────────────────────────────────────────────────
const CANVAS        := Color(0.98, 0.976, 0.961)      # #faf9f5
const SURFACE_SOFT  := Color(0.961, 0.941, 0.91)       # #f5f0e8
const SURFACE_CARD  := Color(0.937, 0.914, 0.871)      # #efe9de
const SURFACE_DARK  := Color(0.094, 0.09, 0.082)       # #181715
const SURFACE_DARK_ELEVATED := Color(0.145, 0.137, 0.125) # #252320
const HAIRLINE      := Color(0.902, 0.875, 0.831)      # #e6dfd8
const INK           := Color(0.078, 0.078, 0.075)      # #141413
const BODY          := Color(0.239, 0.239, 0.227)      # #3d3d3a
const MUTED         := Color(0.424, 0.416, 0.392)      # #6c6a64
const MUTED_SOFT    := Color(0.557, 0.545, 0.51)       # #8e8b82
const PRIMARY       := Color(0.8, 0.471, 0.361)        # #cc785c
const PRIMARY_ACTIVE:= Color(0.663, 0.345, 0.243)      # #a9583e
const ON_PRIMARY    := Color(1, 1, 1)
const ON_DARK       := Color(0.98, 0.976, 0.961)       # #faf9f5
const ON_DARK_SOFT  := Color(0.627, 0.616, 0.588)      # #a09d96
const ACCENT_TEAL   := Color(0.365, 0.722, 0.651)      # #5db8a6

# ── Font Sizes ───────────────────────────────────────────────────────────────
const FONT_DISPLAY  := 28
const FONT_TITLE    := 22
const FONT_BODY     := 16
const FONT_BODY_SM  := 14
const FONT_CAPTION  := 13
const FONT_BUTTON   := 14

# ── Rounded ──────────────────────────────────────────────────────────────────
const RADIUS_MD := 8
const RADIUS_LG := 12

# ═════════════════════════════════════════════════════════════════════════════
#  Style Factories
# ═════════════════════════════════════════════════════════════════════════════
static func make_panel_style(bg: Color, radius: int = RADIUS_LG, border: Color = Color.TRANSPARENT) -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = bg
	sb.set_corner_radius_all(radius)
	if border != Color.TRANSPARENT:
		sb.border_color = border
		sb.set_border_width_all(1)
	sb.content_margin_left = 24
	sb.content_margin_top = 20
	sb.content_margin_right = 24
	sb.content_margin_bottom = 20
	return sb

static func make_button_style(bg: Color, radius: int = RADIUS_MD) -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = bg
	sb.set_corner_radius_all(radius)
	sb.content_margin_left = 20
	sb.content_margin_top = 10
	sb.content_margin_right = 20
	sb.content_margin_bottom = 10
	return sb

static func make_slider_style() -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = HAIRLINE
	sb.set_corner_radius_all(4)
	sb.content_margin_top = 6
	sb.content_margin_bottom = 6
	return sb

static func make_slider_grabber() -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = PRIMARY
	sb.set_corner_radius_all(10)
	sb.content_margin_left = 10
	sb.content_margin_right = 10
	sb.content_margin_top = 10
	sb.content_margin_bottom = 10
	return sb

# ═════════════════════════════════════════════════════════════════════════════
#  Node Styling Helpers
# ═════════════════════════════════════════════════════════════════════════════
static func style_label(lbl: Label, color: Color, size: int = FONT_BODY, bold: bool = false) -> void:
	lbl.add_theme_color_override("font_color", color)
	lbl.add_theme_font_size_override("font_size", size)

static func style_button_primary(btn: Button) -> void:
	btn.add_theme_stylebox_override("normal", make_button_style(PRIMARY))
	btn.add_theme_stylebox_override("hover", make_button_style(PRIMARY_ACTIVE))
	btn.add_theme_stylebox_override("pressed", make_button_style(PRIMARY_ACTIVE))
	btn.add_theme_stylebox_override("disabled", make_button_style(HAIRLINE))
	btn.add_theme_color_override("font_color", ON_PRIMARY)
	btn.add_theme_color_override("font_hover_color", ON_PRIMARY)
	btn.add_theme_color_override("font_disabled_color", MUTED)
	btn.add_theme_font_size_override("font_size", FONT_BUTTON)

static func style_button_secondary(btn: Button) -> void:
	btn.add_theme_stylebox_override("normal", make_button_style(CANVAS))
	btn.add_theme_stylebox_override("hover", make_button_style(SURFACE_CARD))
	btn.add_theme_stylebox_override("pressed", make_button_style(SURFACE_CARD))
	btn.add_theme_stylebox_override("disabled", make_button_style(HAIRLINE))
	btn.add_theme_color_override("font_color", INK)
	btn.add_theme_color_override("font_hover_color", INK)
	btn.add_theme_color_override("font_disabled_color", MUTED)
	btn.add_theme_font_size_override("font_size", FONT_BUTTON)

static func style_rtl(rtl: RichTextLabel, color: Color = ON_DARK, size: int = FONT_BODY) -> void:
	rtl.add_theme_color_override("default_color", color)
	rtl.add_theme_font_size_override("normal_font_size", size)

static func style_panel(pnl: Panel, bg: Color = SURFACE_DARK, radius: int = RADIUS_LG) -> void:
	pnl.add_theme_stylebox_override("panel", make_panel_style(bg, radius))

static func style_panel_container(pnl: PanelContainer, bg: Color = SURFACE_DARK, radius: int = RADIUS_LG) -> void:
	pnl.add_theme_stylebox_override("panel", make_panel_style(bg, radius))

static func style_line_edit(le: LineEdit) -> void:
	var sb := make_button_style(CANVAS)
	le.add_theme_stylebox_override("normal", sb)
	le.add_theme_stylebox_override("focus", make_button_style(CANVAS))
	le.add_theme_color_override("font_color", INK)
	le.add_theme_font_size_override("font_size", FONT_BODY)

static func style_checkbutton(cb: CheckButton) -> void:
	cb.add_theme_color_override("font_color", INK)
	cb.add_theme_font_size_override("font_size", FONT_BODY)

static func style_slider(slider: HSlider) -> void:
	slider.add_theme_stylebox_override("slider", make_slider_style())
	slider.add_theme_stylebox_override("grabber_area", make_slider_grabber())

static func style_separator(sep: HSeparator) -> void:
	var sb := StyleBoxLine.new()
	sb.color = HAIRLINE
	sb.thickness = 1
	sep.add_theme_stylebox_override("separator", sb)

static func style_tab_container(tc: TabContainer) -> void:
	tc.add_theme_color_override("font_selected_color", INK)
	tc.add_theme_color_override("font_unselected_color", MUTED)
	tc.add_theme_font_size_override("font_size", FONT_BODY_SM)

# ═════════════════════════════════════════════════════════════════════════════
#  Full Scene Apply
# ═════════════════════════════════════════════════════════════════════════════
static func apply_main_scene(main: Control) -> void:
	# ── Canvas background ──
	var bg: TextureRect = main.get_node("BG")
	bg.modulate = CANVAS

	# ── Dialog Panel — dark navy surface ──
	var panel: Panel = main.get_node("DialogPanel")
	style_panel(panel, SURFACE_DARK, RADIUS_LG)

	# ── Speaker Name — coral accent ──
	var speaker: Label = main.get_node("DialogPanel/MarginContainer/VBoxContainer/SpeakerName")
	style_label(speaker, PRIMARY, FONT_TITLE)

	# ── Dialog Text — cream on dark ──
	var rtl: RichTextLabel = main.get_node("DialogPanel/MarginContainer/VBoxContainer/DialogText")
	style_rtl(rtl, ON_DARK, FONT_BODY)

	# ── Next Button — primary coral ──
	var next_btn: Button = main.get_node("DialogPanel/MarginContainer/VBoxContainer/NextButton")
	style_button_primary(next_btn)

	# ── Top buttons — secondary style ──
	for btn_name in ["SystemMenuButton", "BacklogButton", "SettingsButton", "CGGalleryButton"]:
		if main.has_node(btn_name):
			var btn: Button = main.get_node(btn_name)
			style_button_secondary(btn)

	# ── Choice Container — centered ──
	var cc: VBoxContainer = main.get_node("ChoiceContainer")
	cc.add_theme_constant_override("separation", 12)

	# ── BGFadeOverlay — keep transparent ──
	var fade: ColorRect = main.get_node("BGFadeOverlay")
	fade.color = Color(0, 0, 0, 0)

# ═════════════════════════════════════════════════════════════════════════════
#  Dynamic Choice Button Styling
# ═════════════════════════════════════════════════════════════════════════════
static func style_choice_button(btn: Button) -> void:
	style_button_secondary(btn)
	btn.custom_minimum_size = Vector2(300, 44)
