part of reflection;

Map<Type, TypeInfo> _runtimeTypes = new HashMap<Type, TypeInfo>();

TypeInfo typeInfo(Type type) {
  if(type == null) {
    return _TypeInfo._voidInfo;
  }

  var info = _runtimeTypes[type];
  if(info != null) {
    return info;
  }

  var mirror = reflectType(type);
  info = new _TypeInfo.fromMirror(mirror, type);
  if(mirror is ClassMirror) {
    if(mirror.hasReflectedType) {
      _runtimeTypes[mirror.reflectedType] = info;
    }
  }

  return info;
}

abstract class TypeInfo implements HasMembers, MemberInfo, Membership  {
  ClassMirror get classMirror;

  int get id;

  bool get isOriginalDeclaration;

  TypeMirror get mirror;

  TypeInfo get originalDeclaration;

  Type get reflectedType;

  TypeInfo get superclass;

  List<TypeInfo> get superinterfaces;

  List<TypeInfo> get typeArguments;

  bool isA(dynamic type);

  bool isAssignableFrom(dynamic type);

  InstanceInfo newInstance([Symbol constructorName, List positionalArguments, Map<Symbol, dynamic> namedArguments]);
}

class _TypeInfo extends _MemberInfo implements TypeInfo {
  static const int _FLAG_HAS_NO_SUPERCLASS = 1;

  static const int _FLAG_HAS_NO_MEMBERS = 2;

  static TypeInfo _dynamicInfo = typeInfo(dynamic);

  static int _lastId = 0;

  static ReadOnlyDictionary<Uri, LibraryInfo> _libraries = MirrorSystemInfo.current.isolate.libraries;

  static TypeInfo _objectInfo = typeInfo(Object);

  static Map<Symbol, TypeInfo> _types = new Map<Symbol, TypeInfo>();

  static TypeInfo _voidInfo = new _TypeInfo.fromMirror(currentMirrorSystem().voidType);

  ClassMirror _classMirror;

  int _flag = 0;

  int _hashCode;

  int _id;

  bool _isOriginalDeclaration;

  LibraryInfo _library;

  ReadOnlyDictionary<Symbol, MemberInfo> _members;

  TypeMirror _mirror;

  TypeInfo _originalDeclaration;

  int _originalDeclarationId;

  Type _reflectedType;

  TypeInfo _superclass;

  List<TypeInfo> _typeArguments;

  factory _TypeInfo.fromMirror(TypeMirror mirror, [Type type]) {
    var mirrorOwner = mirror.owner;
    DeclarationInfo owner;
    LibraryInfo library;
    if(mirrorOwner is LibraryMirror) {
      library = _libraries[mirrorOwner.uri];
      _TypeInfo ti;
      if(mirror.isOriginalDeclaration) {
        ti = library.types[mirror.simpleName];
      }

      if(ti != null) {
        return ti;
      }

      owner = library;
    } else {
      var type = _types[mirror.simpleName];
      if(type != null) {
        return type;
      }
    }

    return new _TypeInfo(library : library, mirror : mirror, owner : owner, type : type);
  }

  _TypeInfo({LibraryInfo library, TypeMirror mirror, LibraryInfo owner, Type type}) : super(mirror : mirror, library : library, owner : owner) {
    if(mirror is ClassMirror) {
      _classMirror = mirror;
      if(mirror.hasReflectedType) {
        _reflectedType = _classMirror.reflectedType;
      } else {
        _reflectedType = type;
      }
    } else {
      _reflectedType = type;
    }

    _id = _lastId++;
    if(library == null) {
      _originalDeclarationId = id;
      _types[mirror.simpleName] = this;
    } else {
      if(mirror.isOriginalDeclaration) {
        _isOriginalDeclaration = true;
        _originalDeclaration = this;
        _originalDeclarationId = id;
      } else {
        var originalDeclaration = library.types[mirror.simpleName];
        if(originalDeclaration != null) {
          _isOriginalDeclaration = true;
          _originalDeclaration = originalDeclaration;
          _originalDeclarationId = originalDeclaration.id;
        } else {
          _isOriginalDeclaration = false;
        }
      }
    }
  }

  int get hashCode {
    if(_hashCode == null) {
      _hashCode = 0xeb8dc16b;
      _hashCode ^= _owner.hashCode;
      _hashCode ^= _id.hashCode;
      _hashCode &= 0x7fffffff;
    }

    return _hashCode;
  }

  ClassMirror get classMirror => _classMirror;

  int get id => _id;

  bool get isOriginalDeclaration => _isOriginalDeclaration;

  ReadOnlyDictionary<Symbol, MemberInfo> get members {
    if(_members == null && (_flag & _FLAG_HAS_NO_MEMBERS) == 0) {
      var members = new Dictionary<Symbol, MemberInfo>();
      if(_classMirror != null) {
        var originalDeclaration = this.originalDeclaration;
        for(var mirror in _classMirror.declarations.values) {
          MemberInfo member;
          var unsupported = false;
          if(mirror is MethodMirror) {
            member = new _MethodBase.fromMirror(mirror);
          } else if(mirror is ParameterMirror) {
            unsupported = true;
          } else if(mirror is VariableMirror) {
            member = new _VariableInfo(declaringType: originalDeclaration, library: library, mirror: mirror, owner : this);
          } else {
            unsupported = true;
          }

          if(unsupported) {
            // throw new StateError("Unsupported declaration type '${mirror.runtimeType}'");
          } else {
            members[member.simpleName] = member;
          }
        }
      } else {
        _flag |= _FLAG_HAS_NO_MEMBERS;
      }

      _members = new ReadOnlyDictionary(members);
    }

    return _members;
  }

  MemberTypes get memberType => MemberTypes.CLASS;

  Type get reflectedType => _reflectedType;

  TypeInfo get originalDeclaration => _originalDeclaration;

  TypeMirror get typeMirror => _mirror;

  TypeInfo get superclass {
    if(_superclass == null && (_flag & _FLAG_HAS_NO_SUPERCLASS) == 0) {
      if(_classMirror != null) {
        var superclass = _classMirror.superclass;
        if(superclass != null) {
          _superclass = typeInfo(superclass.reflectedType);
        } else {
          _flag |= _FLAG_HAS_NO_SUPERCLASS;
        }
      } else {
        _flag |= _FLAG_HAS_NO_SUPERCLASS;
      }
    }

    return _superclass;
  }

  List<TypeInfo> get superinterfaces {
    if(_typeArguments == null) {
      var superinterfaces = new List<TypeInfo>();
      if(_classMirror != null) {
        for(ClassMirror type in _classMirror.superinterfaces) {
          superinterfaces.add(typeInfo(type.reflectedType));
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

  bool operator== (other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is TypeInfo) {
      if(hashCode == other.hashCode) {
        return owner == other.owner && id == other.id;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  TypeInfo getClass(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getClass(this, name, bindingAttr);
  }

  Dictionary<Symbol, TypeInfo> getClasses([BindingFlags bindingAttr]) {
    return _Membership.getClasses(this, bindingAttr);
  }

  ConstructorInfo getConstructor(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getConstructor(this, name, bindingAttr);
  }

  Dictionary<Symbol, ConstructorInfo> getConstructors([BindingFlags bindingAttr]) {
    return _Membership.getConstructors(this, bindingAttr);
  }

  MemberInfo getMember(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getMember(this, name, bindingAttr);
  }

  Dictionary<Symbol, MemberInfo> getMembers([BindingFlags bindingAttr]) {
    return _Membership.getMembers(this, bindingAttr);
  }

  MethodInfo getMethod(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getMethod(this, name, bindingAttr);
  }

  Dictionary<Symbol, MethodInfo> getMethods([BindingFlags bindingAttr]) {
    return _Membership.getMethods(this, bindingAttr);
  }

  Dictionary<Symbol, PropertyInfo> getProperties([BindingFlags bindingAttr]) {
    return _Membership.getProperties(this, bindingAttr);
  }

  PropertyInfo getProperty(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getProperty(this, name, bindingAttr);
  }

  Dictionary<Symbol, VariableInfo> getVariables([BindingFlags bindingAttr]) {
    return _Membership.getVariables(this, bindingAttr);
  }

  VariableInfo getVariable(Symbol name, [BindingFlags bindingAttr]) {
    return _Membership.getVariable(this, name, bindingAttr);
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

  InstanceInfo newInstance([Symbol constructorName, List positionalArguments, Map<Symbol, dynamic> namedArguments]) {
    if(constructorName == null) {
      constructorName = const Symbol("");
    }

    if(positionalArguments == null) {
      positionalArguments = [];
    }

    if(_classMirror != null) {
      return new _InstanceInfo(mirror : _classMirror.newInstance(constructorName, positionalArguments, namedArguments));
    } else {
      throw new StateError("The '$reflectedType' is not a class");
    }
  }

  bool _isAssignableFrom(TypeInfo type) {
    if(_id == _objectInfo.id || _id == _dynamicInfo.id) {
      return true;
    }

    if(type.originalDeclaration != null && type.originalDeclaration.id == _originalDeclarationId) {
      if(type.id == _id) {
        return true;
      }

      // 'this' is original declaration for 'type'
      if(id == _originalDeclarationId) {
        return true;
      }

      var typeArguments = type.typeArguments;
      var thisArguments = this.typeArguments;
      var length1 = typeArguments.length;
      var length2 = thisArguments.length;
      if(length1 != length2) {
        return false;
      }

      if(length1 == 0) {
        return true;
      }

      var result = true;
      for(var i = 0; i < length1; i++) {
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
