extends Node2D

@export var world_environment : WorldEnvironment
@export var audio_player: AudioStreamPlayer

var main_menu : PackedScene = load("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if FileAccess.file_exists("user://settings.tres") :
		
		SaveData.settings = ResourceLoader.load("user://settings.tres")
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness / 100
	
	audio_player.volume_linear = SaveData.settings.master_sound / 100
	
	add_child(main_menu.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
