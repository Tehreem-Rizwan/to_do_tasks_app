part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchValue;
  const SwitchState(this.switchValue);

  @override
  List<Object> get props => [];
}

class SwitchInitial extends SwitchState {
  SwitchInitial(super.switchValue);
}
