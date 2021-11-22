#ifndef ADDER_H
#define ADDER_H

#include "core/object/ref_counted.h"

class Adder : public RefCounted 
{
    GDCLASS(Adder, RefCounted);

    int call_count = 0;

    public :
        static void _bind_methods();

        int add(int a, int b);
        int get_call_count();
};


#endif