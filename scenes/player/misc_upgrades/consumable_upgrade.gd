class_name ConsumableUpgrade
extends Resource

@export  var display_name : String = "Upgrade Placeholder"
@export var img_filepath : String = ""
@export  var mechanics : Array[String] = []

func _apply_upgrade(_player: Player):
    pass

func _remove_upgrade(_player: Player):
    pass