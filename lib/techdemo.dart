library Backend;

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:developer';
import 'package:ffi/ffi.dart';
import 'techdemo_bindings_generated.dart';

const String _libName = 'techdemo';

final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final TechdemoBindings _bindings = TechdemoBindings(_dylib);

typedef int DebugPrintFunction(String arg);
DebugPrintFunction ?_global_debug_print;

class Backend {
  static int callback(Pointer<Char> ptr) {
    _global_debug_print?.call(ptr.cast<Utf8>().toDartString());
    return 0;
  }

  static set global_debug_print(x) {
    _global_debug_print = x;
  }

  static int init() {
    const except = -1;
    _bindings.set_dart_print_function(Pointer.fromFunction(Backend.callback, except));
    return 0;
  }

  static void test() {
    _bindings.ffi_init();
  }
}
