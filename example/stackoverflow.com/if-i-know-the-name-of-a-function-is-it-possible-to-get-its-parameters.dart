// http://stackoverflow.com/questions/17554073/if-i-know-the-name-of-a-function-is-it-possible-to-get-its-parameters

import 'dart:mirrors';
import 'package:reflection/reflection.dart';

void hello(String name) {
    print(name);
}

void main() {
  var library = TypeHelper.getLibrary(main.runtimeType);
  var parameter = findParamater(library, #hello, #name);
  if(parameter != null) {
    print("Found parameter '${SymbolHelper.getName(parameter.simpleName)}'");
  }
}

ParameterMirror findParamater(LibraryMirror library, Symbol methodName, Symbol paramaterName) {
  var methodMirror = MirrorLibrary.getMethod(library, methodName);
  if(methodMirror is MethodMirror) {
    for(var parameter in methodMirror.parameters) {
      if(parameter.simpleName == paramaterName) {
        return parameter;
      }
    }
  }

  return null;
}
