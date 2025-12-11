![Godot version](https://badgen.net/badge/Godot/4.5.1/blue)
[![Build and Test workflow](https://github.com/MickTK/lua-gdextension/actions/workflows/build.yml/badge.svg)](https://github.com/MickTK/lua-gdextension/actions/workflows/build.yml)

# Lua GDExtension Sandbox
This project is a fork of [lua-gdextension](https://github.com/gilzoide/lua-gdextension) focused on providing an improved and safer sandboxed Lua environment.

Currently, the extension still contains several legacy features from the original project, including the option to use Lua instead of GDScript, but these will be removed in future releases.

# Getting started

## Expose a GDScript class in Lua
Any Variant can be exposed (also the built-ins classes) with the properties hidden by default.

To expose the properties, the class shall implement a **static function** named **_lua_property_list**.

```gdscript
# GDScript exposed class example
class_name MyClass

static func _lua_property_list() -> Array[StringName]:
  return [
    "new", # exposes the constructor
    "my_value",
    "hello"
  ]

var _secret = "ciao"
var my_value = 123
func _foo() -> void: print("nope")
func hello() -> void: print("Hello")
```

```gdscript
# Initialize and run a sandbox environment

var lua := LuaState.new()
var lua_script: String = ... # see the example below

func _ready() -> void:
  lua.open_libraries(LuaState.GODOT_VARIANT) # required for any variant
  lua.globals.clear() # removes built-in classes from the scope
  lua.globals.print = func(msg: Variant) -> void: print(str(msg))
  lua.globals.MyClass = MyClass

  var result = lua.do_string(lua_script)
  if result is LuaError:
    printerr("Error in Lua code: ", result)
  else:
    print(result) # 0
```

```lua
-- Lua script example

local my_instance = MyClass:new()

print(my_instance.my_value) -- 123
my_instance.my_value = 200
print(my_instance.my_value) -- 200

my_instance:hello() -- prints "Hello"

print(my_instance._secret) -- Nil
print(my_instance._foo) -- Nil

return 0
```

# Build
Simply run `scons` in the root folder.

For more informations visit: [Godot Engine - Compiling the plugin](https://docs.godotengine.org/en/stable/tutorials/scripting/cpp/gdextension_cpp_example.html#compiling-the-plugin).

# Releases
As in the original repository, builds are automated and can be found in the [Actions](https://github.com/MickTK/lua-gdextension/actions/workflows/build.yml) section.

If you encounter any issues, you can follow these [instructions](https://github.com/gilzoide/lua-gdextension/discussions/15). Make sure to download the extension from this repository.
