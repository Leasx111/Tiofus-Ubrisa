extends Control

func _ready() -> void: 
	
	for i in 4 : 
		
		if FileAccess.file_exists("user://test_data" + str(i) + ".tres") :
			
			var button_string : String = "VBoxContainer/LoadButton" + str(i)
			
			var button_node : Node = get_node(button_string)
			
			SaveData.player_data = ResourceLoader.load("user://test_data" + str(i) + ".tres")
			
			var imag = SaveData.player_data.last_checkpoint_image
			
			button_node.get_child(1).texture = imag
			
			button_node.get_child(0).text = "current level : " + str(SaveData.player_data.level)
		
		i += 1


func _on_button_button_up() -> void:
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")
	
	SaveData.load_game = 0


func _on_load_button_0_button_up() -> void:
	
	if FileAccess.file_exists("user://test_data0.tres") == true :
		
		get_tree().change_scene_to_file("res://scenes/Other/game.tscn")
		
		SaveData.player_data = ResourceLoader.load("user://test_data0.tres")
		
		SaveData.current_data = 0


func _on_load_button_1_button_up() -> void:
	
	if FileAccess.file_exists("user://test_data1.tres") == true :
		
		get_tree().change_scene_to_file("res://scenes/Other/game.tscn")
		
		SaveData.player_data = ResourceLoader.load("user://test_data1.tres")
		
		SaveData.current_data = 1


func _on_load_button_2_button_up() -> void:
	
	if FileAccess.file_exists("user://test_data2.tres") == true :
		
		get_tree().change_scene_to_file("res://scenes/Other/game.tscn")
		
		SaveData.player_data = ResourceLoader.load("user://test_data2.tres")
		
		SaveData.current_data = 2


func _on_load_button_3_button_up() -> void:
	
	if FileAccess.file_exists("user://test_data3.tres") == true :
		
		get_tree().change_scene_to_file("res://scenes/Other/game.tscn")
		
		SaveData.player_data = ResourceLoader.load("user://test_data3.tres")
		
		SaveData.current_data = 3


func _on_delete_button_0_button_up() -> void:
	
	DirAccess.remove_absolute("user://test_data0.tres")


func _on_delete_button_1_button_up() -> void:
	
	DirAccess.remove_absolute("user://test_data1.tres")


func _on_delete_button_2_button_up() -> void:
	
	DirAccess.remove_absolute("user://test_data2.tres")


func _on_delete_button_3_button_up() -> void:
	
	DirAccess.remove_absolute("user://test_data3.tres")
