extends Control

@export var world_environment: WorldEnvironment
@export var brightness_slider: HSlider
@export var master_sound_slider: HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	world_environment.environment.adjustment_brightness = SaveData.brightness / 100
	
	brightness_slider.value = SaveData.brightness

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_brightness_slider_value_changed(value: float) -> void:
	
	SaveData.brightness = brightness_slider.value
	
	world_environment.environment.adjustment_brightness = SaveData.brightness / 100

func _on_master_sound_slider_value_changed(value: float) -> void:
	
	SaveData.master_sound = master_sound_slider.value


func _on_button_button_up() -> void:
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")
