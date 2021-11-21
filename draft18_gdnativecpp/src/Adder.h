#ifndef ADDER_H
#define ADDER_H

#include <Godot.hpp>

#include <Input.hpp>
#include <Reference.hpp>
#include <Sprite.hpp>

class Adder : public godot::Reference
{
    GODOT_CLASS(Adder, godot::Reference)

	godot::Variant data;

public:
	static void _register_methods();

	void _init();

	godot::Variant adder(godot::Variant a, godot::Variant b) const;

};

#endif  // ADDER_H