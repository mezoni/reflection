part of reflection;

class Reflection {
  static final mirrorSystem = currentMirrorSystem();

  static IsolateMirror get isolate {
    return mirrorSystem.isolate;
  }

  static Map<Uri, LibraryMirror> getLibraries() {
    return mirrorSystem.libraries;
  }
}
