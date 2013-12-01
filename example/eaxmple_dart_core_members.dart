import 'package:reflection/reflection.dart';

void main() {
  var library = TypeHelper.getLibrary(Object);
  var memberTypes = {"accessors": MemberTypes.ACCESSOR, "classes": MemberTypes.CLASS, "methods": MemberTypes.METHOD, "variables": MemberTypes.VARIABLE};
  var modifiers = {"instance": BindingFlags.INSTANCE, "static": BindingFlags.STATIC};
  var accessibilities = {"public": BindingFlags.PUBLIC, "private": BindingFlags.PRIVATE};
  var members = MirrorLibrary.getClasses(library);
  for(var memberTypeKey in memberTypes.keys) {
    var memberType = memberTypes[memberTypeKey];
    for(var modifierKey in modifiers.keys) {
      var modifier = modifiers[modifierKey];
      for(var accessibilityKey in accessibilities.keys) {
        var accessibility = accessibilities[accessibilityKey];
        var members = MirrorLibrary.getMembers(library, flags: modifier | accessibility, members: memberType);
        if(members.isEmpty) {
          continue;
        }

        printMembers("$accessibilityKey $modifierKey $memberTypeKey", members);
      }
    }
  }
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = SymbolHelper.getName(declaration.simpleName);
    print("  $name");
  }
}
