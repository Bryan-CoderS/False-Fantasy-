extends Area2D

@export var Scene_2: PackedScene

var tiles = []
var solved = []
var mouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

func start_game():
	tiles = [$Puzzle1, $Puzzle2, $Puzzle3, $Puzzle4, $Puzzle5, $Puzzle6, $Puzzle7, $Puzzle8, $Puzzle9]
	solved = tiles.duplicate()
	shuffle_tiles()

func shuffle_tiles():
	var previous = 99
	var previous_1 = 98
	for t in range(1, 750):
		var tile = randi() % 9
		if tiles[tile] != $Puzzle9 and tile != previous and tile != previous_1:
			var rows = int(tiles[tile].position.y / 250)
			var cols = int(tiles[tile].position.x / 250)
			check_neighbours(rows, cols)
			previous_1 = previous
			previous = tile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var mouse_copy = mouse
		print(mouse_copy.position)
		mouse = false
		var rows = int(mouse_copy.position.y / 250)
		var cols = int(mouse_copy.position.x / 250)
		check_neighbours(rows, cols)
		if tiles == solved:
			print("You win")
			$DoorSprite.play("Open")
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file(Scene_2.resource_path)

func check_neighbours(rows, cols):
	var empty = false
	var done = false
	var pos = rows * 3 + cols
	while !empty and !done:
		var new_pos = tiles[pos].position
		if rows < 2:
			new_pos.y += 250
			empty = find_empty(new_pos, pos)
			new_pos.y -= 250
		if rows > 0:
			new_pos.y -= 250
			empty = find_empty(new_pos, pos)
			new_pos.y += 250
		if cols < 2:
			new_pos.x += 250
			empty = find_empty(new_pos, pos)
			new_pos.x -= 250
		if cols > 0:
			new_pos.x -= 250
			empty = find_empty(new_pos, pos)
			new_pos.x += 250
		done = true

func find_empty(position, pos):
	var new_rows = int(position.y / 250)
	var new_cols = int(position.x / 250)
	var new_pos = new_rows * 3 + new_cols
	if tiles[new_pos] == $Puzzle9:
		swap_tiles(pos, new_pos)
		return true
	else:
		return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		mouse = event


func _on_start_button_button_up():
	Global.hp = Global.hp - 1
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(Scene_2.resource_path)
	
