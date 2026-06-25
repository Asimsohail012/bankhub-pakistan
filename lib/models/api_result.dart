class ApiResult<T> {
  final T? data;
  final DateTime updatedAt;
  final bool fromCache;
  final String? error;
  final bool isSuccess;

  const ApiResult({
    this.data,
    required this.updatedAt,
    this.fromCache = false,
    this.error,
    this.isSuccess = true,
  });

  factory ApiResult.success(T? data) {
    return ApiResult<T>(
      data: data,
      updatedAt: DateTime.now(),
      error: null,
      isSuccess: true,
    );
  }

  factory ApiResult.error(String errorMessage) {
    return ApiResult<T>(
      data: null,
      updatedAt: DateTime.now(),
      error: errorMessage,
      isSuccess: false,
    );
  }
}

