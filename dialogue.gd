extends Panel

enum DialogueHover {EAGER, EVEN, DISTANT}
var current_hover = 1
var hover_state = DialogueHover.EVEN


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(DialogueHover["DISTANT"])
	if $"../..".player_state == $"../..".PlayerStates.DIALOGUE:
		if Input.is_action_just_pressed("left"):
			pass
		_hover_states()

func _hover_states():
	match current_hover:
		0:
			hover_state = DialogueHover["EAGER"]
		1:
			hover_state = DialogueHover["EVEN"]
		2:
			hover_state = DialogueHover["DISTANT"]
				
	match hover_state:
		DialogueHover["EAGER"]:
			%"Button Eager".scale = Vector2(1.5,1.5)
		DialogueHover["EVEN"]:
			%"Button Even".scale = Vector2(1.5,1.5)
		DialogueHover["DISTANT"]:
			%"Button Distant".scale = Vector2(1.5,1.5)
