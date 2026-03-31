extends Enemy


func rand_skill() -> void :
	
	var random_int : int = randi() % 10
	
	if random_int == 0 :
		
		state = States.first_skill
	
	elif random_int <= 3 :
		
		pass
	
	elif random_int <= 6 :
		
		state = States.first_skill
	
	elif random_int <= 9 :
		
		pass


func _on_skill_timer_timeout() -> void:
	
	if on_screen and state not in [States.attacking, States.hurt] :
		
		rand_skill()
