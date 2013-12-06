part of reflection;

abstract class ConstructorInfo implements MethodBase {
  Symbol get constructorName;

  bool get isConstConstructor;

  bool get isFactoryConstructor;

  bool get isGenerativeConstructor;

  bool get isRedirectingConstructor;
}

class _ConstructorInfo extends _MethodBase implements ConstructorInfo {
  _ConstructorInfo({TypeInfo declaringType, DeclarationMirror mirror, LibraryInfo library, DeclarationInfo owner}) : super(declaringType : declaringType, mirror : mirror, owner : owner) {
    if(!_mirror.isConstructor) {
      throw new ArgumentError("mirror: '$mirror' is not a constructor");
    }
  }

  Symbol get constructorName => _mirror.constructorName;

  bool get isConstConstructor => _mirror.isConstConstructor;

  bool get isFactoryConstructor => _mirror.isFactoryConstructor;

  bool get isGenerativeConstructor => _mirror.isGenerativeConstructor;

  bool get isRedirectingConstructor => _mirror.isRedirectingConstructor;

  MemberTypes2 get memberType => MemberTypes2.CONSTRUCTOR;
}
