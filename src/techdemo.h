#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

typedef int (HelloFunc)(char *string);

struct DartFrontend {
  HelloFunc *dart_print;
};

FFI_PLUGIN_EXPORT void set_dart_print_function(HelloFunc *func);
FFI_PLUGIN_EXPORT int ffi_init();
