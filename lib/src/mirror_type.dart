part of reflection;

class MirrorType {
  static Type getType(TypeMirror typeMirror) {
    if(typeMirror == null) {
      return null;
    }

    if(typeMirror is ClassMirror) {
      if(typeMirror.hasReflectedType) {
        return typeMirror.reflectedType;
      }
    }

    if(typeMirror == Reflection.mirrorSystem.dynamicType) {
      return dynamic;
    }

    return null;
  }

  static bool isA(TypeMirror typeMirror, TypeMirror other) {
    return _isA(typeMirror, other, null);
  }

  static InstanceMirror newInstance(TypeMirror typeMirror, [Symbol constructorName, List positionalArguments, Map<Symbol,dynamic> namedArguments]) {
    if(typeMirror is ClassMirror) {
      return typeMirror.newInstance(constructorName, positionalArguments, namedArguments);
    } else {
      throw new StateError("'$typeMirror' is not a class");
    }
  }

  static bool _isA(TypeMirror typeMirror, TypeMirror other, bool otherIsGeneric) {
    if(typeMirror == other || identical(other, Reflection.objectType)) {
      return true;
    } else if(other is! ClassMirror) {
      if(other == Reflection.dynamicType) {
        return true;
      }

      return false;
    } else if(typeMirror is! ClassMirror) {
      return false;
    }

    ClassMirror typeClass = typeMirror;
    ClassMirror otherClass = other;
    var typeIsGeneric = typeClass.typeVariables.length > 0;
    if(otherIsGeneric == null) {
      otherIsGeneric = otherClass.typeVariables.length > 0;
    }

    var typeOriginal = typeClass.originalDeclaration;
    var otherOriginal = otherClass.originalDeclaration;
    if(typeIsGeneric && otherIsGeneric) {
      if(typeOriginal != otherOriginal) {
        if(!_isA(typeClass, other, false)) {
          return false;
        }
      }

      var typeArguments = typeClass.typeArguments;
      var otherArguments = otherClass.typeArguments;
      var length = typeArguments.length;
      if(length != otherArguments.length) {
        return false;
      }

      for(var i = 0; i < length; i++) {
        var typeArgument = typeArguments[i];
        var otherArgument = otherArguments[i];
        if(!_isA(typeArgument, otherArgument, null)) {
          return false;
        }
      }

      return true;
    }

    if(typeOriginal == otherOriginal) {
      return true;
    }

    var typeSuperinterfaces = typeClass.superinterfaces;
    var length = typeSuperinterfaces.length;
    for(var i = 0; i < length; i++) {
      var typeSuperinterface = typeSuperinterfaces[i];
      if(_isA(typeSuperinterface, other, otherIsGeneric)) {
        return true;
      }
    }

    var typeSuperclass = typeClass.superclass;
    if(typeSuperclass == null) {
      return false;
    }

    return _isA(typeSuperclass, other, otherIsGeneric);
  }
}
