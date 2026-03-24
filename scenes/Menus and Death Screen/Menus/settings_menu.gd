extends Control

@export var world_environment: WorldEnvironment
@export var brightness_slider: HSlider
@export var master_sound_slider: HSlider

@export var label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness / 100
	
	brightness_slider.value = SaveData.settings.brightness

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_brightness_slider_value_changed(value: float) -> void:
	
	SaveData.settings.brightness = value
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness / 100

func _on_master_sound_slider_value_changed(value: float) -> void:
	
	SaveData.settings.master_sound = value

func _on_difficulty_slider_value_changed(value: float) -> void :
	
	if value == 100 :
		
		label.text = ""
	
	elif value == 50 :
		
		label.text = "You really tought there was an easy mode ?"
	
	elif value == 0 :
		
		label.text = "Can't you read ? "
	


func _on_button_button_up() -> void:
	
	ResourceSaver.save(SaveData.settings, "user://settings.tres")
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")
