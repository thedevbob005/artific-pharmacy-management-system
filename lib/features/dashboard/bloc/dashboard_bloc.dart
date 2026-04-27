import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../repository/dashboard_repository.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  const DashboardState({required this.status, this.metrics, this.error});

  const DashboardState.initial()
      : status = DashboardStatus.initial,
        metrics = null,
        error = null;

  final DashboardStatus status;
  final DashboardMetrics? metrics;
  final String? error;

  DashboardState copyWith({DashboardStatus? status, DashboardMetrics? metrics, String? error}) {
    return DashboardState(
      status: status ?? this.status,
      metrics: metrics ?? this.metrics,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, metrics, error];
}

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class DashboardStarted extends DashboardEvent {
  const DashboardStarted();
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({DashboardRepository? repository})
      : _repository = repository ?? DashboardRepository(),
        super(const DashboardState.initial()) {
    on<DashboardStarted>(_onStarted);
  }

  final DashboardRepository _repository;

  Future<void> _onStarted(DashboardStarted event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: DashboardStatus.loading, error: null));
    try {
      final metrics = await _repository.loadMetrics();
      emit(state.copyWith(status: DashboardStatus.loaded, metrics: metrics));
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.error, error: 'Unable to load dashboard.'));
    }
  }
}
