extends Control

@export var world_environment: WorldEnvironment

@export var new_game_button: Button
@export var load_button: Button 

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	
	world_environment.environment.adjustment_brightness = SaveData.brightness / 100
	
	SaveData.calc_files()
	
	if SaveData.save_files <= 0 :
		
		new_game_button.disabled = false
		
		load_button.disabled = true
	
	if SaveData.save_files > 0 :
		
		new_game_button.disabled = false
		
		load_button.disabled = false
	
	if SaveData.save_files == 4 :
		
		new_game_button.disabled = true
		
		load_button.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func _on_new_game_button_up() -> void :
	
	get_tree().change_scene_to_file("res://scenes/Other/game.tscn")
	
	SaveData.player_data = PlayerData.new() 
	
	SaveData.calc_files()
	
	ResourceSaver.save(SaveData.player_data, "user://test_data" + str(SaveData.save_files) + ".tres")
	
	SaveData.current_data = SaveData.save_files

func _on_load_button_up() -> void :
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/load_menu.tscn")
	
	SaveData.load_game = 1

func _on_settings_button_up() -> void :
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/settings_menu.tscn")

func _on_exit_button_up() -> void:
	
	get_tree().quit()
