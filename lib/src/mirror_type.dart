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
    return new _TypeInfo.fromMirror(typeMirror).isA(new _TypeInfo.fromMirror(other));
  }

  static InstanceMirror newInstance(TypeMirror typeMirror, [Symbol constructorName, List positionalArguments, Map<Symbol,dynamic> namedArguments]) {
    if(typeMirror is ClassMirror) {
      return typeMirror.newInstance(constructorName, positionalArguments, namedArguments);
    } else {
      throw new StateError("'$typeMirror' is not a class");
    }
  }
}
