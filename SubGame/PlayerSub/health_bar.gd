extends TextureRect

@export var max_anchor := 0.84
var rate = 1.0

func _process(delta: float) -> void:
	#print(rate*0.84)
	%Health.anchor_right = lerp(%Health.anchor_right, rate * max_anchor, delta*2)


func update_bar(health: float):
	rate = float(health) / 11
	print("LAVA"," ", health," ", rate)
