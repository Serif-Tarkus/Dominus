class_name Player
extends CharacterBody2D

@export var stats: CharacterStats : set = set_character_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats_ui: StatsUI = $StatsUI as StatsUI


	
func set_character_stats(value: CharacterStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_player()

func update_player() -> void:
	if not stats is CharacterStats:
		print("Whoops!")
		return
	if not is_inside_tree():
		await ready
	
	update_stats()

func update_stats() -> void:
	stats_ui.update_stats(stats)
	
func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	stats.take_damage(damage)
	
	if stats.health <= 0:
		Events.player_lost.emit()
		queue_free()

func take_lust(damage: int) -> void:
	if stats.lust >= stats.max_lust:
		return
	
	stats.take_lust(damage)
	
	if stats.lust >= stats.max_lust:
		queue_free()
