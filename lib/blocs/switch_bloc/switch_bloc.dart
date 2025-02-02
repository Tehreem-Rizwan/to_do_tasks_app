import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_exports.dart';
part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValue: false)) {
    _loadSwitchState(); // Load state on initialization

    on<SwitchOnEvent>((event, emit) async {
      emit(const SwitchState(switchValue: true));
      await _saveSwitchState(true); // Save state locally
    });

    on<SwitchOffEvent>((event, emit) async {
      emit(const SwitchState(switchValue: false));
      await _saveSwitchState(false); // Save state locally
    });
  }

  /// Save switch state to local storage
  Future<void> _saveSwitchState(bool switchValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switch_state', switchValue);
  }

  /// Load switch state from local storage
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    bool switchValue = prefs.getBool('switch_state') ?? false;
    emit(SwitchState(switchValue: switchValue));
  }
}
