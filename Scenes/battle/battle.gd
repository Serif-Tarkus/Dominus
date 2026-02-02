extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
#@onready var player_action: PlayerAction = $PlayerAction as PlayerAction
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player =  $PlayerAction as Player

func _ready() -> void:
	# Normally, we would do this on a 'Run'
	# level so we keep our health, money and deck
	# between battles.
	# this is temporary code for when I create full 'Runs' 
	# and greater expansions
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	
	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_lost.connect(_on_player_lost)
	
	start_battle(new_stats)
	
func start_battle(stats: CharacterStats) -> void:
	enemy_handler.reset_enemy_action()
	player_handler.start_battle(stats)

func _on_enemies_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("Victory!!!!!!!")

func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_action()

func _on_player_lost() -> void:
	print("Game over :(")
