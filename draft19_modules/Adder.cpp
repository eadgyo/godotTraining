#include "Adder.h"

void Adder::_bind_methods() 
{
    ClassDB::bind_method(D_METHOD("add", "a", "b"), &Adder::add);

    ClassDB::bind_method(D_METHOD("get_call_count"), &Adder::get_call_count);
}

int Adder::add(int a, int b)
{
    call_count++;
    return a + b;
}

int Adder::get_call_count()
{
    return call_count;
}