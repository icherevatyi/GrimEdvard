extends Node

var item_data
var loot_data


func _ready():
	var itemdata_file = File.new()
	itemdata_file.open("res://src/data/ItemList.json", File.READ)
	var itemdata_json = JSON.parse(itemdata_file.get_as_text())
	itemdata_file.close()
	item_data = itemdata_json.result
	
	var lootdata_file = File.new()
	lootdata_file.open("res://src/data/LootList.json", File.READ)
	var lootdata_json = JSON.parse(lootdata_file.get_as_text())
	lootdata_file.close()
	loot_data = lootdata_json.result

func get_item(item_id):
	if item_id in item_data:
		return item_data[item_id]
	else:
		print("no such item found")