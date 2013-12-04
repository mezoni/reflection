part of reflection;

Map<Type, TypeInfo> _runtimeTypes = new HashMap<Type, TypeInfo>();

Map<TypeMirror, TypeInfo> _typeMirrors = new HashMap<TypeMirror, TypeInfo>();

TypeInfo typeinfo(Type type) {
  if(type == null) {
    return _TypeInfo._voidInfo;
  }

  var info = _runtimeTypes[type];
  if(info != null) {
    return info;
  }

  var mirror = reflectType(type);
  info = new _TypeInfo.fromMirror(mirror);
  _typeMirrors[mirror] = info;
  if(mirror is ClassMirror) {
    if(mirror.hasReflectedType) {
      _runtimeTypes[mirror.reflectedType] = info;
    }
  }

  return info;
}

abstract class TypeInfo {
  ClassMirror get classMirror;

  int get id;

  bool get isOriginalDeclaration;

  LibraryInfo get library;

  int get originalId;

  TypeInfo get superclass;

  List<TypeInfo> get superinterfaces;

  TypeMirror get typeMirror;

  List<TypeInfo> get typeArguments;

  bool isA(dynamic type);

  bool isAssignableFrom(dynamic type);
}

class _TypeInfo implements TypeInfo {
  static const int _FLAG_NO_SUPERCLASS = 1;

  static TypeInfo _dynamicInfo = typeinfo(dynamic);

  static int _lastId = 0;

  static Map<Uri, LibraryInfo> _libraries = MirrorSystemInfo.current.isolate.libraries;

  static TypeInfo _objectInfo = typeinfo(Object);

  static Map<Symbol, TypeInfo> _types = new Map<Symbol, TypeInfo>();

  static TypeInfo _voidInfo = typeinfo(null);

  ClassMirror _classMirror;

  int _flag = 0;

  int _hashCode;

  int _id;

  LibraryInfo _library;

  TypeMirror _typeMirror;

  int _originalId;

  TypeInfo _superclass;

  List<TypeInfo> _typeArguments;

  factory _TypeInfo.fromMirror(TypeMirror mirror) {
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
    _typeMirror = mirror;
    if(_typeMirror is ClassMirror) {
      _classMirror = _typeMirror;
    }

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

  bool operator== (other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is TypeInfo) {
      return id == other.id;
    }

    return false;
  }

  int get hashCode {
    if(_hashCode == null) {
      _hashCode = 0xeb8dc16b;
      _hashCode ^= _id;
      _hashCode ^= _originalId;
      _hashCode &= 0x7fffffff;
    }

    return _hashCode;
  }

  ClassMirror get classMirror => _classMirror;

  int get id => _id;

  bool get isOriginalDeclaration => _id == _originalId;

  LibraryInfo get library => _library;

  TypeMirror get typeMirror => _typeMirror;

  int get originalId => _originalId;

  TypeInfo get superclass {
    if(_superclass == null && (_flag & _FLAG_NO_SUPERCLASS) == 0) {
      if(_classMirror != null) {
        var superclass = _classMirror.superclass;
        if(superclass != null) {
          _superclass = typeinfo(_classMirror.superclass.reflectedType);
        } else {
          _flag |= _FLAG_NO_SUPERCLASS;
        }
      } else {
        _flag |= _FLAG_NO_SUPERCLASS;
      }
    }

    return _superclass;
  }

  List<TypeInfo> get superinterfaces {
    if(_typeArguments == null) {
      var superinterfaces = new List<TypeInfo>();
      if(_classMirror != null) {
        for(ClassMirror type in _classMirror.superinterfaces) {
          superinterfaces.add(typeinfo(type.reflectedType));
        }
      }

      _typeArguments = new UnmodifiableListView<TypeInfo>(superinterfaces);
    }

    return _typeArguments;
  }

  List<TypeInfo> get typeArguments {
    if(_typeArguments == null) {
      var typeArguments = new List<TypeInfo>();
      if(_classMirror != null) {
        for(var type in _classMirror.typeArguments) {
          typeArguments.add(new _TypeInfo.fromMirror(type));
        }
      }

      _typeArguments = new UnmodifiableListView<TypeInfo>(typeArguments);
    }

    return _typeArguments;
  }

  bool isA(TypeInfo type) {
    return type.isAssignableFrom(this);
  }

  bool isAssignableFrom(TypeInfo type) {
    if(type == null) {
      throw new ArgumentError("type: $type");
    }

    return _isAssignableFrom(type);
  }

  String toString() => _typeMirror.toString();

  bool _isAssignableFrom(TypeInfo type) {
    if(_id == _objectInfo.id || _id == _dynamicInfo.id) {
      return true;
    }

    if(type.originalId == _originalId && _originalId != -1) {
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
      if(_isAssignableFrom(superinterface)) {
        return true;
      }
    }

    var superclass = type.superclass;
    if(superclass == null) {
      return false;
    }

    return _isAssignableFrom(superclass);
  }
}
