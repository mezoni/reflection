part of reflection;

abstract class MethodInfo implements MethodBase {
  bool get isAbstract;

  bool get isOperator;

  bool get isStatic;
}

class _MethodInfo extends _MethodBase implements MethodInfo {
  int _hashCode;

  _MethodInfo({TypeInfo declaringType, DeclarationMirror mirror, LibraryInfo library, DeclarationInfo owner}) : super(declaringType : declaringType, mirror : mirror, owner : owner) {
    if(!_mirror.isRegularMethod) {
      throw new ArgumentError("mirror: '$mirror' is not a regular method");
    }
  }

  bool get isAbstract => _mirror.isAbstract;

  bool get isOperator => _mirror.isOperator;

  bool get isStatic => _mirror.isStatic;

  MemberTypes get memberType => MemberTypes.METHOD;
}
