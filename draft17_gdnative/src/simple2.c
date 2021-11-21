#include <gdnative/gdnative.h>
#include <gdnative_api_struct.gen.h>


#include <math.h>
#include <stdlib.h>
#include <string.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb/stb_image_write.h>
#include <curl/curl.h>

#define FIELD_WIDTH 200
#define FIELD_HEIGHT 200

#define CIRCLE_CENTER_X 100
#define CIRCLE_CENTER_Y 100
#define CIRCLE_RADIUS 50




const godot_gdnative_core_api_struct *api = NULL;
const godot_gdnative_ext_nativescript_api_struct *nativescript_api = NULL;

// These are forward declarations for the functions we'll be implementing
// for our object. A constructor and destructor are both necessary.
GDCALLINGCONV void *simple_constructor(godot_object *p_instance, void *p_method_data);
GDCALLINGCONV void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data);
godot_variant create_circle(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args);
godot_variant libcurl_version(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args);


#define FIELD_WIDTH 200
#define FIELD_HEIGHT 200

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

    godot_instance_method get_libcurl = { NULL, NULL, NULL };
    get_libcurl.method = &libcurl_version;

    nativescript_api->godot_nativescript_register_method(p_handle, "ADDER", "libcurl_version", attributes, get_libcurl);
}



GDCALLINGCONV void *simple_constructor(godot_object *p_instance, void *p_method_data) {

}

// The destructor is called when Godot is done with our
// object and we free our instances' member data.
GDCALLINGCONV void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data) {

}

void field_value(int x, int y, uint8_t* r, uint8_t*g, uint8_t*b)
{
    godot_vector2 pos;
    api->godot_vector2_new(&pos, x, y);

    godot_vector2 circle_center;
    api->godot_vector2_new(&circle_center, CIRCLE_CENTER_X, CIRCLE_CENTER_Y);
    
    godot_vector2 difference = api->godot_vector2_operator_subtract(&pos, &circle_center);

    float distance = fabs(api->godot_vector2_length(&difference));

    if (distance <= CIRCLE_RADIUS / 2) 
    {
        *r = 255;
        *g = 0;
        *b = 255;
        return;
    }

    if (distance <= CIRCLE_RADIUS)
    {
        *r = 255;
        *g = 0;
        *b = 0;
        return;
    }

    *r = 0;
    *g = 0;
    *b = 0;
}


godot_variant GDN_EXPORT create_circle(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args)
{
    godot_variant ret;
    api->godot_variant_new_nil(&ret);
    
    uint8_t* image_data = malloc(3 * FIELD_WIDTH * FIELD_HEIGHT);

    for(int i = 0; i < FIELD_HEIGHT; i++)
    {
        for (int j = 0; j < FIELD_WIDTH; j++)
        {
            uint8_t r;
            uint8_t g;
            uint8_t b;
            field_value(i, j, &r, &g, &b);

            uint8_t *start_pixel = image_data + (FIELD_HEIGHT * 3 * i + j * 3);
            start_pixel[0] = r;
            start_pixel[1] = g;
            start_pixel[2] = b;

        }
    }
    stbi_write_png("Circle.png", FIELD_WIDTH, FIELD_HEIGHT, 3, image_data, 0);
    free(image_data);
    return ret;

}

godot_variant GDN_EXPORT libcurl_version(godot_object *p_instance, void *p_method_data, void *p_user_data, int p_num_args, godot_variant **p_args)
{
    godot_variant ret;
    char *version_string = curl_version();

    godot_string gdstring;
    api->godot_string_parse_utf8_with_len(&gdstring, version_string, strlen(version_string));

    api->godot_variant_new_string(&ret, &gdstring);
    api->godot_string_destroy(&gdstring);

    return ret;
}