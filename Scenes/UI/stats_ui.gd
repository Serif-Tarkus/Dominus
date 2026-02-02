class_name StatsUI
extends HBoxContainer

@onready var block: HBoxContainer = $Block
@onready var block_label: Label = %BlockLabel
@onready var health: HBoxContainer = $Health
@onready var health_label: Label = %HealthLabel
@onready var lust: HBoxContainer = $Lust
@onready var lust_label: Label = %LustLabel

func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health_label.text = str(stats.health)
	lust_label.text = str(stats.lust) + "/" + str(stats.max_lust)
	
	block.visible = stats.block > 0
	health.visible = stats.health > 0
	lust.visible = stats.lust < 100
