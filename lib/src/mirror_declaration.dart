part of reflection;

class MirrorDeclaration {
  static MethodMirror getAccessor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getAccessors(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, MethodMirror> getAccessors(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return getMembers(declarationMirror, flags : flags, inherited : inherited, members : MemberTypes.ACCESSOR);
  }

  static ClassMirror getClass(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getClasses(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, ClassMirror> getClasses(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.CLASS);
  }

  static MethodMirror getContructor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getContructors(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, MethodMirror> getContructors(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.CONSTRUCTOR);
  }

  static DeclarationMirror getMember(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true, int members : MemberTypes.DEFAULT}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: members)[name];
  }

  static Map<Symbol, DeclarationMirror> getMembers(DeclarationMirror declarationMirror, {int flags : 0, bool inherited : true, int members : 0}) {
    if(declarationMirror == null) {
      throw new ArgumentError("declarationMirror: $declarationMirror");
    }

    if(flags == null) {
      throw new ArgumentError("flags: $flags");
    }

    if(inherited == null) {
      throw new ArgumentError("inherited: $inherited");
    }

    if(members == null) {
      throw new ArgumentError("memberTypes: $members");
    }

    var declarations = new List<Map<Symbol, DeclarationMirror>>();
    var result = new Map<Symbol, dynamic>();
    LibraryMirror library;
    if(declarationMirror is LibraryMirror) {
      declarations.add(declarationMirror.declarations);
      library = declarationMirror;
    } else if(declarationMirror is ClassMirror) {
      ClassMirror classMirror = declarationMirror;
      library = classMirror.owner;
      if(inherited) {
        while(true) {
          declarations.add(classMirror.declarations);
          classMirror = classMirror.superclass;
          if(classMirror == null) {
            break;
          }
        }
      } else {
        declarations.add(classMirror.declarations);
      }
    }

    if(declarations.isEmpty) {
      return result;
    }

    if((flags & (BindingFlags.INSTANCE | BindingFlags.STATIC)) == 0) {
      flags |= BindingFlags.INSTANCE | BindingFlags.STATIC;
    }

    if((flags & (BindingFlags.PUBLIC | BindingFlags.PRIVATE)) == 0) {
      flags |= BindingFlags.PUBLIC | BindingFlags.PRIVATE;
    }

    if(members == MemberTypes.DEFAULT) {
      members = MemberTypes.ALL;
    }

    for(var level = declarations.length - 1; level >= 0; level--) {
      for(DeclarationMirror declaration in declarations[level].values) {
        var expectedFlags = flags;
        var currentFlags = 0;
        var member = 0;
        bool owned;
        if(declaration.owner == library) {
          owned = true;
        } else if(declaration.owner != null && declaration.owner.owner == library) {
          owned = true;
        } else {
          owned = false;
        }

        if(declaration.isPrivate) {
          if(owned) {
            currentFlags |= BindingFlags.PRIVATE;
            expectedFlags &= ~BindingFlags.PUBLIC;
          } else {
            continue;
          }
        } else {
          currentFlags |= BindingFlags.PUBLIC;
          expectedFlags &= ~BindingFlags.PRIVATE;
        }

        if(flags == BindingFlags.ALL && members == MemberTypes.ALL) {
          result[declaration.simpleName] = declaration;
          continue;
        }

        if(declaration is VariableMirror) {
          if(declaration.isStatic) {
            if(level == 0) {
              currentFlags |= BindingFlags.STATIC;
              expectedFlags &= ~BindingFlags.INSTANCE;
            } else {
              continue;
            }

          } else {
            currentFlags |= BindingFlags.INSTANCE;
            expectedFlags &= ~BindingFlags.STATIC;
          }

          member |= MemberTypes.VARIABLE;
        } else if(declaration is MethodMirror) {
          if(declaration.isStatic) {
            if(level == 0) {
              currentFlags |= BindingFlags.STATIC;
              expectedFlags &= ~BindingFlags.INSTANCE;
            } else {
              continue;
            }

          } else {
            currentFlags |= BindingFlags.INSTANCE;
            expectedFlags &= ~BindingFlags.STATIC;
          }

          if(declaration.isGetter || declaration.isSetter) {
            member |= MemberTypes.ACCESSOR;
          } else if(declaration.isConstructor) {
            if(level == 0) {
              member = MemberTypes.CONSTRUCTOR;
            } else {
              continue;
            }

          } else {
            member = MemberTypes.METHOD;
          }
        } else if(declaration is ClassMirror) {
          currentFlags |= BindingFlags.STATIC;
          expectedFlags &= ~BindingFlags.INSTANCE;
          member = MemberTypes.CLASS;
        } else {
          continue;
        }

        if(expectedFlags == currentFlags && (members & member) != 0) {
          result[declaration.simpleName] = declaration;
        }
      }
    }

    return result;
  }

  static MethodMirror getMethod(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getMethods(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, MethodMirror> getMethods(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.METHOD);
  }

  static VariableMirror getVariable(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getVariables(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, VariableMirror> getVariables(DeclarationMirror declarationMirror, {int flags : BindingFlags.DEFAULT, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.VARIABLE);
  }
}
