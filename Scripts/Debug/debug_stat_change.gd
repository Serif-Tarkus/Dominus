extends Node2D

var is_active := true
var stat_added := 5
@onready var player_node = get_tree().root.get_node("Main/Player")
var is_player := false

func _ready():
	player_node = get_tree().root.get_node("Main/Player")
	print("We're Ready!")
	print(PlayerAction.character_name)
	##print(player_node.attack)

##func _on_area_2d_body_entered(body: Node2D) -> void:
	

##func _on_area_2d_body_exited(body: Node2D) -> void:



func _on_body_entered(body):
	print("In")
	if body == player_node:
		is_player = true
		print(PlayerAction.base_attack)
		PlayerAction.base_attack += 10
		PlayerAction.character_name = "Gavin"
		print(PlayerAction.character_name)
		print(PlayerAction.base_attack)
		#print("You're attack is now " % PlayerAction.base_attack)


func _on_body_exited(body):
	if body == player_node:
		print("You've left the attack boost area")		
