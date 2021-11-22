#include "Adder.h"

void Adder::_register_methods() {
	godot::register_method("adder", &Adder::adder);
}

void Adder::_init() {
    data = new godot::Variant(0.5f);
}


godot::Variant Adder::adder(godot::Variant a, godot::Variant b) const
{
    godot::Variant c = new godot::Variant(0.0f);

    c = (real_t)a + (real_t)b + (real_t)data;

    return c;
}
