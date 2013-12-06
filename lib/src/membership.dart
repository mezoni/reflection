part of reflection;

abstract class Membership {
  TypeInfo getClass(Symbol name, [BindingFlags bindingAttr]);

  Map<Symbol, TypeInfo> getClasses([BindingFlags bindingAttr]);

  ConstructorInfo getConstructor(Symbol name, [BindingFlags bindingAttr]);

  Map<Symbol, ConstructorInfo> getConstructors([BindingFlags bindingAttr]);

  MemberInfo getMember(Symbol name, [BindingFlags bindingAttr]);

  Map<Symbol, MemberInfo> getMembers([BindingFlags bindingAttr]);

  MethodInfo getMethod(Symbol name, [BindingFlags bindingAttr]);

  Map<Symbol, MethodInfo> getMethods([BindingFlags bindingAttr]);

  Map<Symbol, PropertyInfo> getProperties([BindingFlags bindingAttr]);

  PropertyInfo getProperty(Symbol name, [BindingFlags bindingAttr]);

  Map<Symbol, VariableInfo> getVariables([BindingFlags bindingAttr]);

  VariableInfo getVariable(Symbol name, [BindingFlags bindingAttr]);
}

class _Membership {
  static TypeInfo getClass(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.GET_CLASS;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.GET_CLASS;
      bindingAttr |= BindingFlags.GET_CLASS;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, TypeInfo> getClasses(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.GET_CLASS;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.GET_CLASS;
      bindingAttr |= BindingFlags.GET_CLASS;
    }

    return new UnmodifiableMapView<Symbol, TypeInfo>(_getMembers(owner, null, bindingAttr));
  }

  static ConstructorInfo getConstructor(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
      bindingAttr |= BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, ConstructorInfo> getConstructors(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
      bindingAttr |= BindingFlags.INSTANCE | BindingFlags.GET_CONSTRUCTOR;
    }

    return new UnmodifiableMapView<Symbol, ConstructorInfo>(_getMembers(owner, null, bindingAttr));
  }

  static MemberInfo getMember(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, MemberInfo> getMembers(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC;
    }

    return new UnmodifiableMapView<Symbol, MemberInfo>(_getMembers(owner, null, bindingAttr));
  }

  static MethodInfo getMethod(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_METHOD;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_METHOD;
      bindingAttr |= BindingFlags.GET_METHOD;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, MethodInfo> getMethods(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_METHOD;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_METHOD;
      bindingAttr |= BindingFlags.GET_METHOD;
    }

    return new UnmodifiableMapView<Symbol, MethodInfo>(_getMembers(owner, null, bindingAttr));
  }

  static PropertyInfo getProperty(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_PROPERTY;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_PROPERTY;
      bindingAttr |= BindingFlags.GET_PROPERTY;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, PropertyInfo> getProperties(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_PROPERTY;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_PROPERTY;
      bindingAttr |= BindingFlags.GET_PROPERTY;
    }

    return new UnmodifiableMapView<Symbol, PropertyInfo>(_getMembers(owner, null, bindingAttr));
  }

  static VariableInfo getVariable(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_VARIABLE;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_VARIABLE;
      bindingAttr |= BindingFlags.GET_VARIABLE;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, VariableInfo> getVariables(HasMembers owner, [BindingFlags bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_VARIABLE;
    } else {
      bindingAttr &= BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.STATIC | BindingFlags.GET_VARIABLE;
      bindingAttr |= BindingFlags.GET_VARIABLE;
    }

    return new UnmodifiableMapView<Symbol, VariableInfo>(_getMembers(owner, null, bindingAttr));
  }

  static Map<Symbol, MemberInfo> _getMembers(HasMembers owner, Symbol name, [BindingFlags bindingAttr]) {
    if(owner == null) {
      throw new ArgumentError("owner: $owner");
    }

    if(bindingAttr == null) {
      bindingAttr = BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC;
    }

    if(bindingAttr & (BindingFlags.GET_CLASS | BindingFlags.GET_CONSTRUCTOR | BindingFlags.GET_METHOD | BindingFlags.GET_PROPERTY | BindingFlags.GET_VARIABLE) == 0) {
      bindingAttr |= BindingFlags.GET_CLASS | BindingFlags.GET_CONSTRUCTOR | BindingFlags.GET_METHOD | BindingFlags.GET_PROPERTY | BindingFlags.GET_VARIABLE;
    }

    LibraryInfo library;
    Map<Symbol, MemberInfo> members;
    if(owner is TypeInfo) {
      library = owner.library;
      members = new Map<Symbol, MemberInfo>();
      if((bindingAttr & BindingFlags.DECLARED_ONLY) == 0) {
        var types = new List<TypeInfo>();
        var type = owner;
        while(type != null) {
          types.add(type);
          type = type.superclass;
        }

        var length = types.length;
        for(var i = length - 1; i >= 0; i--) {
          var type = types[i];
          members.addAll(type.members);
        }
      } else {
        members = owner.members;
      }
    } else if (owner is LibraryInfo) {
      library = owner;
      members = owner.members;
    }

    if(name != null) {
      var member = members[name];
      members = new Map<Symbol, MemberInfo>();
      members[name] = member;
    }

    var result = new Map<Symbol, dynamic>();
    for(var member in members.values) {
      var accepted = false;
      switch(member.memberType) {
        case MemberTypes.CLASS:
          if((bindingAttr & BindingFlags.GET_CLASS) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags.PRIVATE) != 0) {
                accepted = true;
              }
            } else {
              if((bindingAttr & BindingFlags.PUBLIC) != 0) {
                accepted = true;
              }
            }
          }

          break;
        case MemberTypes.CONSTRUCTOR:
          if(member.owner == owner) {
            ConstructorInfo constructor = member;
            if((bindingAttr & BindingFlags.GET_CONSTRUCTOR) != 0) {
              if(constructor.isPrivate) {
                if((bindingAttr & BindingFlags.PRIVATE) != 0) {
                  accepted = true;
                }
              } else {
                if((bindingAttr & BindingFlags.PUBLIC) != 0) {
                  accepted = true;
                }
              }
            }

            if(accepted) {
              accepted = false;
              if((bindingAttr & BindingFlags.INSTANCE) != 0) {
                accepted = true;
              }
            }
          }

          break;
        case MemberTypes.METHOD:
          MethodInfo method = member;
          if((bindingAttr & BindingFlags.GET_METHOD) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(method.isStatic) {
                if((bindingAttr & BindingFlags.STATIC) != 0) {
                  if(method.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags.INSTANCE) != 0) {
                  accepted = true;
                }
              }
            }
          }

          break;
        case MemberTypes.PROPERTY:
          PropertyInfo property = member;
          if((bindingAttr & BindingFlags.GET_PROPERTY) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(property.isStatic) {
                if((bindingAttr & BindingFlags.STATIC) != 0) {
                  if(property.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags.INSTANCE) != 0) {
                  accepted = true;
                }
              }
            }
          }

          break;
        case MemberTypes.VARIABLE:
          VariableInfo variable = member;
          if((bindingAttr & BindingFlags.GET_VARIABLE) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(variable.isStatic) {
                if((bindingAttr & BindingFlags.STATIC) != 0) {
                  if(variable.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags.INSTANCE) != 0) {
                  accepted = true;
                }
              }
            }
          }

          break;
      }

      if(accepted) {
        result[member.simpleName] = member;
      }
    }

    return result;
  }
}
