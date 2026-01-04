#include "whitelist.hpp"

#include "convert_godot_lua.hpp"

using namespace godot;

namespace luagdextension {

bool filter__variant__whitelist(const Variant &variant,
                                const sol::stack_object &key) {
  if (variant.has_method(LUA_PROPERTY_LIST_NAME)) {
    Variant value = ((Variant)variant).call(LUA_PROPERTY_LIST_NAME);
    if (value.get_type() == Variant::PACKED_STRING_ARRAY) {
      return ((PackedStringArray)value).has(to_variant(key));
    }
  }
  return false;
}

} // namespace luagdextension
