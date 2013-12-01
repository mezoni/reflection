part of reflection;

class TypeHelper {
  static MethodMirror getAccessor(Type type, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getAccessor(getTypeMirror(type), name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getAccessors(Type type, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getAccessors(getTypeMirror(type), flags : flags, inherited : inherited);
  }

  static MethodMirror getContructor(Type type, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getContructor(getTypeMirror(type), name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getContructors(Type type, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getContructors(getTypeMirror(type), flags: flags, inherited : inherited);
  }

  static LibraryMirror getLibrary(Type type) {
    return getTypeMirror(type).owner;
  }

  static DeclarationMirror getMember(Type type, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true, int types : MemberTypes.DEFAULT}) {
    return MirrorDeclaration.getMember(getTypeMirror(type), name, flags: flags, inherited : inherited);
  }

  static Map<Symbol, DeclarationMirror> getMembers(Type type, {int flags : BindingFlags.DEFAULT, bool inherited : true, int members : MemberTypes.DEFAULT}) {
    return MirrorDeclaration.getMembers(getTypeMirror(type), flags: flags, inherited: inherited, members: members);
  }

  static MethodMirror getMethod(Type type, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getMethod(getTypeMirror(type), name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getMethods(Type type, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getMethods(getTypeMirror(type), flags: flags, inherited : inherited);
  }

  static Symbol getQualifiedName(Type type) {
    return getTypeMirror(type).qualifiedName;
  }

  static Symbol getSimpleName(Type type) {
    return getTypeMirror(type).simpleName;
  }

  static TypeMirror getTypeMirror(Type type) {
    if(type == null) {
      return Reflection.mirrorSystem.voidType;
    } else if(type == dynamic) {
      return Reflection.mirrorSystem.dynamicType;
    }

    return reflectType(type);
  }

  static VariableMirror getVariable(Type type, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getVariable(getTypeMirror(type), name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, VariableMirror> getVariables(Type type, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getVariables(getTypeMirror(type), flags: flags, inherited : inherited);
  }

  static bool isA(Type type, Type other) {
    return MirrorType.isA(getTypeMirror(type), getTypeMirror(other));
  }

  static dynamic newInstance(Type type, [Symbol constructorName, List positionalArguments, Map<Symbol,dynamic> namedArguments]) {
    if(type == null) {
      throw new ArgumentError("type: $type");
    }

    var typeMirror = getTypeMirror(type);
    if(constructorName == null) {
      constructorName = const Symbol("");
    }

    if(positionalArguments == null) {
      positionalArguments = [];
    }

    return MirrorType.newInstance(typeMirror, constructorName, positionalArguments, namedArguments).reflectee;
  }
}
