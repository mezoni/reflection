part of reflection;

abstract class LibraryInfo {
  Map<Symbol, TypeInfo> get types;

  int get id;

  IsolateInfo get isolate;

  LibraryMirror get mirror;
}

class _LibraryInfo implements LibraryInfo {
  int _id;

  IsolateInfo _isolate;

  LibraryMirror _mirror;

  Map<Symbol, TypeInfo> _types;

  _LibraryInfo({int id, IsolateInfo isolate, LibraryMirror mirror}) {
    _id = id;
    _mirror = mirror;
  }

  int get id => _id;

  IsolateInfo get isolate => _isolate;

  LibraryMirror get mirror => _mirror;

  Map<Symbol, TypeInfo> get types {
    if(_types == null) {
      _types = _reflectTypes();
    }

    return _types;
  }

  Map<Symbol, TypeInfo> _reflectTypes() {
    var types = new Map<Symbol, TypeInfo>();
    for(var declaration in _mirror.declarations.values) {
      if(declaration is TypeMirror) {
        types[declaration.simpleName] = new _TypeInfo(library : this, mirror : declaration);
      }
    }

    return new UnmodifiableMapView<Symbol, TypeInfo>(types);
  }
}

class _SpecialLibraryInfo extends _LibraryInfo {
}
