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
		"door_color": "Red"
	},
	"East Red Door":{
		"is_door": true,
		"door_color": "Red"
	},
	"South Red Door":{
		"is_door": true,
		"door_color": "Red"
	},
	"West Red Door":{
		"is_door": true,
		"door_color": "Red"
	},
	"North Yellow Door":{
		"is_door": true,
		"door_color": "Yellow"
	},
	"East Yellow Door":{
		"is_door": true,
		"door_color": "Yellow"
	},
	"South Yellow Door":{
		"is_door": true,
		"door_color": "Yellow"
	},
	"West Yellow Door":{
		"is_door": true,
		"door_color": "Yellow"
	},
	"North Green Door":{
		"is_door": true,
		"door_color": "Green"
	},
	"East Green Door":{
		"is_door": true,
		"door_color": "Green"
	},
	"South Green Door":{
		"is_door": true,
		"door_color": "Green"
	},
	"West Green Door":{
		"is_door": true,
		"door_color": "Green"
	},
	"North Cyan Door":{
		"is_door": true,
		"door_color": "Cyan"
	},
	"East Cyan Door":{
		"is_door": true,
		"door_color": "Cyan"
	},
	"South Cyan Door":{
		"is_door": true,
		"door_color": "Cyan"
	},
	"West Cyan Door":{
		"is_door": true,
		"door_color": "Cyan"
	},
	"North Blue Door":{
		"is_door": true,
		"door_color": "Blue"
	},
	"East Blue Door":{
		"is_door": true,
		"door_color": "Blue"
	},
	"South Blue Door":{
		"is_door": true,
		"door_color": "Blue"
	},
	"West Blue Door":{
		"is_door": true,
		"door_color": "Blue"
	},
	"North Magenta Door":{
		"is_door": true,
		"door_color": "Magenta"
	},
	"East Magenta Door":{
		"is_door": true,
		"door_color": "Magenta"
	},
	"South Magenta Door":{
		"is_door": true,
		"door_color": "Magenta"
	},
	"West Magenta Door":{
		"is_door": true,
		"door_color": "Magenta"
	},
}
