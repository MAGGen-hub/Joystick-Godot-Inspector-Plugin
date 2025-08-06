extends EditorInspectorPlugin

const edt :GDScript= preload("res://addons/JoystickInspectorPlugin/joystick_property_editor.gd")
const error_msg :="Joystic creation for property \"%s\" of object \"%s\" failed with error:\n \"%s\"\n Please, provide correct hint string..."
const params :PackedStringArray=["grid","div","limit","radial","basic","keep_editor"]
var exp := Expression.new()

func _can_handle(object): return true

func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if type == TYPE_VECTOR2 && hint_type == PROPERTY_HINT_TYPE_STRING:
		if exp.parse("{%s}" % hint_string,params) != OK:
			print(error_msg % [name,object,exp.get_error_text()])
			return false
		var dict = exp.execute(params,null,false)
		if exp.has_execute_failed():
			print(error_msg % [name,object,exp.get_error_text()])
			return false
		var keep_old_controls:bool=dict.get("keep_editor",false)
		add_property_editor(name,edt.new(dict),false," " if keep_old_controls else "")
		return !keep_old_controls
	else:
		return false
