extends Node2D

var duck = preload("res://Scenes/Duck.tscn")

func _ready():
	$TimerDuckGenerator.start()

func _process(_delta):
	$Aim.position.x = get_local_mouse_position().x
	$Aim.position.y = get_local_mouse_position().y

func _on_duck_generator_timeout():
	randomize()
	Global.ducksInScreen = int(rand_range(getMinDucksGen(), getMaxDuckGen()))
	print(Global.ducksInScreen)
	for index in Global.ducksInScreen:
		generateDuck()

func _on_waiting_time_timeout():
	$TimerDuckGenerator.start()

func _on_top_body_entered(body):
	if body.get("side"):
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

func getMinDucksGen():
	var ducksMin = (Global.wave / 2)
	return 1 if ducksMin < 1 else int(ducksMin)

func getMaxDuckGen():
	return 6 if Global.wave > 6 else Global.wave

func generateDuck():
	randomize()
	var newDuck = duck.instance()
	add_child(newDuck)
	newDuck.position.x = float(rand_range(50, 700))
	newDuck.position.y = 600

func refreshPoints():
	if (Global.ducksInScreen == 0):
		$TimerWaitingTime.start()
		if (Global.ducksMissed > 0):
			$AnimationDog.play("Laugh")
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
