part of reflection;

class Reflection {
  static final mirrorSystem = currentMirrorSystem();

  static DeclarationMirror getAccessor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getAccessors(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> getAccessors(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(flags == null) {
      throw new ArgumentError("bindingFlags: $flags");
    }

    return getMembers(declarationMirror, flags : flags, inherited : inherited, members : MemberTypes.ACCESSOR);
  }

  static DeclarationMirror getClass(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getClasses(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> getClasses(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.CLASS);
  }

  static DeclarationMirror getContructor(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getContructors(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> getContructors(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.CONSTRUCTOR);
  }

  static Map<Uri, LibraryMirror> getLibraries() {
    return mirrorSystem.libraries;
  }

  static DeclarationMirror getMember(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true, int types : MemberTypes.ALL}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: types)[name];
  }

  static Map<Symbol, DeclarationMirror> getMembers(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true, int members : MemberTypes.ALL}) {
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
    var result = new Map<Symbol, DeclarationMirror>();
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

    for(var level = declarations.length - 1; level >= 0; level--) {
      for(DeclarationMirror declaration in declarations[level].values) {
        var flag = 0;
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
            flag |= BindingFlags.PRIVATE;
          }
        } else {
          flag |= BindingFlags.PUBLIC;
        }

        if(!declaration.isPrivate || owned) {
          if(flags == BindingFlags.ALL && members == MemberTypes.ALL) {
            result[declaration.simpleName] = declaration;
            continue;
          }

          if(declaration is VariableMirror) {
            if(declaration.isStatic) {
              if(level == 0) {
                flag |= BindingFlags.STATIC;
              } else {
                continue;
              }

            } else {
              flag |= BindingFlags.INSTANCE;
            }

            member = MemberTypes.VARIABLE;
          } else if(declaration is MethodMirror) {
            if(declaration.isGetter || declaration.isSetter) {
              if(declaration.isStatic) {
                if(level == 0) {
                  flag |= BindingFlags.STATIC;
                } else {
                  continue;
                }

              } else {
                flag |= BindingFlags.INSTANCE;
              }

              member = MemberTypes.ACCESSOR;
            } else if(declaration.isConstructor && level == 0) {
              member = MemberTypes.CONSTRUCTOR;
            } else {
              member = MemberTypes.METHOD;
            }
          } else if(declaration is ClassMirror) {
            member = MemberTypes.CLASS;
          } else {
            continue;
          }

          if((flags & flag) != 0 && (members & member) != 0) {
            result[declaration.simpleName] = declaration;
          }
        }
      }
    }

    return result;
  }

  static DeclarationMirror getMethod(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getMethods(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> getMethods(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.METHOD);
  }

  static LibraryMirror getRootLibrary([IsolateMirror isolateMirror]) {
    if(isolateMirror == null) {
      isolateMirror = mirrorSystem.isolate;
    }

    return isolateMirror.rootLibrary;
  }

  static DeclarationMirror getVariable(DeclarationMirror declarationMirror, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return getVariables(declarationMirror, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> getVariables(DeclarationMirror declarationMirror, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return getMembers(declarationMirror, flags: flags, inherited : inherited, members: MemberTypes.VARIABLE);
  }

  static String symbolToString(Symbol symbol) {
    return MirrorSystem.getName(symbol);
  }

  static DeclarationMirror typeGetAccessor(Type type, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return typeGetAccessors(type, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> typeGetAccessors(Type type, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(flags == null) {
      throw new ArgumentError("bindingFlags: $flags");
    }

    return typeGetMembers(type, flags : flags, inherited : inherited, members : MemberTypes.ACCESSOR);
  }

  static DeclarationMirror typeGetContructor(Type type, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return typeGetContructors(type, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> typeGetContructors(Type type, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return typeGetMembers(type, flags: flags, inherited : inherited, members: MemberTypes.CONSTRUCTOR);
  }

  static LibraryMirror typeGetLibrary(Type type) {
    return typeGetTypeMirror(type).owner;
  }

  static DeclarationMirror typeGetMember(Type type, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true, int types : MemberTypes.ALL}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return typeGetMembers(type, flags: flags, inherited : inherited, members: types)[name];
  }

  static Map<Symbol, DeclarationMirror> typeGetMembers(Type type, {int flags : BindingFlags.ALL, bool inherited : true, int members : MemberTypes.ALL}) {
    return getMembers(typeGetTypeMirror(type), flags: flags, inherited: inherited, members: members);
  }

  static DeclarationMirror typeGetMethod(Type type, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return typeGetMethods(type, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> typeGetMethods(Type type, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return typeGetMembers(type, flags: flags, inherited : inherited, members: MemberTypes.METHOD);
  }

  static Symbol typeGetQualifiedName(Type type) {
    return typeGetTypeMirror(type).qualifiedName;
  }

  static Symbol typeGetSimpleName(Type type) {
    return typeGetTypeMirror(type).simpleName;
  }

  static TypeMirror typeGetTypeMirror(Type type) {
    if(type == null) {
      return mirrorSystem.voidType;
    } else if(type == dynamic) {
      return mirrorSystem.dynamicType;
    }

    return reflectType(type);
  }

  static DeclarationMirror typeGetVariable(Type type, Symbol name, {int flags : BindingFlags.ALL, bool inherited : true}) {
    if(name == null) {
      throw new ArgumentError("name: $name");
    }

    return typeGetVariables(type, flags : flags, inherited : inherited)[name];
  }

  static Map<Symbol, DeclarationMirror> typeGetVariables(Type type, {int flags : BindingFlags.ALL, bool inherited : true}) {
    return typeGetMembers(type, flags: flags, inherited : inherited, members: MemberTypes.VARIABLE);
  }

  static bool typeIs(Type type, Type other) {
    return typeMirrorIs(typeGetTypeMirror(type), typeGetTypeMirror(other));
  }

  static Type typeMirrorGetType(TypeMirror typeMirror) {
    if(typeMirror == null) {
      return null;
    }

    if(typeMirror is ClassMirror) {
      if(typeMirror.hasReflectedType) {
        return typeMirror.reflectedType;
      }
    }

    if(typeMirror == mirrorSystem.dynamicType) {
      return dynamic;
    }

    return null;
  }

  static bool typeMirrorIs(TypeMirror type, TypeMirror other) {
    return _typeMirrorIs(type, other);
  }

  static Object typeNewInstance(Type type, [Symbol constructorName, List positionalArguments, Map<Symbol,dynamic> namedArguments]) {
    if(type == null) {
      throw new ArgumentError("type: $type");
    }

    var typeMirror = typeGetTypeMirror(type);
    if(typeMirror is ClassMirror) {
      if(constructorName == null) {
        constructorName = const Symbol("");
      }

      if(positionalArguments == null) {
        positionalArguments = [];
      }

      var instance = typeMirror.newInstance(constructorName, positionalArguments, namedArguments);
      if(instance.hasReflectee) {
        return instance.reflectee;
      }

      return null;
    }

    throw new StateError("'$type' is not a class");
  }

  static bool _typeMirrorIs(TypeMirror type, TypeMirror other, {bool otherIsGeneric, _Variance variance : _Variance.COVARIANCE}) {
    if(type == other) {
      return true;
    } else if(other is! ClassMirror) {
      if(other == mirrorSystem.dynamicType) {
        return true;
      }

      return false;
    } else if(type is! ClassMirror) {
      return false;
    }

    ClassMirror typeClass = type;
    ClassMirror otherClass = other;
    var typeIsGeneric = typeClass.typeVariables.length > 0;
    if(otherIsGeneric == null) {
      otherIsGeneric = otherClass.typeVariables.length > 0;
    }

    if(!typeIsGeneric && otherIsGeneric) {
      return false;
    }

    var typeOriginal = typeClass.originalDeclaration;
    var otherOriginal = otherClass.originalDeclaration;
    if(typeIsGeneric && otherIsGeneric) {
      if(typeOriginal != otherOriginal) {
        if(!_typeMirrorIs(typeClass, other, otherIsGeneric: false)) {
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
        if(!_typeMirrorIs(typeArgument, otherArgument)) {
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
      if(_typeMirrorIs(typeSuperinterface, other, otherIsGeneric: false)) {
        return true;
      }
    }

    var typeSuperclass = typeClass.superclass;
    if(typeSuperclass == null) {
      return false;
    }

    return _typeMirrorIs(typeSuperclass, other, otherIsGeneric: false);
  }
}
