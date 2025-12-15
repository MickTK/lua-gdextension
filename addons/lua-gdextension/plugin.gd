@tool
extends EditorPlugin

var inspector_plugin: LuaInspector = LuaInspector.new()

func _enter_tree() -> void:
  add_inspector_plugin(inspector_plugin)

func _exit_tree() -> void:
  remove_inspector_plugin(inspector_plugin)

class LuaInspector extends EditorInspectorPlugin:
  func can_handle(object: Object) -> bool:
    return object is LuaResource

  func parse_property(_object: Object, _type: Variant.Type, name: String, _hint_type: PropertyHint, _hint_string: String, _usage_flags: int, _wide: bool) -> bool:
    if name == "source_code":
      add_property_editor(name, TextEdit.new())
      return true
    return false
