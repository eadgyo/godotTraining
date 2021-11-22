#include <gdnative/gdnative.h>
#include <gdnative_api_struct.gen.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


const godot_gdnative_core_api_struct *api = NULL;
const godot_gdnative_ext_nativescript_api_struct *nativescript_api = NULL;


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

void *adder_new(godot_object *o, void *method_data)
{
    printf("new\n");

    int *call_count = api->godot_alloc(sizeof(int));
    *call_count = 0;
    return call_count;
}

void adder_destroy(godot_object *o, void *method_data, void *user_data)
{
    int *call_count = user_data;
    api->godot_free(call_count);
}

godot_variant adder_add(godot_object *o, void *method_data, void *user_data, int num_args, godot_variant **args)
{
    printf("calling_add\n");

    int *call_count = user_data;
    (*call_count)++;
    printf("test call count %i", *call_count);

    int a = api->godot_variant_as_int(args[0]);
    int b = api->godot_variant_as_int(args[1]);

    int result = a + b;

    godot_variant res;

    api->godot_variant_new_int(&res, result);

    return res;
}

godot_variant adder_get_call_count(godot_object *o, void *method_data, void *user_data, int n, godot_variant **a)
{
    printf("call_count\n");

    int *call_count = user_data;

    godot_variant res;
    api->godot_variant_new_int(&res, *call_count);

    return res;
}

void GDN_EXPORT godot_nativescript_init(void *handle)
{
    printf("nativescript_init\n");

    godot_instance_create_func create = {};
    create.create_func = &adder_new;

    godot_instance_destroy_func destroy = {};
    destroy.destroy_func = &adder_destroy;

    nativescript_api->godot_nativescript_register_class(handle, "Adder", "Reference", create, destroy);

    {
        godot_method_attributes method_attr;
        method_attr.rpc_type = GODOT_METHOD_RPC_MODE_DISABLED;

        godot_instance_method method = {};
        method.method = &adder_add;

        nativescript_api->godot_nativescript_register_method(handle, "Adder", "add", method_attr, method);
    }

    {
        godot_method_attributes method_attr;
        method_attr.rpc_type = GODOT_METHOD_RPC_MODE_DISABLED;

        godot_instance_method method = {};
        method.method = &adder_get_call_count;

        nativescript_api->godot_nativescript_register_method(handle, "Adder", "get_call_count", method_attr, method);
    }
}
