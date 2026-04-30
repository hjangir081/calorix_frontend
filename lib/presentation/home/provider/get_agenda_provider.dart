import 'package:flutter_riverpod/legacy.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'get_agenda_state.dart';

final agendaProvider =
StateNotifierProvider<AgendaNotifier, AgendaState>(
      (ref) => AgendaNotifier(),
);

class AgendaNotifier extends StateNotifier<AgendaState> {
  AgendaNotifier() : super(const AgendaState());

  final _repo = getIt<ApiRepository>();
  final _tokenStorage = getIt<TokenStorage>();

  Future<void> getDailyAgenda() async {
    state = state.copyWith(status: AgendaStatus.loading);

    try {
      final token = await _tokenStorage.getAccessToken();

      if (token == null || token.isEmpty) {
        state = state.copyWith(
          status: AgendaStatus.error,
          errorMessage: "User not authenticated",
        );
        return;
      }

      final result = await _repo.getAgenda(
        token: 'Bearer $token',
      );

      if (result is DataSuccess) {
        final res = result.data;

        final target = res?.result?.target;
        final consumed = res?.result?.consumed;
        final remaining = res?.result?.remaining;

        state = state.copyWith(
          status: AgendaStatus.success,
          data: AgendaModel(
            caloriesTarget: target?.calories ?? 0,
            caloriesConsumed: consumed?.calories ?? 0,
            caloriesRemaining: remaining?.calories ?? 0,

            proteinTarget: target?.protein ?? 0,
            proteinConsumed: consumed?.protein ?? 0,

            carbsTarget: target?.carbs ?? 0,
            carbsConsumed: consumed?.carbs ?? 0,

            fatTarget: target?.fat ?? 0,
            fatConsumed: consumed?.fat ?? 0,
          ),
        );
      } else if (result is DataFailed) {
        state = state.copyWith(
          status: AgendaStatus.error,
          errorMessage:
          result.exception?.response?.data['Errors']?[0]?['Message'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AgendaStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}