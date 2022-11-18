extends Resource

var rng = RandomNumberGenerator.new()
var tiles_table = {}
var tile_names = {}
func make_tile_table(tile_set):
	for id in tile_set.get_tiles_ids():
		tiles_table[tile_set.tile_get_name(id)]=id
		tile_names[id]=tile_set.tile_get_name(id)


var terrains = {
	"Floor":{
		"is_solid": false
	},
	"Solid":{
		"is_solid": true
	},
	"North Wall":{
		"is_solid": true
	},
	"South Wall":{
		"is_solid": true
	},
	"East Wall":{
		"is_solid": true
	},
	"West Wall":{
		"is_solid": true
	},
	"North Doorway":{
		"is_solid": false
	},
	"South Doorway":{
		"is_solid": false
	},
	"East Doorway":{
		"is_solid": false
	},
	"West Doorway":{
		"is_solid": false
	},
	"Northeast Inside Corner":{
		"is_solid": true
	},
	"Northwest Inside Corner":{
		"is_solid": true
	},
	"Southeast Inside Corner":{
		"is_solid": true
	},
	"Southwest Inside Corner":{
		"is_solid": true
	},
	"Northeast Outside Corner":{
		"is_solid": true
	},
	"Northwest Outside Corner":{
		"is_solid": true
	},
	"Southeast Outside Corner":{
		"is_solid": true
	},
	"Southwest Outside Corner":{
		"is_solid": true
	}
}
var door_table = {
	"Red": ["North Red Door","East Red Door","South Red Door","West Red Door"],
	"Yellow": ["North Yellow Door","East Yellow Door","South Yellow Door","West Yellow Door"],
	"Green": ["North Green Door","East Green Door","South Green Door","West Green Door"],
	"Cyan": ["North Cyan Door","East Cyan Door","South Cyan Door","West Cyan Door"],
	"Blue": ["North Blue Door","East Blue Door","South Blue Door","West Blue Door"],
	"Magenta": ["North Magenta Door","East Magenta Door","South Magenta Door","West Magenta Door"],
}
var door_generator = {
	"Red":32,
	"Yellow":16,
	"Green":8,
	"Cyan":4,
	"Blue":2,
	"Magenta":1,
}
 
func generate_door_color():
	var total = 0
	for key in door_generator:
		total+=door_generator[key]
	var generated = rng.randi_range(0,total-1)
	for key in door_generator:
		if generated<door_generator[key]:
			return key
		generated-=door_generator[key]

var items = {
	"North Red Door":{
		"is_door": true,
		"key": "Red Key"
	},
	"East Red Door":{
		"is_door": true,
		"key": "Red Key"
	},
	"South Red Door":{
		"is_door": true,
		"key": "Red Key"
	},
	"West Red Door":{
		"is_door": true,
		"key": "Red Key"
	},
	"North Yellow Door":{
		"is_door": true,
		"key": "Yellow Key"
	},
	"East Yellow Door":{
		"is_door": true,
		"key": "Yellow Key"
	},
	"South Yellow Door":{
		"is_door": true,
		"key": "Yellow Key"
	},
	"West Yellow Door":{
		"is_door": true,
		"key": "Yellow Key"
	},
	"North Green Door":{
		"is_door": true,
		"key": "Green Key"
	},
	"East Green Door":{
		"is_door": true,
		"key": "Green Key"
	},
	"South Green Door":{
		"is_door": true,
		"key": "Green Key"
	},
	"West Green Door":{
		"is_door": true,
		"key": "Green Key"
	},
	"North Cyan Door":{
		"is_door": true,
		"key": "Cyan Key"
	},
	"East Cyan Door":{
		"is_door": true,
		"key": "Cyan Key"
	},
	"South Cyan Door":{
		"is_door": true,
		"key": "Cyan Key"
	},
	"West Cyan Door":{
		"is_door": true,
		"key": "Cyan Key"
	},
	"North Blue Door":{
		"is_door": true,
		"key": "Blue Key"
	},
	"East Blue Door":{
		"is_door": true,
		"key": "Blue Key"
	},
	"South Blue Door":{
		"is_door": true,
		"key": "Blue Key"
	},
	"West Blue Door":{
		"is_door": true,
		"key": "Blue Key"
	},
	"North Magenta Door":{
		"is_door": true,
		"key": "Magenta Key"
	},
	"East Magenta Door":{
		"is_door": true,
		"key": "Magenta Key"
	},
	"South Magenta Door":{
		"is_door": true,
		"key": "Magenta Key"
	},
	"West Magenta Door":{
		"is_door": true,
		"key": "Magenta Key"
	},
	"Red Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":0,
		"inventory_row":0
	},
	"Yellow Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":1,
		"inventory_row":0
	},
	"Green Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":2,
		"inventory_row":0
	},
	"Cyan Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":0,
		"inventory_row":1
	},
	"Blue Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":1,
		"inventory_row":1
	},
	"Magenta Key":{
		"spawn_count": 0,
		"spawn_filter": "nondeadend",
		"can_pickup":true,
		"inventory_column":2,
		"inventory_row":1
	},
}
var character_types = {
	"Player":{
		"is_player":true,
		"spawn_count":1,
		"spawn_filter":"nondeadend"
	}
}
var characters = {}
