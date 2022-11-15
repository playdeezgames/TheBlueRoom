extends Resource

const CELL_WIDTH = 32
const CELL_HEIGHT = 32
const BOARD_COLUMNS = 21
const BOARD_ROWS = 21
const BOARD_CENTER_COLUMN = 10
const BOARD_CENTER_ROW = 10

var player_column = 10
var player_row = 10

func hide_dude(characters_tilemap):
	characters_tilemap.set_cell(player_column, player_row,-1)
	
func show_dude(inner_panel, characters_tilemap):
	inner_panel.rect_position = Vector2(CELL_WIDTH * (BOARD_CENTER_COLUMN-player_column)+CELL_WIDTH/2, CELL_HEIGHT * (BOARD_CENTER_ROW-player_row)+CELL_HEIGHT/2)
	characters_tilemap.set_cell(player_column, player_row,characters_tilemap.tile_set.find_tile_by_name("Player"))

func moveDude(inner_panel, characters_tilemap, terrain_tilemap, world, deltaX, deltaY):
	hide_dude(characters_tilemap)
	var next_row = player_row + deltaY
	var next_column = player_column + deltaX
	var tile_id = terrain_tilemap.get_cell(next_column, next_row)
	var terrain_id = world.tile_names[tile_id]
	var terrain_descriptor = world.terrains[terrain_id]
	if(!terrain_descriptor.is_solid):
		player_row=next_row
		player_column=next_column
	show_dude(inner_panel, characters_tilemap)


func _ready():
	pass
