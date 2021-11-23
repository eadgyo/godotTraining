 #include "Player.h"
void Player::_init()
{
      
}


void Player::_ready()
{

    std::cout << "ready" << std::endl;
    _sprite = get_node<godot::Sprite>("Sprite");
    _input = godot::Input::get_singleton();
    _timer = get_node<godot::Timer>("Timer");
}


void Player::_process(const double p_delta)
{
    godot::Vector2 vector(0, 0);
    vector.x = speed;
    
    godot::Vector2 position = get_position();
    position.x += vector.x * p_delta;//godot::Math::clamp<real_t>(vector.x * p_delta, 0.0f, 100000.0f);

    set_position(position);
}

void Player::start(const godot::Vector2 p_position)
{
	set_position(p_position);
}

void Player::_on_timer_finished()
{
    std::cout << "Finished timer" << std::endl;
    emit_signal("test");
}


void Player::_register_methods()
{
    godot::register_method("_ready", &Player::_ready);
    godot::register_method("_process", &Player::_process);
    godot::register_method("start", &Player::start);
    godot::register_method("_on_timer_finished", &Player::_on_timer_finished);
    godot::register_property("speed", &Player::speed, 10.0f);
    godot::register_signal<Player>("test", godot::Dictionary());
}