class ApiResult<T> {
  final T data;
  final DateTime updatedAt;
  final bool fromCache;

  const ApiResult({
    required this.data,
    required this.updatedAt,
    this.fromCache = false,
  });
}
