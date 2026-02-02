extends EnemyAction

@export var lust := 4

var already_used := false

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var lust_check: CharacterStats
	
	if target:
		if target is Player:
			lust_check = target.stats
	
	if lust_check:
		if lust_check.lust >= (lust_check.max_lust/float(2)):
			return true
	
	
	return false

func perform_action() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	var lust_effect := LustEffect.new()
	var target_array: Array[Node] = [target]
	lust_effect.amount = lust
		
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(lust_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)	
