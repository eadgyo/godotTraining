#ifndef PLAYER_H
#define PLAYER_H

#include <Sprite.hpp>
#include <Timer.hpp>
#include <Godot.hpp>
#include <Input.hpp>
#include <iostream>

class Player : public godot::Node2D
{
    GODOT_CLASS(Player, godot::Node2D)

    godot::Sprite *_sprite;
    godot::Input *_input = NULL;
    godot::Timer *_timer;

public :
    real_t speed = 50.0f;

    void _init();
    void _ready();
    void _process(const double p_delta);
    void start(const godot::Vector2 p_position);
    void _on_timer_finished();


    static void _register_methods();

};

#endif // PLAYER_H