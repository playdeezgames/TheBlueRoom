extends Node

export(NodePath) var terrain_tilemap
export(NodePath) var items_tilemap
var maze = load("res://World/Maze.tres")
var board = load("res://World/Board.tres")
var world = load("res://World/World.tres")
var rng = RandomNumberGenerator.new()

func render_template(dst_column, dst_row, columns, rows, src_column, src_row):
	for column in range(columns):
		for row in range(rows):
			get_node(terrain_tilemap).set_cell(dst_column+column, dst_row+row, $Templates.get_cell(src_column+column, src_row+row))

func add_door_item(dst_column, dst_row, direction):
	var door_color = world.generate_door_color()
	var item_name = world.door_table[door_color][direction]
	get_node(items_tilemap).set_cell(dst_column, dst_row, world.tiles_table[item_name])
	var item = world.items[item_name]
	var key_name = item.key
	world.items[key_name].spawn_count+=1

func render_passageway(the_maze, dst_column, dst_row, maze_column, maze_row):
	var cell = the_maze[maze_column][maze_row]
	var src_column = 0
	var src_row = board.BOARD_ROWS
	if(cell.doors[maze.DIRECTION_NORTH]):
		src_column+=board.BOARD_COLUMNS
	if(cell.doors[maze.DIRECTION_EAST]):
		src_column+=board.BOARD_COLUMNS*2
	if(cell.doors[maze.DIRECTION_SOUTH]):
		src_row+=board.BOARD_ROWS
	if(cell.doors[maze.DIRECTION_WEST]):
		src_row+=board.BOARD_ROWS*2
	render_template(dst_column, dst_row, board.BOARD_COLUMNS, board.BOARD_ROWS, src_column, src_row)
	if cell.doorways[maze.DIRECTION_NORTH]:
		render_template(dst_column+7, dst_row, 7,1,70,0)
		add_door_item(dst_column+10, dst_row, maze.DIRECTION_NORTH)
	if cell.doorways[maze.DIRECTION_SOUTH]:
		render_template(dst_column+7, dst_row+20, 7,1,70,20)
		add_door_item(dst_column+10, dst_row+20, maze.DIRECTION_SOUTH)
	if cell.doorways[maze.DIRECTION_WEST]:
		render_template(dst_column, dst_row+7, 1,7,63,7)
		add_door_item(dst_column, dst_row+10, maze.DIRECTION_WEST)
	if cell.doorways[maze.DIRECTION_EAST]:
		render_template(dst_column+20, dst_row+7, 1,7,83,7)
		add_door_item(dst_column+20, dst_row+10, maze.DIRECTION_EAST)

func render_chamber(the_maze, dst_column, dst_row, maze_column, maze_row):
	render_template(dst_column, dst_row, board.BOARD_COLUMNS, board.BOARD_ROWS, 0, 0)
	var cell = the_maze[maze_column][maze_row]
	if(cell.doors[maze.DIRECTION_NORTH]):
		if cell.doorways[maze.DIRECTION_NORTH]:
			render_template(dst_column+7, dst_row, 7,1,28,0)
			if !cell.dead_end:
				add_door_item(dst_column+10, dst_row, maze.DIRECTION_NORTH)
		else:
			render_template(dst_column+7, dst_row, 7,1,49,0)
	if(cell.doors[maze.DIRECTION_SOUTH]):
		if cell.doorways[maze.DIRECTION_SOUTH]:
			render_template(dst_column+7, dst_row+20, 7,1,28,20)
			if !cell.dead_end:
				add_door_item(dst_column+10, dst_row+20, maze.DIRECTION_SOUTH)
		else:
			render_template(dst_column+7, dst_row+20, 7,1,49,20)
	if(cell.doors[maze.DIRECTION_WEST]):
		if cell.doorways[maze.DIRECTION_WEST]:
			render_template(dst_column, dst_row+7, 1,7,21,7)
			if !cell.dead_end:
				add_door_item(dst_column, dst_row+10, maze.DIRECTION_WEST)
		else:
			render_template(dst_column, dst_row+7, 1,7,42,7)
	if(cell.doors[maze.DIRECTION_EAST]):
		if cell.doorways[maze.DIRECTION_EAST]:
			render_template(dst_column+20, dst_row+7, 1,7,41,7)
			if !cell.dead_end:
				add_door_item(dst_column+20, dst_row+10, maze.DIRECTION_EAST)
		else:
			render_template(dst_column+20, dst_row+7, 1,7,62,7)

func spawn_item(the_maze, item, descriptor):
	var column
	var row
	var done = false
	while !done:
		column = rng.randi_range(0,maze.MAZE_COLUMNS*board.BOARD_COLUMNS-1)
		row = rng.randi_range(0,maze.MAZE_ROWS*board.BOARD_ROWS-1)
		var terrain_id = get_node(terrain_tilemap).get_cell(column,row)
		var terrain_descriptor = world.terrains[world.tile_names[terrain_id]]
		if !terrain_descriptor.is_solid:
			var dead_end = the_maze[column/board.BOARD_COLUMNS][row/board.BOARD_ROWS].dead_end
			done = !descriptor.has("spawn_filter") || (descriptor.spawn_filter=="nondeadend" && !dead_end) || (descriptor.spawn_filter=="deadend" && dead_end)
	get_node(items_tilemap).set_cell(column, row, world.tiles_table[item])

func populate_items(the_maze):
	for item in world.items:
		var descriptor = world.items[item]
		if descriptor.has("spawn_count"):
			var spawn_count = descriptor.spawn_count
			while spawn_count>0:
				spawn_item(the_maze, item, descriptor)
				spawn_count-=1

func render_maze(the_maze):
	for maze_column in range(maze.MAZE_COLUMNS):
		for maze_row in range(maze.MAZE_ROWS):
			if the_maze[maze_column][maze_row].chamber:
				render_chamber(the_maze, maze_column*board.BOARD_COLUMNS, maze_row*board.BOARD_ROWS,maze_column, maze_row)
			else:
				render_passageway(the_maze, maze_column*board.BOARD_COLUMNS, maze_row*board.BOARD_ROWS,maze_column, maze_row)
	populate_items(the_maze)

func _ready():
	pass
