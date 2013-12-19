part of reflection;

abstract class MethodBase implements MemberInfo {
  MethodMirror get mirror;

  List<ParameterInfo> get parameters;

  TypeInfo get returnType;

  String get source;
}

abstract class _MethodBase extends _MemberInfo implements MethodBase {
  MethodMirror _mirror;

  static ReadOnlyDictionary<Uri, LibraryInfo> _libraries = MirrorSystemInfo.current.isolate.libraries;

  List<ParameterInfo> _parameters;

  TypeInfo _returnType;

  factory _MethodBase.fromMirror(MethodMirror mirror) {
    if(mirror == null) {
      throw new ArgumentError("mirror: $mirror");
    }

    var mirrorOwner = mirror.owner;
    LibraryInfo library;
    DeclarationInfo owner;
    TypeInfo declaringType;
    if(mirrorOwner is LibraryMirror) {
      owner = _libraries[mirrorOwner.uri];
      library = owner;
    } else if(mirrorOwner is TypeMirror) {
      TypeInfo type = new _TypeInfo.fromMirror(mirrorOwner);
      declaringType = type.originalDeclaration;
      library = declaringType.library;
      owner = type;
    }

    if(mirror.isRegularMethod) {
      return new _MethodInfo(declaringType: declaringType, mirror: mirror, library: library, owner: owner);
    } else if(mirror.isConstructor) {
      return new _ConstructorInfo(declaringType: declaringType, mirror: mirror, library: library, owner: owner);
    } else if(mirror.isGetter || mirror.isSetter) {
      return new _PropertyInfo(declaringType: declaringType, mirror: mirror, library: library, owner: owner);
    } else {
      throw new StateError("Unknown method mirror '$mirror'");
    }
  }

  _MethodBase({TypeInfo declaringType, DeclarationMirror mirror, LibraryInfo library, DeclarationInfo owner}) : super(declaringType : declaringType, mirror : mirror, owner : owner) {
    if(mirror is! MethodMirror) {
      throw new ArgumentError("mirror: '$mirror' is not a 'MethodMirror'");
    }
  }

  MethodMirror get mirror => _mirror;

  List<ParameterInfo> get parameters {
    if(_parameters == null) {
      var parameters = new List<ParameterInfo>();
      for(var mirror in _mirror.parameters) {
        parameters.add(new _ParameterInfo(library : library, mirror : mirror, owner : this));
      }

      _parameters = new UnmodifiableListView<ParameterInfo>(parameters);
    }

    return _parameters;
  }

  TypeInfo get returnType {
    if(_returnType == null) {
      _returnType = new _TypeInfo.fromMirror(_mirror.returnType);
    }

    return _returnType;
  }

  String get source => _mirror.source;
}
