extends EditorProperty

const shader :Shader= preload("res://addons/JoystickInspectorPlugin/joystick_shader.gdshader")
var rad := false
var div := 1.0
var max_val := 4.0

var prop_ctrl := ColorRect.new()
func _init(dict:={}):
	self.resized.connect(_on_resize)
	# Add the control as a direct child of EditorProperty node.
	prop_ctrl.material = ShaderMaterial.new()
	prop_ctrl.material.shader = shader
	if dict.get(&"grid",&"")==&"radial":
		rad = true
		prop_ctrl.material.set_shader_parameter(&"radial",true)
	div = maxf(0.001,dict.get(&"div",1.0))
	max_val = maxf(0.002,dict.get(&"limit",2.0)*2.)
	prop_ctrl.material.set_shader_parameter(&"limit",max_val/div/2.)
	prop_ctrl.gui_input.connect(_on_gui_input)
	add_child(prop_ctrl)
	# Make sure the control is able to retain the focus.
	add_focusable(prop_ctrl)
func _ready() -> void:
	_update_property()

func _on_gui_input(input:InputEvent):
	if input is InputEventMouse:
		if input.button_mask & MOUSE_BUTTON_MASK_LEFT:
			var ui_div := div/max_val
			var pos :Vector2= (input.position -(prop_ctrl.size/2.))*Vector2(1,-1)/prop_ctrl.size
			pos = Vector2(clamp(pos.x,-0.5,0.5),clamp(pos.y,-0.5,0.5))
			if Input.is_key_pressed(KEY_SHIFT): #magnet
				if rad:
					var l := pos.length()+ui_div/2.
					l-= fposmod(l,ui_div)
					var sg := pos.sign()#*pos.length()
					var pl := pos.length()
					var positions :PackedVector2Array= [
						(sg*Vector2.ONE).normalized(),   #diagonal
						(sg*Vector2.DOWN).normalized(),  #vertical
						(sg*Vector2.RIGHT).normalized()] #horisontal
					var new_pos = pos.normalized()*l
					for i in range(0,3):
						if pos.distance_to(positions[i]*l)<ui_div/6: new_pos = positions[i]*l; break   #dot
						if pos.distance_to(positions[i]*pl)<ui_div/6: new_pos = positions[i]*pl; break #line
					pos = new_pos
				else:
					var ui_div2 := ui_div/2.
					var b :=fposmod(pos.x,ui_div) - ui_div2
					var c :=fposmod(pos.y,ui_div) - ui_div2
					if abs(abs(b)+abs(c)-ui_div+ui_div2/8)<ui_div2/4:
						pos.x -= b-ui_div2*sign(b)
						pos.y -= c-ui_div2*sign(c)
					elif abs(b)>abs(c): pos.x -= b-ui_div2*sign(b)
					else: pos.y -= c-ui_div2*sign(c)
					pass
			#prop_ctrl.material.set_shader_parameter(&"dot_pos",pos)
			emit_changed(get_edited_property(), pos*max_val*Vector2(1,-1))
	pass

func _on_resize(): # on resize 
	var x := size.x/2.
	prop_ctrl.custom_minimum_size = Vector2(x,x)#(found no other way to resize control correctly)

func _update_property(): # update gui view
	var obj :Object= get_edited_object()
	var prop:StringName=get_edited_property()
	if obj[prop]!=null: # Yes... Sometimes Vector2 can be equal <null>
		prop_ctrl.material.set_shader_parameter(&"dot_pos",obj[prop]/max_val*Vector2(1,-1))
