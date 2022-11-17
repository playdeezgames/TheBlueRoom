extends Resource

var board = load("res://World/Board.tres")
var maze = load("res://World/Maze.tres")

var player_column = 10
var player_row = 10

func spawn_dude(the_maze):
	var rng = RandomNumberGenerator.new()
	var maze_column = rng.randi_range(0,maze.MAZE_COLUMNS-1)
	var maze_row = rng.randi_range(0,maze.MAZE_ROWS-1)
	while the_maze[maze_column][maze_row].dead_end:
		maze_column = rng.randi_range(0,maze.MAZE_COLUMNS-1)
		maze_row = rng.randi_range(0,maze.MAZE_ROWS-1)
	player_column = board.BOARD_COLUMNS * maze_column+10
	player_row = board.BOARD_ROWS * maze_row+10

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
	player_row=next_row
	player_column=next_column
	show_dude(inner_panel, characters_tilemap)


func _ready():
	pass
