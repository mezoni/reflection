part of reflection;

abstract class VariableInfo implements MemberInfo {
  bool get isConst;

  bool get isFinal;

  bool get isStatic;

  VariableMirror get mirror;

  TypeInfo get type;

  Object getValue([Object object]);

  void setValue(Object object, dynamic value);
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

  Object getValue([Object object]) {
    if(isStatic) {
      var mirror = owner.mirror;
      if(mirror is ObjectMirror) {
        return mirror.getField(simpleName).reflectee;
      }

    } else {
      if(object == null) {
        throw new StateError("The variable is an instance variable but 'object' is null");
      }

      var instance = objectInfo(object);
      if(owner is TypeInfo) {
        TypeInfo type = owner;
        if(!type.isAssignableFrom(instance.type)) {
          throw new StateError("The object does not match the target type");
        }
      }

      var mirror = instance.mirror;
      if(mirror is ObjectMirror) {
        return mirror.getField(simpleName).reflectee;
      }
    }

    throw new StateError("An error occurred while retrieving the variable value");
  }

  void setValue(Object object, dynamic value) {
    if(isStatic) {
      var mirror = owner.mirror;
      if(mirror is ObjectMirror) {
        mirror.setField(simpleName, value);
        return;
      }

    } else {
      if(object == null) {
        throw new StateError("The variable is an instance variable but 'object' is null");
      }

      var instance = objectInfo(object);
      if(owner is TypeInfo) {
        TypeInfo type = owner;
        if(!type.isAssignableFrom(instance.type)) {
          throw new StateError("The object does not match the target type");
        }
      }

      var mirror = instance.mirror;
      if(mirror is ObjectMirror) {
        mirror.setField(simpleName, value);
        return;
      }
    }

    throw new StateError("An error occurred while setting the variable value");
  }
}
