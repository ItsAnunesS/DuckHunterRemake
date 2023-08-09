extends Area2D

var duck

func _ready():
	pass

func _on_Aim_body_entered(body):
	duck = body

func _input(_event):
	if Input.is_action_just_pressed("Shoot"):
		$AudioShoot.play()
		if ((not duck == null) && (not duck.get("isDuck") == null)):
			duck.kill()
