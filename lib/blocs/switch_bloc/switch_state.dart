part of 'switch_bloc.dart';

class SwitchState {
  final bool switchValue;
  const SwitchState({required this.switchValue});

  Map<String, dynamic> toMap() {
    return {'switchValue': switchValue};
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(switchValue: map['switchValue'] ?? false);
  }
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required bool switchValue}) : super(switchValue: switchValue);
}
