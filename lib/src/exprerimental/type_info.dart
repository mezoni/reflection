part of reflection;

Map<Type, TypeInfo> _runtimeTypes = new Map<Type, TypeInfo>();

Map<TypeMirror, TypeInfo> _typeMirrors = new Map<TypeMirror, TypeInfo>();

TypeInfo typeinfo(dynamic type) {
  var isType = false;
  TypeInfo info;
  TypeMirror mirror;
  if(type == null) {
    return _TypeInfo._voidInfo;
  } else if(type is Type) {
    isType = true;
    info = _runtimeTypes[type];
    if(info != null) {
      return info;
    }

    mirror = reflectType(type);
  } else if(type is TypeMirror) {
    mirror = type;
    info = _typeMirrors[mirror];
  } else {
    throw new ArgumentError("type: $type");
  }

  if(info != null) {
    return info;
  }

  info = new _TypeInfo.fromTypeMirror(mirror);
  _typeMirrors[mirror] = info;
  if(mirror is ClassMirror) {
    if(mirror.hasReflectedType) {
      _runtimeTypes[mirror.reflectedType] = info;
    }
  }

  return info;
}

abstract class TypeInfo {
  int get id;

  bool get isOriginalDeclaration;

  LibraryInfo get library;

  TypeMirror get mirror;

  int get originalId;

  TypeInfo get superclass;

  List<TypeInfo> get superinterfaces;

  List<TypeInfo> get typeArguments;

  bool isA(dynamic type);

  bool isAssignableFrom(dynamic type);
}

class _TypeInfo implements TypeInfo {
  static const int _FLAG_NO_SUPERCLASS = 1;

  static TypeInfo _dynamicInfo = typeinfo(dynamic);

  static int _lastId = 0;

  static Map<Uri, LibraryInfo> _libraries = Reflection2.current.isolate.libraries;

  static TypeInfo _objectInfo = typeinfo(Object);

  static Map<Symbol, TypeInfo> _types = new Map<Symbol, TypeInfo>();

  static TypeInfo _voidInfo = typeinfo(null);

  int _flag = 0;

  int _id;

  LibraryInfo _library;

  TypeMirror _mirror;

  int _originalId;

  TypeInfo _superclass;

  List<TypeInfo> _typeArguments;

  factory _TypeInfo.fromTypeMirror(TypeMirror mirror) {
    var owner = mirror.owner;
    LibraryInfo library;
    if(owner is LibraryMirror) {
      library = _libraries[owner.uri];
      if(mirror.isOriginalDeclaration) {
        return library.types[mirror.simpleName];
      }
    } else {
      var type = _types[mirror.simpleName];
      if(type != null) {
        return type;
      }
    }

    return new _TypeInfo(library : library, mirror : mirror);
  }

  _TypeInfo({LibraryInfo library, TypeMirror mirror}) {
    _library = library;
    _mirror = mirror;
    _id = _lastId++;
    if(_library == null) {
      _originalId = id;
      _types[mirror.simpleName] = this;
    } else {
      if(mirror.isOriginalDeclaration) {
        _originalId = id;
      } else {
        var original = library.types[mirror.simpleName];
        if(original == null) {
          _originalId = -1;
        } else {
          _originalId = original.id;
        }
      }
    }
  }

  int get id => _id;

  bool get isOriginalDeclaration => _id == _originalId;

  LibraryInfo get library => _library;

  TypeMirror get mirror => _mirror;

  int get originalId => _originalId;

  TypeInfo get superclass {
    if(_superclass == null && (_flag & _FLAG_NO_SUPERCLASS) == 0) {
      ClassMirror clazz = _mirror;
      var superclass = clazz.superclass;
      if(superclass != null) {
        _superclass = typeinfo(clazz.superclass);
      } else {
        _flag |= _FLAG_NO_SUPERCLASS;
      }
    }

    return _superclass;
  }

  List<TypeInfo> get superinterfaces {
    if(_typeArguments == null) {
      var superinterfaces = new List<TypeInfo>();
      if(_mirror is ClassMirror) {
        var clazz = _mirror;
        for(var type in clazz.superinterfaces) {
          superinterfaces.add(typeinfo(type));
        }
      }

      _typeArguments = new UnmodifiableListView<TypeInfo>(superinterfaces);
    }

    return _typeArguments;
  }

  List<TypeInfo> get typeArguments {
    if(_typeArguments == null) {
      var typeArguments = new List<TypeInfo>();
      if(_mirror is ClassMirror) {
        var clazz = _mirror;
        for(var type in clazz.typeArguments) {
          typeArguments.add(typeinfo(type));
        }
      }

      _typeArguments = new UnmodifiableListView<TypeInfo>(typeArguments);
    }

    return _typeArguments;
  }

  bool isA(dynamic type) {
    if(type is! TypeInfo) {
      type = typeinfo(type);
    }

    return type.isAssignableFrom(this);
  }

  bool isAssignableFrom(type) {
    if(type is! TypeInfo) {
      type = typeinfo(type);
    }

    return _isAssignableFrom(type);
  }

  String toString() => _mirror.toString();

  bool _isAssignableFrom(_TypeInfo type) {
    if(_id == _objectInfo.id || _id == _dynamicInfo.id) {
      return true;
    }

    if(type.originalId == _originalId) {
      if(type.id == _id) {
        return true;
      }

      var typeArguments = type.typeArguments;
      var length = typeArguments.length;
      if(length == 0) {
        return true;
      }

      var thisArguments = this.typeArguments;
      var result = true;
      for(var i = 0; i < length; i++) {
        _TypeInfo argument = thisArguments[i];
        if(!argument.isAssignableFrom(typeArguments[i])) {
          result = false;
        }
      }

      if(result) {
        return true;
      }
    }

    for(var superinterface in type.superinterfaces) {
      if(isAssignableFrom(superinterface)) {
        return true;
      }
    }

    var superclass = type.superclass;
    if(superclass == null) {
      return false;
    }

    return isAssignableFrom(superclass);
  }
}
