// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'homepage_bloc.dart';

class HomepageState extends Equatable {
  final double pageNumber;
  final bool expandMenu;
  const HomepageState({
    this.pageNumber = 3,
    this.expandMenu = true,
  });

  HomepageState copyWith({
    double? pageNumber,
    bool? expandMenu,
  }) {
    return HomepageState(
      pageNumber: pageNumber ?? this.pageNumber,
      expandMenu: expandMenu ?? this.expandMenu,
    );
  }

  @override
  List<Object> get props => [pageNumber, expandMenu];
}
