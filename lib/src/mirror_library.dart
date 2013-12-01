part of reflection;

class MirrorLibrary {
  static MethodMirror getAccessor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getAccessor(declarationMirror, name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getAccessors(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getAccessors(declarationMirror, flags : flags, inherited : inherited);
  }

  static ClassMirror getClass(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getClass(declarationMirror, name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, ClassMirror> getClasses(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getClasses(declarationMirror, flags: flags, inherited : inherited);
  }

  static MethodMirror getContructor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getContructor(declarationMirror, name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getContructors(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getContructors(declarationMirror, flags: flags, inherited : inherited);
  }

  static DeclarationMirror getMember(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true, int members : MemberTypes.DEFAULT}) {
    return MirrorDeclaration.getMember(declarationMirror, name, flags: flags, inherited : inherited, members: members);
  }

  static Map<Symbol, DeclarationMirror> getMembers(DeclarationMirror declarationMirror, {int flags : 0, bool inherited : true, int members : 0}) {
    return MirrorDeclaration.getMembers(declarationMirror, flags: flags, inherited : inherited, members: members);
  }

  static MethodMirror getMethod(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getMethod(declarationMirror, name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, MethodMirror> getMethods(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getMethods(declarationMirror, flags: flags, inherited : inherited);
  }

  static VariableMirror getVariable(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getVariable(declarationMirror, name, flags : flags, inherited : inherited);
  }

  static Map<Symbol, VariableMirror> getVariables(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return MirrorDeclaration.getVariables(declarationMirror, flags: flags, inherited : inherited);
  }
}
