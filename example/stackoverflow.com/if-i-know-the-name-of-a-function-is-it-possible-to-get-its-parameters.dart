// http://stackoverflow.com/questions/17554073/if-i-know-the-name-of-a-function-is-it-possible-to-get-its-parameters

import 'package:reflection/reflection.dart';

void hello(String name) {
    print(name);
}

void main() {
  var library = MirrorSystemInfo.current.isolate.rootLibrary;
  var parameter = findParamater(library, #hello, #name);
  if(parameter != null) {
    print("Found parameter '${SymbolHelper.getName(parameter.simpleName)}'");
  }
}

ParameterInfo findParamater(LibraryInfo library, Symbol methodName, Symbol paramaterName) {
  var method = library.getMethod(methodName);
  if(method is MethodInfo) {
    for(var parameter in method.parameters) {
      if(parameter.simpleName == paramaterName) {
        return parameter;
      }
    }
  }

  return null;
}
