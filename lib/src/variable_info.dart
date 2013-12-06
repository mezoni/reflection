part of reflection;

abstract class VariableInfo implements MemberInfo {
  bool get isConst;

  bool get isFinal;

  bool get isStatic;

  VariableMirror get mirror;

  TypeInfo get type;
}

class _VariableInfo extends _MemberInfo implements VariableInfo {
  VariableMirror _mirror;

  TypeInfo _type;

  _VariableInfo({TypeInfo declaringType, LibraryInfo library, DeclarationMirror mirror, DeclarationInfo owner}) : super (declaringType : declaringType, library : library, mirror : mirror, owner : owner) {
    if(mirror is! VariableMirror) {
      throw new ArgumentError("mirror: '$mirror' is not a 'VariableMirror'");
    }
  }

  bool get isConst => _mirror.isConst;

  bool get isFinal => _mirror.isFinal;

  bool get isStatic => _mirror.isStatic;

  MemberTypes get memberType => MemberTypes.VARIABLE;

  VariableMirror get mirror => _mirror;

  TypeInfo get type {
    if(_type == null) {
      _type = new _TypeInfo.fromMirror(_mirror.type);
    }

    return  _type;
  }
}
