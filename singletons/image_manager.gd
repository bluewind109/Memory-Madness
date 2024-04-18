extends Node

var _item_images: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_images()
	
func add_files_to_list(file_name: String, path: String) -> void:
	var full_path = path + "/" + file_name
	
	# item images dictionary
	var ii_dict = {
		"item_name": file_name.rstrip(".png"),
		"item_texture": load(full_path)
	}
	_item_images.append(ii_dict)

func load_item_images() -> void:
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("ERROR: ", path)
		return
		
	var file_names = dir.get_files()
	
	# fn = file name
	for fn in file_names:
		if ".import" not in fn:
			add_files_to_list(fn, path)
