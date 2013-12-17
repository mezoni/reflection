part of reflection;

abstract class IsolateInfo implements MirrorInfo {
  ReadOnlyDictionary<Uri, LibraryInfo> get libraries;

  LibraryInfo get rootLibrary;

  LibraryInfo getLibrary(Symbol name);

  TypeInfo getType(Symbol qualifiedName);
}

class _IsolateInfo extends _MirrorInfo implements IsolateInfo {
  ReadOnlyDictionary<Uri, LibraryInfo> _libraries;

  IsolateMirror _mirror;

  MirrorSystemInfo _mirrorSystem;

  LibraryInfo _rootLibrary;

  _IsolateInfo({IsolateMirror mirror, MirrorSystemInfo mirrorSystem}) : super(mirror : mirror) {
    if(mirrorSystem == null) {
      throw new ArgumentError("mirrorSystem: $mirrorSystem");
    }

    _mirrorSystem = mirrorSystem;
  }

  ReadOnlyDictionary<Uri, LibraryInfo> get libraries {
    if(_libraries == null) {
      var libraries = new Dictionary<Uri, LibraryInfo>();
      var id = 0;
      for(var mirror in _mirrorSystem.mirror.libraries.values) {
        var library = new _LibraryInfo(id : id++, mirror : mirror);
        libraries[mirror.uri] = library;
      }

      _libraries = new ReadOnlyDictionary(libraries);
    }

    return _libraries;
  }

  LibraryInfo get rootLibrary {
    if(_rootLibrary == null) {
      _rootLibrary = libraries[_mirror.rootLibrary.uri];
    }

    return _rootLibrary;
  }

  LibraryInfo getLibrary(Symbol name) {
    throw new UnimplementedError();
  }

  TypeInfo getType(Symbol qualifiedName) {
    throw new UnimplementedError();
  }
}
