class_name CharacterStats
extends Stats
# These are the stats for the player
# inherits from new_character_statsheet to avoid having every enemy/npc having unneccesary stats
@export var starting_deck: CardPile
@export var cards_per_turn: int
@export var base_stamina: int
@export var stamina_rate: int

var stamina: int : set = set_stamina
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func set_stamina(value: int) -> void:
	stamina = value
	stats_changed.emit()

func regenerate_stamina() -> void:
	self.stamina += stamina_rate
	
func can_play_card(card: Card) -> bool:
	return stamina >= card.cost
	
func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.lust = 0
	instance.base_stamina = base_stamina
	instance.block = 0
	#instance.regenerate_stamina()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
