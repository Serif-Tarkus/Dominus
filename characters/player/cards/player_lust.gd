extends Card

func apply_effects(targets: Array[Node]) -> void:
	print("applied")
	var damage_effect := LustEffect.new()
	damage_effect.amount = 4
	damage_effect.execute(targets)
