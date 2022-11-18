extends Resource

var constants = load("res://World/Constants.gd")
var maze = load("res://World/Maze.tres")

var player_column = 10
var player_row = 10

func spawn_dude(world):
	for column in world.characters:
		for row in world.characters[column]:
			var character=world.characters[column][row]
			var descriptor=world.character_types[character.character_type]
			if descriptor.is_player:
				player_column=column
				player_row=row
				return

func hide_dude(characters_tilemap):
	characters_tilemap.set_cell(player_column, player_row,-1)
	
func show_dude(inner_panel, characters_tilemap):
	inner_panel.rect_position = Vector2(constants.CELL_WIDTH * (constants.BOARD_CENTER_COLUMN-player_column)+constants.CELL_WIDTH/2, constants.CELL_HEIGHT * (constants.BOARD_CENTER_ROW-player_row)+constants.CELL_HEIGHT/2)
	characters_tilemap.set_cell(player_column, player_row,characters_tilemap.tile_set.find_tile_by_name("Player"))

func add_item_to_inventory(character, item_name):
	if !character.has("inventory"):
		character.inventory={}
	if character.inventory.has(item_name):
		character.inventory[item_name] += 1
	else:
		character.inventory[item_name] = 1
		
func is_item_door(item_descriptor):
	return item_descriptor.has("is_door") && item_descriptor.is_door
	
func can_pick_item_up(item_descriptor):
	return item_descriptor.has("can_pickup") && item_descriptor.can_pickup
	
func character_has_item(character, item_name):
	if !character.has("inventory"):
		return false
	if !character.inventory.has(item_name):
		return false
	return character.inventory[item_name]>0
	
func character_remove_item(character, item_name):
	if character.has("inventory") && character.inventory.has(item_name) && character.inventory[item_name]>0:
		character.inventory[item_name]-=1
	
func character_unlock_door(character, item_descriptor):
	if !is_item_door(item_descriptor):
		return false
	var key = item_descriptor.key
	if character_has_item(character, key):
		character_remove_item(character, key)
		return true
	else:
		return false

func moveDude(inner_panel, characters_tilemap, terrain_tilemap, items_tilemap, world, deltaX, deltaY):
	hide_dude(characters_tilemap)
	var next_row = player_row + deltaY
	var next_column = player_column + deltaX
	var tile_id = terrain_tilemap.get_cell(next_column, next_row)
	var terrain_id = world.tile_names[tile_id]
	var terrain_descriptor = world.terrains[terrain_id]
	var character = world.characters[player_column][player_row]
	if(terrain_descriptor.is_solid):
		next_row=player_row
		next_column=player_column
	else:
		tile_id = items_tilemap.get_cell(next_column, next_row)
		if tile_id !=-1:
			var item_name = world.tile_names[tile_id]
			var item_descriptor = world.items[item_name]
			if is_item_door(item_descriptor):
				if !character_unlock_door(character, item_descriptor):
					next_row=player_row
					next_column=player_column
				else:
					items_tilemap.set_cell(next_column, next_row,-1)
					next_row=player_row
					next_column=player_column
			elif can_pick_item_up(item_descriptor):
				items_tilemap.set_cell(next_column, next_row,-1)
				add_item_to_inventory(character, item_name)
	world.characters[player_column].erase(player_row)
	player_row=next_row
	player_column=next_column
	if !world.characters.has(player_column):
		world.characters[player_column]={}
	world.characters[player_column][player_row]=character
	show_dude(inner_panel, characters_tilemap)

func update_inventory(inventory_tilemap, world):
	var character = world.characters[player_column][player_row]
	for column in range(constants.INVENTORY_COLUMNS):
		for row in range(constants.INVENTORY_ROWS):
			inventory_tilemap.set_cell(column, row, -1)
	if character.has("inventory"):
		for item_name in character.inventory:
			if character.inventory[item_name]>0:
				var descriptor = world.items[item_name]
				inventory_tilemap.set_cell(descriptor.inventory_column, descriptor.inventory_row, world.tiles_table[item_name])

func _ready():
	pass
