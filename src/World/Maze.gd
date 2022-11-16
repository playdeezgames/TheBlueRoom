extends Resource

const MAZE_COLUMNS = 8
const MAZE_ROWS = 8
enum {DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_SOUTH, DIRECTION_WEST, DIRECTION_COUNT}

func columnStep(column, _row, direction):
	match direction:
		DIRECTION_EAST:
			return column+1
		DIRECTION_WEST:
			return column-1
		_: 
			return column
	
func rowStep(_column, row, direction):
	match direction:
		DIRECTION_NORTH:
			return row-1
		DIRECTION_SOUTH:
			return row+1
		_: 
			return row
			
func oppositeDirection(direction):
	return (direction + DIRECTION_COUNT/2) % DIRECTION_COUNT

func createMaze():
	var maze=[]
	while maze.size()<MAZE_COLUMNS:
		var mazeColumn = []
		while mazeColumn.size()<MAZE_ROWS:
			mazeColumn.push_back({doors=[false,false,false,false], inside=false, chamber=false})
		maze.push_back(mazeColumn)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var column = rng.randi_range(0,MAZE_COLUMNS-1)
	var row = rng.randi_range(0,MAZE_ROWS-1)
	maze[column][row].inside=true
	var remaining = MAZE_COLUMNS * MAZE_ROWS - 1
	while(remaining>0):
		column = rng.randi_range(0,MAZE_COLUMNS-1)
		row = rng.randi_range(0,MAZE_ROWS-1)
		if(!maze[column][row].inside):
			var directions=[]
			for direction in range(DIRECTION_COUNT):
				var nextColumn = columnStep(column, row, direction)
				var nextRow = rowStep(column,row, direction)
				if(nextColumn>=0 && nextRow>=0 && nextColumn<MAZE_COLUMNS && nextRow<MAZE_ROWS && maze[nextColumn][nextRow].inside):
					directions.push_back(direction)
			if(!directions.empty()):
				var direction = directions[rng.randi_range(0,directions.size()-1)]
				var nextColumn = columnStep(column, row, direction)
				var nextRow = rowStep(column,row, direction)
				maze[column][row].doors[direction]=true
				maze[nextColumn][nextRow].doors[oppositeDirection(direction)]=true
				maze[column][row].inside=true
				remaining-=1
	return maze

func chamberize(maze):
	var rng = RandomNumberGenerator.new()
	for maze_column in maze:
		for cell in maze_column:
			var door_count = 0
			for door in cell.doors:
				if door:
					door_count+=1
			var percent = 0
			match door_count:
				1:
					percent = 100
				2:
					percent = 25
				3:
					percent = 75
				4:
					percent = 50
			cell.chamber=rng.randi_range(1,100)<=percent

func _ready():
	pass
