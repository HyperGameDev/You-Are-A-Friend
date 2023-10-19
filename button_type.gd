extends Panel

@export var button_type_label = "Label"
@export var button_type_texture = load("res://UI images/border_responses_4.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%"Type Label".text = button_type_label
