extends Panel

# Current button array control
enum DialogueHover {EAGER, EVEN, DISTANT}
var current_hover = 1
var hover_state = DialogueHover.EVEN

# Left/Right hold loop threshold
var press_loop = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Change hover states if Dialogue box open
	if $"../..".player_state == $"../..".PlayerStates.DIALOGUE:
		_hover_states()
	
	# Left/Right auto select on hold
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		press_loop += delta
		if press_loop > .25:
			press_loop = 0
	else:
		press_loop = 0.0

func _hover_states():
	# Left/Right hover (held)
	if Input.is_action_pressed("left") and press_loop == 0.0:
		current_hover -= 1
	if Input.is_action_pressed("right") and press_loop == 0.0:
		current_hover += 1
	
	# Left/Right hover (just pressed)
	if Input.is_action_just_pressed("left"):
		current_hover -= 1
	if Input.is_action_just_pressed("right"):
		current_hover += 1
	
	# Left/Right hover loop
	if current_hover < 0:
		current_hover = 2
	if current_hover > 2:
		current_hover = 0
	
	# Assigning input integer to enum array
	match current_hover:
		0:
			hover_state = DialogueHover.EAGER
		1:
			hover_state = DialogueHover.EVEN
		2:
			hover_state = DialogueHover.DISTANT
	
	# Applying enum array to button sizes	
	match hover_state:
		DialogueHover["EAGER"]:
			%"Button Eager".scale = Vector2(1.5,1.5)
			%"Button Even".scale = Vector2(1,1)
			%"Button Distant".scale = Vector2(1,1)
		DialogueHover["EVEN"]:
			%"Button Even".scale = Vector2(1.5,1.5)
			%"Button Eager".scale = Vector2(1,1)
			%"Button Distant".scale = Vector2(1,1)
		DialogueHover["DISTANT"]:
			%"Button Distant".scale = Vector2(1.5,1.5)
			%"Button Eager".scale = Vector2(1,1)
			%"Button Even".scale = Vector2(1,1)
