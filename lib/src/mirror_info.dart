part of reflection;

abstract class MirrorInfo {
  Mirror get mirror;
}


class _MirrorInfo implements MirrorInfo {
  Mirror _mirror;

  _MirrorInfo({Mirror mirror}) {
    if(mirror == null) {
      throw new ArgumentError("mirror: $mirror");
    }

    _mirror = mirror;
  }

  Mirror get mirror => _mirror;
}
