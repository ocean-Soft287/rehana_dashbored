import 'package:equatable/equatable.dart';

abstract class BottomState extends Equatable {
  const BottomState();

  @override
  List<Object?> get props => [];
}

class BottomInitial extends BottomState {
  const BottomInitial();
}

class BottomItemSelected extends BottomState {
  final int index;

  const BottomItemSelected(this.index);

  @override
  List<Object?> get props => [index];
}
class BottomItemSelectedfinnance extends BottomState{

final int finance;

const BottomItemSelectedfinnance(this.finance);

@override
List<Object?> get props => [finance];

}

class Changevillanumber extends BottomState{}

class BottomSubItemSelected extends BottomState {
  final int mainIndex;
  final int subIndex;

  const BottomSubItemSelected(this.mainIndex, this.subIndex);

  @override
  List<Object?> get props => [mainIndex, subIndex];
}