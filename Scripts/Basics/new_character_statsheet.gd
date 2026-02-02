class_name Stats
extends Resource

## Stats that will be used for ALL NPCS, not just the player.
## A list of all properties that can receive bonuses.
#const MODIFIABLE_STATS = [
#	"max_health", "lust", "charm", "constitution", "attack", "defense", "speed", "hit_chance", "evasion"
#]

signal stats_changed


#@export_category("Stats")
@export var character_name: String
@export var max_health := 1
@export var max_lust : int
@export var base_constitution := 10:
	set(value):
		base_constitution = value

var health : int : set = set_health
var block : int : set = set_block
var lust : int : set = set_lust


func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()
	
func set_block(value : int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()

func set_lust(value : int) -> void:
	lust = clampi(value, 0, max_lust)
	stats_changed.emit()

func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage

func take_lust(damage : int) -> void:
	if damage <= 0:
		return
	
	self.lust += damage

func reduce_lust(amount : int) -> void:
	self.lust -= amount

func heal(amount : int) -> void:
	self.health += amount
	
func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
	
