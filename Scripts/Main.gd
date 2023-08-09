extends Node2D

var duck = preload("res://Scenes/duck.tscn")

func _ready():
	$DuckGenerator.start()

func _process(delta):
	$Aim.position.x = get_local_mouse_position().x
	$Aim.position.y = get_local_mouse_position().y

func _on_duck_generator_timeout():
	randomize()
	Global.ducksInScreen = randi_range(getMinDucksGen(), getMaxDuckGen())		
	for index in Global.ducksInScreen:
		generateDuck()

func getMinDucksGen():
	var min = Global.wave / 2
	return 1 if int(min) < 1 else int(min)

func getMaxDuckGen():
	return 6 if Global.wave > 6 else Global.wave

func generateDuck():
	randomize()
	var newDuck = duck.instantiate()
	add_child(newDuck)
	newDuck.position.x = randf_range(50, 700)
	newDuck.position.y = 600

func refreshPoints():
	if (Global.ducksInScreen == 0):
		$WaitingTime.start()
		if (Global.ducksMissed > 0):
			$AnimationDog.play("DogLaugh")
			$AudioDogLaugh.play()
			Global.resetWave()
		elif (isWinningWave()):
			$AnimationDog.play("Capture")
			$AudioDogCapture.play()
			if (Global.wave >= 50):
				Global.resetWave()
			Global.increaseWave()
		else:
			Global.increaseWave()

func isWinningWave():
	return true if (Global.wave % 10) == 0 else false

func _on_waiting_time_timeout():
	$DuckGenerator.start()

func _on_top_body_entered(body):
	$AudioDuckMissed.play()
	Global.increaseDucksMissed()
	body.queue_free()
	refreshPoints()

func _on_floor_body_entered(body):
	$AudioDuckFloor.play()
	Global.increaseDucksHitted()
	body.queue_free()
	refreshPoints()

func _on_animation_dog_animation_finished(anim_name):
	if anim_name == "DogCaptures":
		Global.resetWave()
