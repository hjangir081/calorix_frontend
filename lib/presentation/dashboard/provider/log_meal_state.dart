class LogMealState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const LogMealState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LogMealState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LogMealState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}