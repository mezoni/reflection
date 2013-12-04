part of reflection;

abstract class IsolateInfo {
  Map<Uri, LibraryInfo> get libraries;
}

class _IsolateInfo implements IsolateInfo {
  Map<Uri, LibraryInfo> _libraries;

  MirrorSystemInfo _reflection;

  _IsolateInfo({MirrorSystemInfo reflection}) {
    _reflection = reflection;
  }

  Map<Uri, LibraryInfo> get libraries {
    if(_libraries == null) {
      _libraries = _reflectLibraries();
    }

    return _libraries;
  }

  Map<Uri, LibraryInfo> _reflectLibraries() {
    var libraries = new Map<Uri, LibraryInfo>();
    libraries[null] = new _LibraryInfo(id : 0);
    var id = 1;
    for(var declaration in _reflection.mirror.libraries.values) {
      var library = new _LibraryInfo(id : id++, mirror : declaration);
      libraries[declaration.uri] = library;
    }

    return new UnmodifiableMapView<Uri, LibraryInfo>(libraries);
  }

  LibraryInfo _reflectNullLibrary() {
    var library = new _LibraryInfo(id : 0);
  }
}
