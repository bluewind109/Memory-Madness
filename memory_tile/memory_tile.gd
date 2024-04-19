extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String
var _can_select: bool = true

func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)
	
func get_item_name() -> String:
	return _item_name
	
func reveal(val: bool) -> void:
	frame_image.visible = val
	item_image.visible = val
	
func setup(
	ii_dict: Dictionary, 
	_frame_img: CompressedTexture2D
) -> void:
	frame_image.texture = _frame_img
	item_image.texture = ii_dict.item_texture
	_item_name = ii_dict.item_name
	reveal(false)

func on_selection_disabled() -> void:
	_can_select = false
	
func on_selection_enabled() -> void:
	_can_select = true

func _on_pressed():
	if (_can_select == true):
		SignalManager.on_tile_selected.emit(self)
