import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitialState(switchValue: false)) {
    on<SwitchUpdateEvent>(_onSwitchUpdate);
  }

  void _onSwitchUpdate(SwitchUpdateEvent event, Emitter emit) {
    final switchValue = !state.switchValue;

    emit(SwitchInitialState(switchValue: switchValue));
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
