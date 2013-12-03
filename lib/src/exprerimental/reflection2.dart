part of reflection;

abstract class Reflection2 {
  static final Reflection2 current = new _Reflection2();

  IsolateInfo get isolate;

  MirrorSystem get mirror;
}

class _Reflection2 implements Reflection2 {
  IsolateInfo _isolate;

  MirrorSystem _mirror;

  _Reflection2() {
    _mirror = currentMirrorSystem();
  }

  IsolateInfo get isolate {
    if(_isolate == null) {
      _isolate = _reflectIsolate();
    }

    return _isolate;
  }

  MirrorSystem get mirror => _mirror;

  IsolateInfo _reflectIsolate() {
    return new _IsolateInfo(reflection : this);
  }
}
