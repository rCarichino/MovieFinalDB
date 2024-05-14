part of 'list_cubit.dart';

sealed class ListState extends Equatable {
  const ListState();
}

final class ListInitial extends ListState {
  @override
  List<Object> get props => [];
}
