#include <gdnative/gdnative.h>
#include <gdnative_api_struct.gen.h>

#include <math.h>

const godot_gdnative_core_api_struct *api = NULL;
const godot_gdnative_ext_nativescript_api_struct *nativescript_api = NULL;

// These are forward declarations for the functions we'll be implementing
// for our object. A constructor and destructor are both necessary.
GDCALLINGCONV void *simple_constructor(godot_object *p_instance, void *p_method_data);
GDCALLINGCONV void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data);
godot_variant create_circle(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args);


#define FIELD_WIDTH 21
#define FIELD_HEIGHT 21

#define CIRCLE_CENTER_X 11
#define CIRCLE_CENTER_Y 11
#define CIRCLE_RADIUS 5

void GDN_EXPORT godot_gdnative_init(godot_gdnative_init_options *p_options)
{
    api = p_options->api_struct;

    // Find NativeScript extensions.
    for (int i = 0; i < api->num_extensions; i++) {
        switch (api->extensions[i]->type) {
            case GDNATIVE_EXT_NATIVESCRIPT: {
                nativescript_api = (godot_gdnative_ext_nativescript_api_struct *)api->extensions[i];
            }; break;
            default:
                break;
        };
    };
}

void GDN_EXPORT godot_gdnative_terminate(godot_gdnative_terminate_options *p_options) {
    api = NULL;
    nativescript_api = NULL;
}


void GDN_EXPORT godot_nativescript_init(void *p_handle) {
    godot_instance_create_func create = { NULL, NULL, NULL };
    create.create_func = &simple_constructor;

    godot_instance_destroy_func destroy = { NULL, NULL, NULL };
    destroy.destroy_func = &simple_destructor;

    // We first tell the engine which classes are implemented by calling this.
    // * The first parameter here is the handle pointer given to us.
    // * The second is the name of our object class.
    // * The third is the type of object in Godot that we 'inherit' from;
    //   this is not true inheritance but it's close enough.
    // * Finally, the fourth and fifth parameters are descriptions
    //   for our constructor and destructor, respectively.
    nativescript_api->godot_nativescript_register_class(p_handle, "ADDER", "Reference", create, destroy);

    godot_instance_method get_data = { NULL, NULL, NULL };
    get_data.method = &create_circle;

    godot_method_attributes attributes = { GODOT_METHOD_RPC_MODE_DISABLED };

    // We then tell Godot about our methods by calling this for each
    // method of our class. In our case, this is just `get_data`.
    // * Our first parameter is yet again our handle pointer.
    // * The second is again the name of the object class we're registering.
    // * The third is the name of our function as it will be known to GDScript.
    // * The fourth is our attributes setting (see godot_method_rpc_mode enum in
    //   `godot_headers/nativescript/godot_nativescript.h` for possible values).
    // * The fifth and final parameter is a description of which function
    //   to call when the method gets called.
    nativescript_api->godot_nativescript_register_method(p_handle, "ADDER", "create_circle", attributes, get_data);
}


GDCALLINGCONV void *simple_constructor(godot_object *p_instance, void *p_method_data) {

}

// The destructor is called when Godot is done with our
// object and we free our instances' member data.
GDCALLINGCONV void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data) {

}

int field_value(int x, int y)
{
    godot_vector2 pos;
    api->godot_vector2_new(&pos, x, y);
    
    godot_vector2 circle_center;
    api->godot_vector2_new(&circle_center, CIRCLE_CENTER_X, CIRCLE_CENTER_Y);

    godot_vector2 difference = api->godot_vector2_operator_subtract(&pos, &circle_center);
    float distance = fabs(api->godot_vector2_length(&difference));

    if (distance <= CIRCLE_RADIUS / 2)
        return ' ';

    if (distance <= CIRCLE_RADIUS)
        return '/';

    return '#';  
}

godot_variant GDN_EXPORT create_circle(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args)
{
    godot_array field;
    api->godot_array_new(&field);

    api->godot_array_resize(&field, FIELD_HEIGHT);
    for (int i = 0; i < FIELD_HEIGHT; i++)
    {
        godot_array row;
        api->godot_array_new(&row);

        api->godot_array_resize(&row, FIELD_WIDTH);
        
        for (int j = 0; j < FIELD_WIDTH; j++)
        {
            godot_variant value;
            api->godot_variant_new_int(&value, field_value(i, j));

            api->godot_array_set(&row, j, &value);

            api->godot_variant_destroy(&value);
        }

        godot_variant row_variant;
        api->godot_variant_new_array(&row_variant, &row);

        api->godot_array_destroy(&row);

        api->godot_array_set(&field, i, &row_variant);
        api->godot_variant_destroy(&row_variant);
    }

    godot_variant ret;
    api->godot_variant_new_array(&ret, &field);

    api->godot_array_destroy(&field);
    return ret;
}