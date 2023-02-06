extends GraphNode

var data = {
	"path" : "",
	"offset_x" : 0,
	"offset_y" : 0,
	"rect_size_x" : 0,
	"rect_size_y" : 0
}

func init(img_path):
	var image = Image.new()
	image.load(img_path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	$TextureRect.texture = t
	rect_size = $TextureRect.texture.get_size()
	data.path = img_path
	
	var popup = $MenuButton.get_popup()
	popup.connect("id_pressed", self, "menu_button_pressed")

func _on_ImageItem_resize_request(new_minsize: Vector2) -> void:
	rect_size = new_minsize
	data.rect_size_x = rect_size.x
	data.rect_size_y = rect_size.y

func _on_ImageItem_offset_changed() -> void:
	data.offset_x = offset.x
	data.offset_y = offset.y
	
func _on_ImageItem_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			queue_free()

func _on_ImageItem_mouse_entered() -> void:
	$MenuButton.show()

func _on_ImageItem_mouse_exited() -> void:
	$MenuButton.hide()

func _on_MenuButton_mouse_entered() -> void:
	$MenuButton.show()

func menu_button_pressed(id):
	if id == 0:
		queue_free()


