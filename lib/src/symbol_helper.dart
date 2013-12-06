part of reflection;

abstract class SymbolHelper {
  static String getName(Symbol symbol) {
    return MirrorSystem.getName(symbol);
  }
}
