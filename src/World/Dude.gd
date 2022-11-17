extends Resource

var board = load("res://World/Board.tres")
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
	inner_panel.rect_position = Vector2(board.CELL_WIDTH * (board.BOARD_CENTER_COLUMN-player_column)+board.CELL_WIDTH/2, board.CELL_HEIGHT * (board.BOARD_CENTER_ROW-player_row)+board.CELL_HEIGHT/2)
	characters_tilemap.set_cell(player_column, player_row,characters_tilemap.tile_set.find_tile_by_name("Player"))

func moveDude(inner_panel, characters_tilemap, terrain_tilemap, items_tilemap, world, deltaX, deltaY):
	hide_dude(characters_tilemap)
	var next_row = player_row + deltaY
	var next_column = player_column + deltaX
	var tile_id = terrain_tilemap.get_cell(next_column, next_row)
	var terrain_id = world.tile_names[tile_id]
	var terrain_descriptor = world.terrains[terrain_id]
	if(terrain_descriptor.is_solid):
		next_row=player_row
		next_column=player_column
	else:
		tile_id = items_tilemap.get_cell(next_column, next_row)
		if tile_id !=-1:
			var item_id = world.tile_names[tile_id]
			var item_descriptor = world.items[item_id]
			if item_descriptor.has("is_door") && item_descriptor.is_door:
				next_row=player_row
				next_column=player_column
			elif item_descriptor.has("can_pickup") && item_descriptor.can_pickup:
				pass
	var character = world.characters[player_column][player_row]
	world.characters[player_column].erase(player_row)
	player_row=next_row
	player_column=next_column
	if !world.characters.has(player_column):
		world.characters[player_column]={}
	world.characters[player_column][player_row]=character
	show_dude(inner_panel, characters_tilemap)


func _ready():
	pass
