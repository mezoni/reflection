part of reflection;

class Reflection {
  static final TypeMirror _dynamicType = mirrorSystem.dynamicType;

  static final mirrorSystem = currentMirrorSystem();

  static final ClassMirror _objectType = reflectClass(Object);

  static final TypeMirror _voidType = mirrorSystem.voidType;

  static TypeMirror get dynamicType {
    return _dynamicType;
  }

  static IsolateMirror get isolate {
    return mirrorSystem.isolate;
  }

  static ClassMirror get objectType {
    return _objectType;
  }

  static TypeMirror get voidType {
    return _voidType;
  }

  static Map<Uri, LibraryMirror> getLibraries() {
    return mirrorSystem.libraries;
  }
}
