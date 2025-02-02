import 'package:to_do_task_app/blocs/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValue: false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(const SwitchState(switchValue: true));
    });
    on<SwitchOffEvent>((event, emit) {
      emit(const SwitchState(switchValue: false));
    });
  }
  @override
  List<Object?> get props => throw UnimplementedError();
}
