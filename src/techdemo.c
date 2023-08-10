#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <stdarg.h>

// #include <jni.h>
// __android_log_write(ANDROID_LOG_ERROR, "Tag", "adding");

#include "techdemo.h"

struct DartFrontend frontend = {0};

int dart_log(char *fmt, ...) {
    if (frontend.dart_print == NULL) {
      return 1;
    }

    char buffer[512];
    va_list args;
    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    va_end(args);

    return frontend.dart_print(buffer);
}

FFI_PLUGIN_EXPORT void set_dart_print_function(HelloFunc *func) {
  frontend.dart_print = func;
  dart_log("Imported dart_log function");
}

FFI_PLUGIN_EXPORT int ffi_init() {
  dart_log("Hello from C");
  dart_log("From another function");
}
