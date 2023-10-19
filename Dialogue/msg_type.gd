extends Panel

# Current button array control
enum Msg_Meta_Hover {EAGER, EVEN, DISTANT}
var msg_type_hover = 1
var msg_type_hover_state = Msg_Meta_Hover.EVEN

var dialogue_open = false

# Left/Right hold loop threshold
var press_loop = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	# Disallow hover states if Dialogue box is closed
	if $"../..".player_state == $"../..".PlayerStates.NORMAL:
		dialogue_open = false
	
	# Allow changing hover states if Dialogue box open
	if $"../..".player_state == $"../..".PlayerStates.DIALOGUE:
		_hover_states()
		dialogue_open = true
	
	# Left/Right auto select on hold
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		press_loop += delta
		if press_loop > .25:
			press_loop = 0
	else:
		press_loop = 0.0
		
	# Toggle menu button on activate	
	if msg_type_hover == 0 and Input.is_action_pressed("activate"):
		pass

func _hover_states():
	# Left/Right hover (held)
	if Input.is_action_pressed("left") and press_loop == 0.0:
		msg_type_hover -= 1
	if Input.is_action_pressed("right") and press_loop == 0.0:
		msg_type_hover += 1
	
	# Left/Right hover loop
	if msg_type_hover < 0:
		msg_type_hover = 2
	if msg_type_hover > 2:
		msg_type_hover = 0
	
	# Assigning input integer to enum array
	match msg_type_hover:
		0:
			msg_type_hover_state = Msg_Meta_Hover.EAGER
		1:
			msg_type_hover_state = Msg_Meta_Hover.EVEN
		2:
			msg_type_hover_state = Msg_Meta_Hover.DISTANT
	
	# Applying enum array to button sizes	
	match msg_type_hover_state:
		Msg_Meta_Hover["EAGER"]:
			%"Button Eager".scale = Vector2(1.5,1.5)
			%"Button Even".scale = Vector2(1,1)
			%"Button Distant".scale = Vector2(1,1)
#			%"Meta Responses".position.x = %"Button Eager".global_position.x - 65
		Msg_Meta_Hover["EVEN"]:
			%"Button Eager".scale = Vector2(1,1)
			%"Button Even".scale = Vector2(1.5,1.5)
			%"Button Distant".scale = Vector2(1,1)
#			%"Meta Responses".position.x = %"Button Even".global_position.x - 65
		Msg_Meta_Hover["DISTANT"]:
			%"Button Eager".scale = Vector2(1,1)
			%"Button Even".scale = Vector2(1,1)
			%"Button Distant".scale = Vector2(1.5,1.5)
#			%"Meta Responses".position.x = %"Button Distant".global_position.x - 65
