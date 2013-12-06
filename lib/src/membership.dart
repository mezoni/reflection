part of reflection;

abstract class Membership {
  TypeInfo getClass(Symbol name, [BindingFlags2 bindingAttr]);

  Map<Symbol, TypeInfo> getClasses([BindingFlags2 bindingAttr]);

  ConstructorInfo getConstructor(Symbol name, [BindingFlags2 bindingAttr]);

  Map<Symbol, ConstructorInfo> getConstructors([BindingFlags2 bindingAttr]);

  MemberInfo getMember(Symbol name, [BindingFlags2 bindingAttr]);

  Map<Symbol, MemberInfo> getMembers([BindingFlags2 bindingAttr]);

  MethodInfo getMethod(Symbol name, [BindingFlags2 bindingAttr]);

  Map<Symbol, MethodInfo> getMethods([BindingFlags2 bindingAttr]);

  Map<Symbol, PropertyInfo> getProperties([BindingFlags2 bindingAttr]);

  PropertyInfo getProperty(Symbol name, [BindingFlags2 bindingAttr]);

  Map<Symbol, VariableInfo> getVariables([BindingFlags2 bindingAttr]);

  VariableInfo getVariable(Symbol name, [BindingFlags2 bindingAttr]);
}

class _Membership {
  static TypeInfo getClass(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.GET_CLASS;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.GET_CLASS;
      bindingAttr |= BindingFlags2.GET_CLASS;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, TypeInfo> getClasses(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.GET_CLASS;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.GET_CLASS;
      bindingAttr |= BindingFlags2.GET_CLASS;
    }

    return new UnmodifiableMapView<Symbol, TypeInfo>(_getMembers(owner, null, bindingAttr));
  }

  static ConstructorInfo getConstructor(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
      bindingAttr |= BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, ConstructorInfo> getConstructors(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
      bindingAttr |= BindingFlags2.INSTANCE | BindingFlags2.GET_CONSTRUCTOR;
    }

    return new UnmodifiableMapView<Symbol, ConstructorInfo>(_getMembers(owner, null, bindingAttr));
  }

  static MemberInfo getMember(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, MemberInfo> getMembers(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC;
    }

    return new UnmodifiableMapView<Symbol, MemberInfo>(_getMembers(owner, null, bindingAttr));
  }

  static MethodInfo getMethod(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_METHOD;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_METHOD;
      bindingAttr |= BindingFlags2.GET_METHOD;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, MethodInfo> getMethods(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_METHOD;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_METHOD;
      bindingAttr |= BindingFlags2.GET_METHOD;
    }

    return new UnmodifiableMapView<Symbol, MethodInfo>(_getMembers(owner, null, bindingAttr));
  }

  static PropertyInfo getProperty(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_PROPERTY;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_PROPERTY;
      bindingAttr |= BindingFlags2.GET_PROPERTY;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, PropertyInfo> getProperties(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_PROPERTY;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_PROPERTY;
      bindingAttr |= BindingFlags2.GET_PROPERTY;
    }

    return new UnmodifiableMapView<Symbol, PropertyInfo>(_getMembers(owner, null, bindingAttr));
  }

  static VariableInfo getVariable(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_VARIABLE;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_VARIABLE;
      bindingAttr |= BindingFlags2.GET_VARIABLE;
    }

    return _getMembers(owner, name, bindingAttr)[name];
  }

  static Map<Symbol, VariableInfo> getVariables(HasMembers owner, [BindingFlags2 bindingAttr]) {
    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_VARIABLE;
    } else {
      bindingAttr &= BindingFlags2.PUBLIC | BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.GET_VARIABLE;
      bindingAttr |= BindingFlags2.GET_VARIABLE;
    }

    return new UnmodifiableMapView<Symbol, VariableInfo>(_getMembers(owner, null, bindingAttr));
  }

  static Map<Symbol, MemberInfo> _getMembers(HasMembers owner, Symbol name, [BindingFlags2 bindingAttr]) {
    if(owner == null) {
      throw new ArgumentError("owner: $owner");
    }

    if(bindingAttr == null) {
      bindingAttr = BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC;
    }

    if(bindingAttr & (BindingFlags2.GET_CLASS | BindingFlags2.GET_CONSTRUCTOR | BindingFlags2.GET_METHOD | BindingFlags2.GET_PROPERTY | BindingFlags2.GET_VARIABLE) == 0) {
      bindingAttr |= BindingFlags2.GET_CLASS | BindingFlags2.GET_CONSTRUCTOR | BindingFlags2.GET_METHOD | BindingFlags2.GET_PROPERTY | BindingFlags2.GET_VARIABLE;
    }

    LibraryInfo library;
    Map<Symbol, MemberInfo> members;
    if(owner is TypeInfo) {
      library = owner.library;
      members = new Map<Symbol, MemberInfo>();
      if((bindingAttr & BindingFlags2.DECLARED_ONLY) == 0) {
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
        case MemberTypes2.CLASS:
          if((bindingAttr & BindingFlags2.GET_CLASS) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags2.PRIVATE) != 0) {
                accepted = true;
              }
            } else {
              if((bindingAttr & BindingFlags2.PUBLIC) != 0) {
                accepted = true;
              }
            }
          }

          break;
        case MemberTypes2.CONSTRUCTOR:
          if(member.owner == owner) {
            ConstructorInfo constructor = member;
            if((bindingAttr & BindingFlags2.GET_CONSTRUCTOR) != 0) {
              if(constructor.isPrivate) {
                if((bindingAttr & BindingFlags2.PRIVATE) != 0) {
                  accepted = true;
                }
              } else {
                if((bindingAttr & BindingFlags2.PUBLIC) != 0) {
                  accepted = true;
                }
              }
            }

            if(accepted) {
              accepted = false;
              if((bindingAttr & BindingFlags2.INSTANCE) != 0) {
                accepted = true;
              }
            }
          }

          break;
        case MemberTypes2.METHOD:
          MethodInfo method = member;
          if((bindingAttr & BindingFlags2.GET_METHOD) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags2.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags2.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(method.isStatic) {
                if((bindingAttr & BindingFlags2.STATIC) != 0) {
                  if(method.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags2.INSTANCE) != 0) {
                  accepted = true;
                }
              }
            }
          }

          break;
        case MemberTypes2.PROPERTY:
          PropertyInfo property = member;
          if((bindingAttr & BindingFlags2.GET_PROPERTY) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags2.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags2.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(property.isStatic) {
                if((bindingAttr & BindingFlags2.STATIC) != 0) {
                  if(property.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags2.INSTANCE) != 0) {
                  accepted = true;
                }
              }
            }
          }

          break;
        case MemberTypes2.VARIABLE:
          VariableInfo variable = member;
          if((bindingAttr & BindingFlags2.GET_VARIABLE) != 0) {
            if(member.isPrivate) {
              if((bindingAttr & BindingFlags2.PRIVATE) != 0) {
                if(member.library == library) {
                  accepted = true;
                }
              }
            } else {
              if((bindingAttr & BindingFlags2.PUBLIC) != 0) {
                accepted = true;
              }
            }

            if(accepted) {
              accepted = false;
              if(variable.isStatic) {
                if((bindingAttr & BindingFlags2.STATIC) != 0) {
                  if(variable.owner == owner) {
                    accepted = true;
                  }
                }
              } else {
                if((bindingAttr & BindingFlags2.INSTANCE) != 0) {
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
