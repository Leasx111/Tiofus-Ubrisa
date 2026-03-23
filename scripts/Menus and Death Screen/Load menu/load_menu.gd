extends Control

func _ready() -> void: 
	
	for i in 4 : 
		
		update_img(i,false)
		
		i += 1


func update_img(i : int, delete : bool) :
	
	if FileAccess.file_exists("user://test_data" + str(i) + ".tres") :
		
		var button_string : String = "VBoxContainer/LoadButton" + str(i)
		
		var button_node : Node = get_node(button_string)
		
		SaveData.player_data = ResourceLoader.load("user://test_data" + str(i) + ".tres")
		
		if SaveData.player_data.last_checkpoint_image :
			
			var imag = SaveData.player_data.last_checkpoint_image
			
			button_node.get_child(1).texture = imag
			
			button_node.get_child(0).text = "current level : " + str(SaveData.player_data.level)
		
		else :
			
			var imag = load("res://assets/Menus and Death Screen/Load Menu/save_image_test.png")
			
			button_node.get_child(1).texture = imag
			
			button_node.get_child(0).text = "current level : " + str(SaveData.player_data.level)
			
		
		if delete == true :
			
			button_node.get_child(1).texture = null
			
			button_node.get_child(0).text = ""


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
	
	update_img(0, true)
	
	DirAccess.remove_absolute("user://test_data0.tres")


func _on_delete_button_1_button_up() -> void:
	
	update_img(1, true)
	
	DirAccess.remove_absolute("user://test_data1.tres")


func _on_delete_button_2_button_up() -> void:
	
	update_img(2, true)
	
	DirAccess.remove_absolute("user://test_data2.tres")


func _on_delete_button_3_button_up() -> void:
	
	update_img(3, true)
	
	DirAccess.remove_absolute("user://test_data3.tres")
