#include "register_types.h"

#include "core/object/class_db.h"

#include "Adder.h"

void register_mymodule_types() 
{
     ClassDB::register_class<Adder>();
}

void unregister_mymodule_types()
{

}