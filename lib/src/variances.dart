part of reflection;

class _Variance {
  static const _Variance COVARIANCE = const _Variance("COVARIANCE");

  static const _Variance CONTRAVARIANCE = const _Variance("CONTRAVARIANCE");

  static const _Variance INVARIANCE = const _Variance("INVARIANCE");

  final String name;

  const _Variance(this.name);
}
