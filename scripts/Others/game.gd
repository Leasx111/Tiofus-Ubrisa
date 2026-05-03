extends Node2D

class_name Game

@export var room_transition: RoomTransition
@export var first_room : PackedScene
@export var roomloader : RoomLoader
@export var tutorial: TutorialMenu
@export var player: Player


func _ready() -> void :
	
	get_parent().get_child(1).stream_paused = true
	
	await roomloader.change_room(first_room, "spawn_left")
	
	if SaveData.load_game != 0 :
		
		SaveData.load_game = 0
		
		if SaveData.player_data.last_checkpoint_position :
			
			player.position = SaveData.player_data.last_checkpoint_position
		
		else : 
			
			player.position = Vector2(-470, 0)
	
	else : 
		
		await tutorial.fade_in()
	
	await room_transition.tween_finished
	
	player.player_exp.max_value = SaveData.player_data.max_XP
	
	var tween_exp = create_tween()
	
	tween_exp.tween_property(player.player_exp, "value", SaveData.player_data.current_xp, 1)

func _input(event: InputEvent) -> void :
	
	if event.is_action_pressed("toggle_exit_menu") :
		
		tutorial.fade_out()
