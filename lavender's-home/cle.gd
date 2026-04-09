extends Node2D
var num = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.took_stairs or Global.took_door or Global.loading:
		visible = true
		num+=delta*2
	else:
		visible = false
	$Sprite2D.texture = load("res://images/load"+str(floori(num)%4)+".png")
	$RichTextLabel.text = ([["Loading","Carregando","𐑤𐑴𐑛𐑦𐑙"],["Loading.","Carregando.","𐑤𐑴𐑛𐑦𐑙."],["Loading..","Carregando..","𐑤𐑴𐑛𐑦𐑙.."],["Loading...","Carregando...","𐑤𐑴𐑛𐑦𐑙..."]])[floori(num)%4][Global.lang]
