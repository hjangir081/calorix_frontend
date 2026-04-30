enum AgendaStatus { initial, loading, success, error }

class AgendaModel {
  final int caloriesTarget;
  final int caloriesConsumed;
  final int caloriesRemaining;

  final int proteinTarget;
  final int proteinConsumed;

  final int carbsTarget;
  final int carbsConsumed;

  final int fatTarget;
  final int fatConsumed;

  AgendaModel({
    required this.caloriesTarget,
    required this.caloriesConsumed,
    required this.caloriesRemaining,
    required this.proteinTarget,
    required this.proteinConsumed,
    required this.carbsTarget,
    required this.carbsConsumed,
    required this.fatTarget,
    required this.fatConsumed,
  });
}

class AgendaState {
  final AgendaStatus status;
  final AgendaModel? data;
  final String? errorMessage;

  const AgendaState({
    this.status = AgendaStatus.initial,
    this.data,
    this.errorMessage,
  });

  AgendaState copyWith({
    AgendaStatus? status,
    AgendaModel? data,
    String? errorMessage,
  }) {
    return AgendaState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }
}