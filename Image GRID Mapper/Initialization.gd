extends Node

var data = {
	"LowProcessorMode" : false,
	"WindowWidth" : 1024,
	"WindowHeight" : 600,
	"WindowResizable" : true,
	"WindowBorderless" : false,
	"FXAA" : false,
	"confirmed" : false
}

func _ready() -> void:
	var f = File.new()
	
	if f.file_exists("config.cfg") == false:
		var cfg = ConfigFile.new()
		cfg.set_value("Config", "data", data)
		cfg.save("config.cfg")
	else:
		var cfg = ConfigFile.new()
		cfg.load("config.cfg")
		data = cfg.get_value("Config", "data")
		
		ProjectSettings.set("application/run/low_processor_mode", data.LowProcessorMode)
		OS.window_size.x = data.WindowWidth
		OS.window_size.y = data.WindowHeight
		ProjectSettings.set("display/window/size/resizable", data.WindowResizable)
		ProjectSettings.set("display/window/size/borderless", data.WindowBorderless)
		ProjectSettings.set("rendering/quality/filters/use_fxaa", data.FXAA)
		
		if data.confirmed == false:
			get_parent().get_node("Root/ConfirmationDialog").popup()

	get_parent().get_node("Root/ConfirmationDialog").connect("confirmed", self, "agreed")
	get_parent().get_node("Root/ConfirmationDialog").get_cancel().connect("pressed", self, "cancelled")
	
func agreed():
	data.confirmed = true
	var cfg = ConfigFile.new()
	cfg.set_value("Config", "data", data)
	cfg.save("config.cfg")
	get_parent().get_node("Root/ConfirmationDialog").hide()

func cancelled():
	get_tree().quit()
