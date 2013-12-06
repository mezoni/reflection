part of reflection;

abstract class PropertyInfo implements MethodBase {
  bool get isAbstract;

  bool get isGetter;

  bool get isSetter;

  bool get isStatic;
}

class _PropertyInfo extends _MethodBase implements PropertyInfo {
  int _hashCode;

  MethodMirror _mirror;

  _PropertyInfo({TypeInfo declaringType, DeclarationMirror mirror, LibraryInfo library, DeclarationInfo owner}) : super(declaringType : declaringType, mirror : mirror, owner : owner) {
    if(!(_mirror.isGetter || _mirror.isSetter)) {
      throw new ArgumentError("mirror: '$mirror' is not a property");
    }
  }

  bool get isAbstract => _mirror.isAbstract;

  bool get isGetter => _mirror.isGetter;

  bool get isSetter => _mirror.isSetter;

  bool get isStatic => _mirror.isStatic;

  MemberTypes get memberType => MemberTypes.PROPERTY;

  MethodMirror get mirror => _mirror;
}
