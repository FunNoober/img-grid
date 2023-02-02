extends Control

onready var prefab_path = load("res://ImageItem.tscn")

var save_data = {
	"data" : []
}

func _ready() -> void:
	var f = File.new()
	if f.file_exists("user://save.data"):
		f.open("user://save.data", f.READ)
		var c_a_d = parse_json(f.get_as_text())
		save_data = c_a_d
		for i in range(len(save_data.data)):
			var it = prefab_path.instance()
			it.init(save_data.data[i].path)
			$MarginContainer/Contents/GraphEdit.add_child(it)
			it.data = save_data.data[i]
			it.offset.x = save_data.data[i].offset_x
			it.offset.y = save_data.data[i].offset_y
			it.rect_size.x = save_data.data[i].rect_size_x
			it.rect_size.y = save_data.data[i].rect_size_y

func _on_AddImageButton_pressed() -> void:
	$OpenImageDialog.popup()

func _on_OpenImageDialog_file_selected(path: String) -> void:
	create(path)

func create(path):
	var i = prefab_path.instance()
	i.init(path)
	$MarginContainer/Contents/GraphEdit.add_child(i)

func _on_SaveBoardButton_pressed() -> void:
	save_data.data = []
	for i in range(len(get_tree().get_nodes_in_group("ImageItem"))):
		save_data.data.append(get_tree().get_nodes_in_group("ImageItem")[i].data)
	var f = File.new()
	f.open("user://save.data", File.WRITE)
	f.store_string(JSON.print(save_data))
	f.close()

func _on_DeleteBoardButton_pressed() -> void:
	var dir = Directory.new()
	dir.remove("user://save.data")
