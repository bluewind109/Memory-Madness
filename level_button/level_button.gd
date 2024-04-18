extends TextureButton

@onready var label = $Label
@onready var click_sound = $ClickSound

var _level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "3x4"

func set_level_number(level_num: int) -> void:
	_level_number = level_num
	var level_data = GameManager.LEVELS[_level_number]
	label.text = "%sx%s" % [level_data.rows, level_data.cols]

func _on_pressed():
	SoundManager.play_button_click(click_sound)
