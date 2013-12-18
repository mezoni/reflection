import 'package:reflection/reflection.dart';

void main() {
  reflectLibraries();
}

void reflectLibraries() {
  var library = MirrorSystemInfo.current.isolate.rootLibrary;
  print("=========================");
  print("Libraries:");
  print(" name: ${SymbolHelper.getName(library.qualifiedName)}");
  print(" uri: ${library.uri}");

  var libraries = MirrorSystemInfo.current.isolate.libraries;
  for(var library in libraries.values) {
    print(" ------------------------");
    print(" name: ${SymbolHelper.getName(library.qualifiedName)}");
    print(" uri: ${library.uri}");
  }
}
