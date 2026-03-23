extends Sprite2D

class_name Checkpoint

@export var animation_player : AnimationPlayer 

@export var save_image : Texture2D

@onready var player : CharacterBody2D = $"/root/Game/Player"

# Variable for player near
var player_is_near : bool = false

var lit : bool = false

# Player is near if inside area
func _on_area_2d_area_entered(area: Area2D) -> void :
	
	if area.is_in_group("player") : 
		
		self.player_is_near = true

# Player is far if outside area
func _on_area_2d_area_exited(area: Area2D) -> void :
	
	if area.is_in_group("player") : 
		
		self.player_is_near = false

func _input(event : InputEvent) -> void : 
	
	if event.is_action_released("save") and self.player_is_near :
		
		player.set_last_checkpoint(self)
		
		if self.lit == false :
			
			animation_player.play("on_save")
		
		self.lit = true
		
		SaveData.emit_signal("save_requested")
