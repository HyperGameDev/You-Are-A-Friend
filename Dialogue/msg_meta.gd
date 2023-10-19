extends Panel

# Current button array control
enum Msg_Meta_Hover {POSITIVE, NEUTRAL, NEGATIVE}
var msg_meta_hover = 1
var msg_meta_hover_state = Msg_Meta_Hover.NEUTRAL

# Left/Right hold loop threshold
var press_loop = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Change hover states if Dialogue box open
	if $"..".dialogue_open == true:
		_hover_states()
	
	# Left/Right auto select on hold
	if Input.is_action_pressed("forward") or Input.is_action_pressed("backward"):
		press_loop += delta
		if press_loop > .25:
			press_loop = 0
	else:
		press_loop = 0.0
		
	# Toggle menu button on activate	
	if msg_meta_hover == 0 and Input.is_action_pressed("activate"):
		pass

func _hover_states():
	# Left/Right hover (held)
	if Input.is_action_pressed("forward") and press_loop == 0.0:
		msg_meta_hover -= 1
	if Input.is_action_pressed("backward") and press_loop == 0.0:
		msg_meta_hover += 1
	
	# Left/Right hover loop
	if msg_meta_hover < 0:
		msg_meta_hover = 2
	if msg_meta_hover > 2:
		msg_meta_hover = 0
	
	# Assigning input integer to enum array
	match msg_meta_hover:
		0:
			msg_meta_hover_state = Msg_Meta_Hover.POSITIVE
		1:
			msg_meta_hover_state = Msg_Meta_Hover.NEUTRAL
		2:
			msg_meta_hover_state = Msg_Meta_Hover.NEGATIVE
	
	# Applying enum array to button sizes	
	match msg_meta_hover_state:
		Msg_Meta_Hover["POSITIVE"]:
			%"Button Positive".scale = Vector2(1.5,1.5)
			%"Button Neutral".scale = Vector2(1,1)
			%"Button Negative".scale = Vector2(1,1)
			%"Meta Responses".position.x = %"Button Positive".global_position.x - 65
		Msg_Meta_Hover["NEUTRAL"]:
			%"Button Positive".scale = Vector2(1,1)
			%"Button Neutral".scale = Vector2(1.5,1.5)
			%"Button Negative".scale = Vector2(1,1)
			%"Meta Responses".position.x = %"Button Neutral".global_position.x - 65
		Msg_Meta_Hover["NEGATIVE"]:
			%"Button Positive".scale = Vector2(1,1)
			%"Button Neutral".scale = Vector2(1,1)
			%"Button Negative".scale = Vector2(1.5,1.5)
			%"Meta Responses".position.x = %"Button Negative".global_position.x - 65
