class_name LuaResourceLoader
extends ResourceFormatLoader

func _get_recognized_extensions() -> PackedStringArray:
  return ["lua"]

func _handles_type(type: StringName) -> bool:
  return type == "LuaResource"

func _get_resource_type(path: String) -> String:
  if path.get_extension().to_lower() == "lua":
    return "LuaResource"
  return ""

func _load(path: String, _original_path: String, _use_sub_threads: bool, _cache_mode: int) -> Resource:
  var file: FileAccess = FileAccess.open(path, FileAccess.READ)
  if not file: return null
  var res: LuaResource = LuaResource.new()
  res.source_code = file.get_as_text()
  return res
