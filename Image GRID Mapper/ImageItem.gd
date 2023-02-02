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

func _on_ImageItem_resize_request(new_minsize: Vector2) -> void:
	rect_size = new_minsize
	data.rect_size_x = rect_size.x
	data.rect_size_y = rect_size.y

func _on_ImageItem_offset_changed() -> void:
	data.offset_x = offset.x
	data.offset_y = offset.y
